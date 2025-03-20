import Foundation

struct TaxEstimationResultsData {
    let estimatedTaxValue: Double
    
    var displayValue: String {
        "\(Int(estimatedTaxValue)) €"
    }
}
