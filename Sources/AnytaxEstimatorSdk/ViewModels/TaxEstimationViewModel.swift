import Foundation
import Combine

final class TaxEstimationViewModel: ObservableObject {
    let config: AnytaxEstimatorConfig
    
    @Published private(set) var isLoading: Bool
    @Published private(set) var errorMessage: String?
    @Published private(set) var taxEstimationResults: TaxEstimationResultsData?
    @Published var taxEstimationInputData: TaxEstimationInputData
    
    private let taxEstimationService: TaxEstimationServiceProtocol
    private let updateQueue = DispatchQueue(label: "com.AnytaxEstimator.TaxEstimationViewModel.updateQueue")
    
    // MARK: - Init
    
    init(
        config: AnytaxEstimatorConfig,
        isLoading: Bool,
        errorMessage: String?,
        taxEstimationResults: TaxEstimationResultsData?,
        taxEstimationInputData: TaxEstimationInputData,
        taxEstimationService: TaxEstimationServiceProtocol
    ) {
        self.config = config
        self.isLoading = isLoading
        self.errorMessage = errorMessage
        self.taxEstimationResults = taxEstimationResults
        self.taxEstimationInputData = taxEstimationInputData
        self.taxEstimationService = taxEstimationService
    }
    
    convenience init(config: AnytaxEstimatorConfig) {
        self.init(
            config: config,
            isLoading: false,
            errorMessage: nil,
            taxEstimationResults: nil,
            taxEstimationInputData: TaxEstimationInputData(),
            taxEstimationService: TaxEstimationService(apiKey: config.apiKey)
        )
    }
    
    // MARK: - Actions
    
    func getTaxEstimations() {
        guard !isLoading else { return }
        
        isLoading = true
        errorMessage = nil
        taxEstimationResults = nil
        
        let request = TaxEstimationRequest(inputData: taxEstimationInputData)
        taxEstimationService.fetchTaxEstimate(request: request) { [weak self] response, error in
            self?.updateQueue.async {
                DispatchQueue.main.async {
                    self?.isLoading = false
                    if let response {
                        self?.taxEstimationResults = TaxEstimationResultsData(
                            estimatedTaxValue: response.estimatedTax
                        )
                    } else if error != nil {
                        self?.errorMessage = AppConstants.Api.errorMessage
                    }
                }
            }
        }
    }
}
