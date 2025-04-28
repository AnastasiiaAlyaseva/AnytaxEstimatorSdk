import Foundation

public enum AnalyticsScreen: String {
    case welcome
    case taxEstimator
    case optionalQuestions
    case marriageTaxStatus
    case partnersDetails
    case partnersOptionalQuestions
    case taxResult
    
    public var screenName: String {
        switch self {
        case .welcome:
            "Welcome Screen"
        case .taxEstimator:
            "Tax Estimator Screen"
        case .optionalQuestions:
            "Optional Questions Screen"
        case .marriageTaxStatus:
            "Marriage Tax Status Screen"
        case .partnersDetails:
            "Partners Details Screen"
        case .partnersOptionalQuestions:
            "Partners Optional Questions Screen"
        case .taxResult:
            "Tax Result Screen"
        }
    }
}
