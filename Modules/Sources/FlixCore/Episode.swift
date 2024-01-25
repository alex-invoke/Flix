//
//  File.swift
//  
//
//  Created by alex on 1/15/24.
//

import Foundation

// MARK: - Episode
public struct Episode: Codable, Identifiable {
    public let airDate: String?
    public let crew: [Crew]?
    public let episodeNumber: Int
    public let guestStars: [Crew]?
    public let name: String
    public let overview: String
    public let id: Int
    public let productionCode: String
    public let runtime: Int?
    public let seasonNumber: Int
    public let stillPath: String?
    public let voteAverage: Double
    public let voteCount: Int
}

public extension Episode {
    var stillURL: URL? {
        guard let stillPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/original\(stillPath)")
    }
}

// MARK: - Crew
public struct Crew: Codable {
    public let department: String?
    public let job: String?
    public let creditID: String?
    public let adult: Bool
    public let gender, id: Int
    public let knownForDepartment: String?
    public let name: String
    public let originalName: String
    public let popularity: Double
    public let profilePath: String?
    public let character: String?
    public let order: Int?
}

public enum Department: String, Codable {
    case acting = "Acting"
    case camera = "Camera"
    case directing = "Directing"
    case editing = "Editing"
    case writing = "Writing"
    case sound = "Sound"
    case crew = "Crew"
    case art = "Art"
}
