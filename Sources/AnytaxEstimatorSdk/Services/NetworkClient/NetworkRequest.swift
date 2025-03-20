import Foundation

struct NetworkRequest {
    let endpoint: String
    let httpMethod: String
    let queryItems: [URLQueryItem]?
    let timeoutInterval: TimeInterval
    let allHTTPHeaderFields: [String: String]?
}
