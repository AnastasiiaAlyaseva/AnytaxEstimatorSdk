import Foundation

protocol TaxEstimationServiceProtocol: AnyObject {
    func fetchTaxEstimate(
        request: TaxEstimationRequest,
        completion: @escaping (TaxEstimationResponse?, Error?) -> Void
    )
}

final class TaxEstimationService: TaxEstimationServiceProtocol {
    private let networkClient: NetworkClientProtocol
    private let endpoint = "/estimator"
    
    // MARK: - Init
    
    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }
    
    convenience init() {
        self.init(networkClient: NetworkClient())
    }
    
    // MARK: - TaxEstimationServiceProtocol
    
    func fetchTaxEstimate(
        request: TaxEstimationRequest,
        completion: @escaping (TaxEstimationResponse?, Error?) -> Void
    ) {
        let queryItems = buildQueryItems(request: request)
        let networkRequest = NetworkRequest(
            endpoint: endpoint,
            httpMethod: "GET",
            queryItems: queryItems,
            timeoutInterval: 20,
            allHTTPHeaderFields: ["accept": "application/json"]
        )
        
        networkClient.request(networkRequest) { (result: Result<TaxEstimationResponse, Error>) in
            switch result {
            case .success(let response):
                completion(response, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    // MARK: - Private
    
    private func buildQueryItems(request: TaxEstimationRequest) -> [URLQueryItem] {
        [
            URLQueryItem(name: "income", value: request.income),
            URLQueryItem(name: "distanceToWork", value: request.distanceToWork),
            URLQueryItem(name: "workFromHomeDays", value: request.workFromHomeDays),
            URLQueryItem(name: "married", value: request.married ? "true" : "false"),
            URLQueryItem(name: "children", value: request.children),
            URLQueryItem(name: "workExpenses", value: request.workExpenses),
            URLQueryItem(name: "specialExpenses", value: request.specialExpenses),
            URLQueryItem(name: "taxWithheld", value: request.taxWithheld),
            URLQueryItem(name: "householdServices", value: request.householdServices),
            URLQueryItem(name: "spouseIncome", value: request.spouseIncome),
            URLQueryItem(name: "spouseDistanceToWork", value: request.spouseDistanceToWork),
            URLQueryItem(name: "spouseWorkFromHomeDays", value: request.spouseWorkFromHomeDays),
            URLQueryItem(name: "spouseWorkExpenses", value: request.spouseWorkExpenses),
            URLQueryItem(name: "spouseSpecialExpenses", value: request.spouseSpecialExpenses),
            URLQueryItem(name: "spouseHouseholdServices", value: request.spouseHouseholdServices),
        ].filter { $0.value != nil }
    }
}
