//
//  File.swift
//  
//
//  Created by alex on 1/15/24.
//

import Foundation


public struct Series: Codable, Identifiable {
    public let adult: Bool
    public let backdropPath: String?
    public let firstAirDate: Date?
    public let genreIds: [Int]
    public let id: Int
    public let name: String
    public let originCountry: [String]
    public let originalLanguage: String
    public let originalName: String
    public let overview: String
    public let popularity: Double
    public let posterPath: String?
    public let voteAverage: Double
    public let voteCount: Int
}

public extension Series {
    var posterURL: URL? {
        guard let posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/original\(posterPath)")
    }
    
    var backdropURL: URL? {
        guard let backdropPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/original\(backdropPath)")
    }
}


// MARK: - Series
public struct SeriesDetails: Codable, Identifiable {
    public let adult: Bool
    public let backdropPath: String?
    public let createdBy: [Creator]
    public let episodeRunTime: [Int]
    public let firstAirDate: Date?
    public let genres: [Genre]
    public let homepage: String?
    public let id: Int
    public let inProduction: Bool
    public let languages: [String]
    public let lastAirDate: Date?
    public let lastEpisodeToAir: Episode?
    public let name: String
    public let nextEpisodeToAir: Episode?
    public let networks: [Network]
    public let numberOfEpisodes: Int
    public let numberOfSeasons: Int
    public let originCountry: [String]
    public let originalLanguage: String
    public let originalName: String
    public let overview: String
    public let popularity: Double
    public let posterPath: String?
    public let productionCompanies: [Network]
    public let productionCountries: [ProductionCountry]
    public let seasons: [Season]
    public let spokenLanguages: [SpokenLanguage]
    public let status, tagline, type: String
    public let voteAverage: Double
    public let voteCount: Int
}

public extension SeriesDetails {
    var posterURL: URL? {
        guard let posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/original\(posterPath)")
    }
    
    var backdropURL: URL? {
        guard let backdropPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/original\(backdropPath)")
    }
    
    var genresString: String {
        return genres.map { $0.name }.joined(separator: ", ")
    }
}


// MARK: - CreatedBy
public struct Creator: Codable, Identifiable {
    public let id: Int
    public let creditId: String
    public let name: String
    public let gender: Int
    public let profilePath: String?
}

// MARK: - Genre
public struct Genre: Codable, Identifiable {
    public let id: Int
    public let name: String
}

// MARK: - Network
public struct Network: Codable, Identifiable {
    public let id: Int
    public let logoPath: String?
    public let name: String
    public let originCountry: String
}

// MARK: - ProductionCountry
public struct ProductionCountry: Codable {
    public let iso_3166_1: String?
    public let name: String
}

// MARK: - Season
public struct Season: Codable, Identifiable, Equatable {
    public let id: Int
    public let airDate: String?
    public let episodeCount: Int
    public let name: String
    public let overview: String
    public let posterPath: String?
    public let seasonNumber: Int
    public let voteAverage: Double
}

public struct SeasonDetails: Codable, Identifiable {
    public let id: Int
    public let airDate: String?
    public let name: String
    public let overview: String
    public let posterPath: String?
    public let seasonNumber: Int
    public let voteAverage: Double
    public let episodes: [Episode]
}

// MARK: - SpokenLanguage
public struct SpokenLanguage: Codable {
    public let englishName: String
    public let iso_639_1: String?
    public let name: String
}
