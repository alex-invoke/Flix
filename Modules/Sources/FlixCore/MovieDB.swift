//
//  File.swift
//  
//
//  Created by alex on 1/10/24.
//

import Foundation
import Network

extension DateFormatter {
    static let yyyyMMdd: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}

extension JSONDecoder {
    static var movieDBDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(.yyyyMMdd)
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}

extension JSONEncoder {
    static var movieDBEncoder: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(.yyyyMMdd)
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }
}

extension URLSessionConfiguration {
    static func movieDBSessionConfiguration(token: String) -> URLSessionConfiguration {
        let sessionConfig =  URLSessionConfiguration.default
        sessionConfig.httpAdditionalHeaders = ["Authorization": "Bearer \(token)"]
        return sessionConfig
    }
}

extension APIConfiguration {
    static func movieDBConfiguration(token: String) -> APIConfiguration {
        APIConfiguration(baseURLString: "https://api.themoviedb.org", decoder: .movieDBDecoder, encoder: .movieDBEncoder, sessionConfiguration: .movieDBSessionConfiguration(token: token))
    }
}

public struct MovieDB {
    public enum TimeWindow: String, CustomStringConvertible {
        case day
        case week
        public var description: String {
            self.rawValue
        }
    }
    
    public var trending: (TimeWindow) async throws -> [Series]
    public var popular: (TimeWindow) async throws -> [Series]
    public var series: (Int) async throws -> SeriesDetails
    public var season: (Int, Int) async throws -> SeasonDetails
}

public extension MovieDB {
    struct Response<T: Codable>: Codable {
        let page: Int
        let results: T
        let totalPages: Int
        let totalResults: Int
    }
    
    static func live(token: String) -> MovieDB {
        let client = APIClient(configuration: APIConfiguration.movieDBConfiguration(token: token))
        return MovieDB { window in
            let response: Response<[Series]> = try await client.send(for: .trending(window: window))
            return response.results
        } popular: { window in
            let response: Response<[Series]> = try await client.send(for: .popular())
            return response.results
        } series: { seriesId in
            try await client.send(for: .seriesDetails(id: seriesId))
        } season: { seriesId, seasonId in
            try await client.send(for: .season(series: seriesId, season: seasonId))
        }
    }
}

#if DEBUG

import UIKit

public extension MovieDB {
    static func mock() -> MovieDB {
        return MovieDB { window in
            guard let asset = NSDataAsset(name: "trending") else { fatalError("Missing data asset: trending") }
            let response: Response<[Series]> = try JSONDecoder.movieDBDecoder.decode(Response<[Series]>.self, from: asset.data)
            return response.results
        } popular: { window in
            guard let asset = NSDataAsset(name: "popular") else { fatalError("Missing data asset: popular") }
            let response: Response<[Series]> = try JSONDecoder.movieDBDecoder.decode(Response<[Series]>.self, from: asset.data)
            return response.results
        } series: { series in
            guard let asset = NSDataAsset(name: "series") else { fatalError("Missing data asset: series") }
            let response: SeriesDetails = try JSONDecoder.movieDBDecoder.decode(SeriesDetails.self, from: asset.data)
            return response
        } season: { series, season in
            guard let asset = NSDataAsset(name: "season") else { fatalError("Missing data asset: popular") }
            let response: SeasonDetails = try JSONDecoder.movieDBDecoder.decode(SeasonDetails.self, from: asset.data)
            return response
        }
    }
}

#endif

extension Endpoint {
    static func trending(window: MovieDB.TimeWindow) -> Self {
        Endpoint(path: "/3/trending/tv/\(window.rawValue)")
    }
    
    static func popular() -> Self {
        Endpoint(path: "/3/tv/popular")
    }
    
    static func seriesDetails(id: Int) -> Self {
        Endpoint(path: "/3/tv/\(id)")
    }
    
    static func season(series: Int, season: Int) -> Self {
        Endpoint(path: "/3/tv/\(series)/season/\(season)")
    }
}
