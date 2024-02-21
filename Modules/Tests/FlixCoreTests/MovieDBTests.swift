import XCTest
@testable import FlixCore

final class MovieDBTests: XCTestCase {
    
    func testConfiguration() throws {
        let client = MovieDBClient(token: "TEST")
        XCTAssertEqual(client.configuration.baseURL, URL(string: "https://api.themoviedb.org"))
    }
    
    func testRequest() throws {
        let client =  MovieDBClient(token: "TEST")
        let request = try client.makeRequest(for: .popular(), with: client.configuration)
        XCTAssertEqual(request.url?.absoluteString, "https://api.themoviedb.org/3/tv/popular")
    }
}
