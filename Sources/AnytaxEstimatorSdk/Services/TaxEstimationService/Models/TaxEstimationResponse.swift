import Foundation

struct TaxEstimationResponse: Codable {
    let estimatedTax: Double
    let taxableIncome: Double
    let taxBeforeWithholding: Double
    let finalTaxDue: Double
}
