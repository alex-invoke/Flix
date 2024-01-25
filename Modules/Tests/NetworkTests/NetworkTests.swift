import XCTest
@testable import Network

final class NetworkTests: XCTestCase {
    func testEndpoint() throws {
        let endpoint = Endpoint(host: "api.openweathermap.org", path: "data/3.0/onecall", params: [
            "lat": "99.3",
            "lon": "-30.7",
            "units": "imperial"
        ])
        guard let request = endpoint.makeRequest() else {
            XCTFail("Failed to make request from Endpoint")
            return
        }
        
        XCTAssertEqual(request.url?.host, "api.openweathermap.org")
        XCTAssertEqual(request.url?.scheme, "https")
        XCTAssertEqual(request.url?.path, "/data/3.0/onecall")
        
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
