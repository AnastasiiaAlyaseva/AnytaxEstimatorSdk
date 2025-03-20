import Foundation

struct TaxEstimationRequest: Codable {
    let income: String
    let distanceToWork: String
    let workFromHomeDays: String
    let workExpenses: String?
    let specialExpenses: String?
    let taxWithheld: String?
    let married: Bool
    let children: String
    let householdServices: String?
    let spouseIncome: String?
    let spouseDistanceToWork: String?
    let spouseWorkFromHomeDays: String?
    let spouseWorkExpenses: String?
    let spouseSpecialExpenses: String?
    let spouseHouseholdServices: String?
    
    init(inputData: TaxEstimationInputData) {
        self.income = inputData.income
        self.distanceToWork = inputData.distanceToWork
        self.workFromHomeDays = inputData.workFromHomeDays
        self.workExpenses = inputData.workExpenses.isEmpty ? nil : inputData.workExpenses
        self.specialExpenses = inputData.specialExpenses.isEmpty ? nil : inputData.specialExpenses
        self.taxWithheld = inputData.taxWithheld.isEmpty ? nil : inputData.taxWithheld
        self.married = inputData.married
        self.children = inputData.children
        self.householdServices = inputData.householdServices.isEmpty ? nil : inputData.householdServices
        self.spouseIncome = inputData.spouseIncome.isEmpty ? nil : inputData.spouseIncome
        self.spouseDistanceToWork = inputData.spouseDistanceToWork.isEmpty ? nil : inputData.spouseDistanceToWork
        self.spouseWorkFromHomeDays = inputData.spouseWorkFromHomeDays.isEmpty ? nil : inputData.spouseWorkFromHomeDays
        self.spouseWorkExpenses = inputData.spouseWorkExpenses.isEmpty ? nil : inputData.spouseWorkExpenses
        self.spouseSpecialExpenses = inputData.spouseSpecialExpenses.isEmpty ? nil : inputData.spouseSpecialExpenses
        self.spouseHouseholdServices = inputData.spouseHouseholdServices.isEmpty ? nil : inputData.spouseHouseholdServices
    }
}
