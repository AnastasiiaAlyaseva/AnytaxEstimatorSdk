import SwiftUI

struct AppConstatns {
    static let anytax = AttributedString("any") + "tax".bolded
    static let navigationBarTitle = String(localized: "get_estimate_button_title")
    
    struct Common {
        static let optionalAmountPlaceholder = String(localized: "optional").italicized
            + String(localized: "dash").asAttributedString
            + String(localized: "enter_amount").asAttributedString
        
        static let keyboardToolbarButtonTitle = String(localized: "key_board_Toolbar_Button_Title")
        static let yesButtonTitle = String(localized: "yes_button_title")
        static let noButtonTitle =  String(localized: "no_button_title")
        static let getEstimateButtonTitle = String(localized:"button_get_estimate")
        static let minimizeButtonTitle = String(localized: "minimize_ButtonTitle")
        static let learnMoreButtonTitle = String(localized: "learn_more_ButtonTitle")
        
        static let yearlyGrossIncomePlaceholder = String(localized: "enter_amount").asAttributedString
        static let distanceToWorkPlaceholder = String(localized: "distance_to_work").asAttributedString
        static let workFromHomeDaysPlaceholder = String(localized: "work_from_home_days").asAttributedString
    }
    
    struct Api {
        static let baseUrlString = "https://api.anytax.io"
        static let errorMessage = String(localized: "error_message")
    }
    
    struct AlmostDoneView {
        static let title = String(localized: "almost_done")
        static let subtitle = String(localized: "almost_done_hint")
    }
    
    struct MarriageQuestionView {
        static let title = String(localized: "question_5")
        static let explanation = String(localized: "question_5_hint")
        
    }
    
    struct WelcomeScreen {
        static let estimatorTitle = String(localized:"estimator_Title")
        static let getEstimateButtonTitle = String(localized:"get_Estimate_ButtonTitle")
    }
    
    struct TaxEstimatorScreen {
        static let titleHeaderView = String(localized:"caption")
        static let subtitleHeaderView = String(localized:"caption_hint")
        
        static let yearlyGrossIncomeQuestion = String(localized: "question_1").asAttributedString
        static let yearlyGrossIncomeExplanation = String(localized:"question_1_hint")
        
        static let distanceToWorkQuestion = String(localized: "question_2").asAttributedString
        static let distanceToWorkExplanation = String(localized: "question_2_hint")
        
        static let workFromHomeDaysQuestion = String(localized: "question_3").asAttributedString
        static let workFromHomeDaysExplanation = String(localized: "question_3_hint")
        
        static let childrenQuestion = String(localized: "question_4").asAttributedString
        static let childrenPlaceholder = String(localized: "children_placeholder").asAttributedString
        static let childrenExplanation = String(localized: "question_4_hint")
    }
    
    struct PartnersOptionalQuestionsScreen {
        static let titleHeaderView = String(localized: "partner_optional_caption")
        static let subtitleHeaderView = String(localized: "partner_optional_caption_hint")
        
        static let spouseHouseholdServicesQuestion = String(localized: "partner_question_4").asAttributedString
            + String(localized: "labor_costs_only").italicized
        static let spouseHouseholdServicesExplanation = String(localized: "partner_question_4_hint")
        
        static let spouseWorkExpensesQuestion = String(localized: "partner_question_5").asAttributedString
        static let spouseWorkExpensesExplanation = String(localized: "partner_question_5_hint")
        
        static let spouseSpecialExpensesQuestion = String(localized: "partner_question_6").asAttributedString
        static let spouseSpecialExpensesExplanation = String(localized: "partner_question_6_hint")
    }
    
    struct PartnersDetailsScreen {
        static let titleHeaderView = String(localized: "partner_caption")
        static let subtitleHeaderView = String(localized: "partner_caption_hint")
        
        static let spouseIncomeQuestion = String(localized: "partner_question_1").asAttributedString
        static let spouseIncomeExplanation = String(localized: "partner_question_1_hint")
        
        static let spouseDistanceToWorkQuestion = String(localized: "partner_question_2").asAttributedString
        static let spouseDistanceToWorkExplanation = String(localized: "partner_question_2_hint")
        
        static let spouseWorkFromHomeDaysQuestion = String(localized: "partner_question_3").asAttributedString
        static let spouseWorkFromHomeDaysExplanation = String(localized: "partner_question_3_hint")
        
        static let getResultButtonTitle = String(localized: "get_result_ButtonTitle")
    }
    
    struct OptionalQuestionsScreen {
        static let titleHeaderView = String(localized: "optional_caption")
        static let subtitleHeaderView = String(localized: "optional_caption_hint")
        
        static let householdServicesQuestion = String(localized: "question_6").asAttributedString
            + String(localized: "labor_costs_only").italicized
        static let householdServicesExplanation = String(localized: "question_6_hint")
        
        static let workExpensesQuestion = String(localized: "question_7").asAttributedString
        static let workExpensesExplanation = String(localized: "question_7_hint")
        
        static let specialExpensesQuestion = String(localized: "question_8").asAttributedString
        static let specialExpensesExplanation = String(localized: "question_8_hint")
        
        static let taxWithheldQuestion = String(localized: "question_9").asAttributedString
        static let taxWithheldExplanation = String(localized: "question_9_hint")
    }
    
    struct TaxResultScreen {
        static let greatTitle = String(localized: "final_caption")
        static let estimatedTaxReturnTitle = String(localized: "final_estimation")
        static let calculatingText = String(localized: "calculating_text")
        static let completeTaxReturnTitle = String(localized: "tax_return_caption")
        static let finishIn30Minutes = String(localized: "tax_return_text")
        static let startButtonTitle = String(localized: "start_button_title")
        static let tryAgainButtonTitle = String(localized: "try_again_button_title")
    }
    
}
