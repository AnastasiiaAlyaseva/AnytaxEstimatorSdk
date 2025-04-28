import Foundation

enum FocusField: Hashable {
    
    // TaxEstimatorScreen
    case income
    case distance
    case workDays
    case children
    
    // PartnersOptionalQuestionsScreen
    case spouseHouseholdServices
    case spouseWorkExpenses
    case spouseSpecialExpenses
    
    // PartnersDetailsScreen
    case spouseIncome
    case spouseDistanceToWork
    case spouseWorkFromHomeDays
    
    // OptionalQuestionsScreen
    case householdServices
    case workExpenses
    case specialExpenses
    case taxWithheld
}
