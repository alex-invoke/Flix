import XCTest
@testable import Network

final class NetworkTests: XCTestCase {
    let client = APIClient(configuration: .init(baseURLString: "https://httpbin.org"))
    func testRequest() throws {
        let get = Endpoint(path: "/json")
        let request = try? client.makeRequest(for: get)
        XCTAssertNotNil(request)
        XCTAssertNotNil(request?.url)
        XCTAssertEqual(request?.url?.absoluteString ?? "", "https://httpbin.org/json")
    }
    
    func testBadPath() throws {
        let get = Endpoint(path: "json")
        XCTAssertThrowsError(try client.makeRequest(for: get))
    }
    
    func testForecastEndpoint() throws {
//        guard let request = Endpoint.forecast(lat: 99.3, lon: -30.7).makeRequest() else {
//            XCTFail("Failed to make request from Endpoint")
//            return
//        }
//        
//        XCTAssertEqual(request.url?.host, "api.openweathermap.org")
//        XCTAssertEqual(request.url?.scheme, "https")
//        XCTAssertEqual(request.url?.path, "/data/3.0/onecall")
        
    }
}
