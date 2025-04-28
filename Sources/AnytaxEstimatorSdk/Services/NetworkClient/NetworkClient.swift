import Foundation

protocol NetworkClientProtocol: AnyObject {
    func request<T: Decodable>(
        _ request: NetworkRequest,
        completion: @escaping (Result<T, Error>) -> Void
    )
}

final class NetworkClient: NetworkClientProtocol {
    private let session: URLSession
    private let baseUrl: URL?
    
    // MARK: - Init
    
    init(
        session: URLSession,
        baseUrl: URL?
    ) {
        self.session = session
        self.baseUrl = baseUrl
    }
    
    convenience init() {
        self.init(
            session: .shared,
            baseUrl: URL(string: AppConstants.Api.baseUrlString)
        )
    }
    
    // MARK: - NetworkClientProtocol
    
    func request<T: Decodable>(
        _ request: NetworkRequest,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let baseUrl,
              let url = URL(string: request.endpoint, relativeTo: baseUrl),
              var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        else {
            completion(.failure(NSError(domain: "Invalid Url creation", code: 0, userInfo: nil)))
            return
        }
        
        components.queryItems = request.queryItems
        guard let urlWithComponents = components.url else {
            completion(.failure(NSError(domain: "Invalid Url with components", code: 0, userInfo: nil)))
            return
        }
        
        var urlRequest = URLRequest(url: urlWithComponents)
        urlRequest.httpMethod = request.httpMethod
        urlRequest.timeoutInterval = request.timeoutInterval
        urlRequest.allHTTPHeaderFields = request.allHTTPHeaderFields
        
        #if DEBUG
        print("Request: \(urlRequest)")
        #endif
        
        performRequest(urlRequest, completion: completion)
    }
    
    private func performRequest<T: Decodable>(
        _ urlRequest: URLRequest,
        completion: @escaping (Result<T, Error>) -> Void
    ){
        session.dataTask(with: urlRequest) { data, response, error in
            if let error {
                completion(.failure(error))
                return
            }
            
            guard let data else {
                completion(.failure(NSError(domain: "DataError", code: 0, userInfo: nil)))
                return
            }
            
        #if DEBUG
            if let jsonString = String(data: data, encoding: .utf8) {
                print("JSON Response: \(jsonString)")
            }
        #endif
            
            do {
                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedResponse))
            } catch let decodingError as DecodingError {
        #if DEBUG
                switch decodingError {
                case .typeMismatch(let type, let context):
                    print("Type mismatch for type: \(type), context: \(context.debugDescription)")
                case .valueNotFound(let type, let context):
                    print("Value not found for type: \(type), context: \(context.debugDescription)")
                case .keyNotFound(let key, let context):
                    print("Key '\(key.stringValue)' not found, context: \(context.debugDescription)")
                case .dataCorrupted(let context):
                    print("Data corrupted, context: \(context.debugDescription)")
                @unknown default:
                    print("Unknown decoding error: \(decodingError)")
                }
        #endif
                completion(.failure(decodingError))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
