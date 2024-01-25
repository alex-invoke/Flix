//
//  Created by alex on 1/10/24.
//

import Foundation

public enum HTTPMethod: String, CustomStringConvertible {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
    case patch = "PATCH"
    
    public var description: String {
        return self.rawValue
    }
}

public enum APIError: Error, CustomStringConvertible {
    case badRequest
    case nonHTTPResponse
    case requestFailed(Int)
    case serverError(Int)
    case networkError(Error)
    case decodingError(DecodingError)
    
    public var isRetriable: Bool {
        switch self {
        case .decodingError:
            return false
            
        case .requestFailed(let status):
            let timeoutStatus = 408
            let rateLimitStatus = 429
            return [timeoutStatus, rateLimitStatus].contains(status)
            
        case .serverError, .networkError, .nonHTTPResponse:
            return true
        case .badRequest:
            return false
        }
    }
    
    public var description: String {
        switch self {
        case .badRequest: return "Bad Request"
        case .nonHTTPResponse: return "Non-HTTP response received"
        case .requestFailed(let status): return "Received HTTP \(status)"
        case .serverError(let status): return "Server Error - \(status)"
        case .networkError(let error): return "Failed to load the request: \(error)"
        case .decodingError(let error): return "Failed to process response: \(error)"
        }
    }
}

public struct Endpoint {
    public var method: HTTPMethod
    public var path: String
    public var params: [String: String?]
    public var headers: [String: String]
    public var body: Encodable?
    
    public var queryItems: [URLQueryItem] {
        params.map { URLQueryItem(name: $0, value: $1) }
    }
    
    public init(_ method: HTTPMethod = .get, path: String, params: [String : String?] = [:], headers: [String : String] = [:], body: Encodable? = nil) {
        self.method = method
        self.path = path
        self.params = params
        self.headers = headers
        self.body = body
    }
}

//public extension Endpoint {
//    func makeRequest(baseURL: URL, additionHeaders: [String: String] = [:]) -> URLRequest? {
//        guard var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false) else { fatalError("invalid base url") }
//        let queryItems = params.map { URLQueryItem(name: $0, value: $1) }
//        //var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)
////        components.scheme = "https"
////        components.host = host
//        components.path = path
//        components.queryItems = queryItems.isEmpty ? nil : queryItems
//        
//        // If either the path or the query items passed contained
//        // invalid characters, we'll get a nil URL back:
//        guard let url = components.url else { return nil }
//        var request = URLRequest(url: url)
//        request.httpMethod = method.description
//        for header in additionHeaders {
//            request.setValue(header.value, forHTTPHeaderField: header.key)
//        }
//        headers.forEach { request.addValue($1, forHTTPHeaderField: $0)}
//        return request
//    }
//}

//public protocol APIClient {
//    var baseURL: URL { get }
//    var additionalHeaders: [String:String] { get }
//    var decoder: JSONDecoder { get }
//    var configuration: APIConfiguration { get }
//    
//    func fetch<T: Codable>(type: T.Type, with endpoint: Endpoint) async throws -> T
//}

/*
 send - GET/POST/PUT/DELETE
 upload - file upload
 download - file download
 */

public struct APIClient {
    var configuration: APIConfiguration //{ get }
    
    public init(configuration: APIConfiguration) {
        self.configuration = configuration
    }
    
//    func send<T>(with endpoint: Endpoint, configure: ((inout URLRequest) throws -> Void)?) async throws -> T where T: Decodable
//    func makeRequest(for endpoint: Endpoint, with configuration: APIConfiguration) throws -> URLRequest
//}

//public extension APIClient {
    public func send<T>(for endpoint: Endpoint, configure: ((inout URLRequest) throws -> Void)? = nil) async throws -> T where T: Decodable {
        var request = try makeRequest(for: endpoint)
        try configure?(&request)
        let (data, response) = try await configuration.session.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else { throw APIError.nonHTTPResponse }
        guard httpResponse.statusCode >= 200 && httpResponse.statusCode < 400 else { throw APIError.requestFailed(httpResponse.statusCode) }
        
        do {
            return try configuration.decoder.decode(T.self, from: data)
        } catch let error as DecodingError {
            throw APIError.decodingError(error)
        } catch {
            throw APIError.networkError(error)
        }
    }
    
    public func makeRequest(for endpoint: Endpoint) throws -> URLRequest {
        guard let url = configuration.baseURL, var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { throw APIError.badRequest }
        let queryItems = endpoint.params.map { URLQueryItem(name: $0, value: $1) }
        components.path = endpoint.path
        components.queryItems = endpoint.queryItems.isEmpty ? nil : queryItems
        
        // If either the path or the query items passed contained
        // invalid characters, we'll get a nil URL back:
        guard let url = components.url else { throw APIError.badRequest }
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.description
        if let body = endpoint.body {
            request.httpBody = try configuration.encoder.encode(body)
        }
        endpoint.headers.forEach { request.addValue($1, forHTTPHeaderField: $0)}
        return request
    }
}

public struct APIConfiguration {
    public var baseURL: URL?
    public var decoder: JSONDecoder
    public var encoder: JSONEncoder
    public var sessionConfiguration: URLSessionConfiguration
    
    public var session: URLSession {
        URLSession(configuration: sessionConfiguration)
    }
    
    public init(baseURLString: String, decoder: JSONDecoder = JSONDecoder(), encoder: JSONEncoder = JSONEncoder(), sessionConfiguration: URLSessionConfiguration = .default) {
        self.init(baseURL: URL(string: baseURLString), decoder: decoder, encoder: encoder, sessionConfiguration: sessionConfiguration)
    }
    
    public init(baseURL: URL?, decoder: JSONDecoder = JSONDecoder(), encoder: JSONEncoder = JSONEncoder(), sessionConfiguration: URLSessionConfiguration = .default) {
        self.baseURL = baseURL
        self.decoder = decoder
        self.encoder = encoder
        self.sessionConfiguration = sessionConfiguration
    }
}


