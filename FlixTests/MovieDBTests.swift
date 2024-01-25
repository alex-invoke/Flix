//
//  MovieDBTests.swift
//  FlixTests
//
//  Created by alex on 1/23/24.
//

import XCTest
@testable import Flix
@testable import MovieDB

final class MovieDBTests: XCTestCase {
    
    func testConfiguration() throws {
        let client = MovieDBClient(token: "TEST")
        XCTAssertEqual(client.configuration.baseURL, URL(string: "https://api.themoviedb.org"))
    }
    
    func testRequest() throws {
        let client = MovieDBClient(token: "TEST")
        let request = try client.makeRequest(for: .popular(), with: client.configuration)
        XCTAssertEqual(request.url?.absoluteString, "https://api.themoviedb.org/3/tv/popular")
    }
}
