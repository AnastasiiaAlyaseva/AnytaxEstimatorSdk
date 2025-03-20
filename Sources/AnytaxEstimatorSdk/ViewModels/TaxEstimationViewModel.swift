import Foundation
import Combine

final class TaxEstimationViewModel: ObservableObject {
    @Published var isLoading: Bool
    @Published var errorMessage: String?
    @Published var taxEstimationResults: TaxEstimationResultsData?
    @Published var taxEstimationInputData: TaxEstimationInputData
    let onFinishFlow: () -> Void
    
    private let taxEstimationService: TaxEstimationServiceProtocol
    private let updateQueue = DispatchQueue(label: "com.AnytaxEstimator.TaxEstimationViewModel.updateQueue")
    
    // MARK: - Init
    
    init(
        isLoading: Bool,
        errorMessage: String?,
        taxEstimationResults: TaxEstimationResultsData?,
        taxEstimationInputData: TaxEstimationInputData,
        taxEstimationService: TaxEstimationServiceProtocol,
        onFinishFlow: @escaping () -> Void
    ) {
        self.isLoading = isLoading
        self.errorMessage = errorMessage
        self.taxEstimationResults = taxEstimationResults
        self.taxEstimationInputData = taxEstimationInputData
        self.taxEstimationService = taxEstimationService
        self.onFinishFlow = onFinishFlow
    }
    
    convenience init(onFinishFlow: @escaping () -> Void) {
        self.init(
            isLoading: false,
            errorMessage: nil,
            taxEstimationResults: nil,
            taxEstimationInputData: TaxEstimationInputData(),
            taxEstimationService: TaxEstimationService(),
            onFinishFlow: onFinishFlow
        )
    }
    
    // MARK: - Actions
    
    func getTaxEstimations() {
        isLoading = true
        errorMessage = nil
        
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
                        self?.errorMessage = AppConstatns.Api.errorMessage
                    }
                }
            }
        }
    }
}
