import SwiftUI

struct PartnersOptionalQuestionsScreen: View {
    typealias Loc = AppConstatns.PartnersOptionalQuestionsScreen
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    @FocusState private var isInputActive: Bool
    
    @ObservedObject private(set) var viewModel: TaxEstimationViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    HeaderView(
                        title: Loc.titleHeaderView,
                        subtitle: Loc.subtitleHeaderView
                    )
                    
                    VStack(spacing: 25){
                        QuestionRowView(
                            question: Loc.spouseHouseholdServicesQuestion,
                            placeholder: AppConstatns.Common.optionalAmountPlaceholder,
                            explanation: Loc.spouseHouseholdServicesExplanation,
                            text: $viewModel.taxEstimationInputData.spouseHouseholdServices
                        )
                        
                        QuestionRowView(
                            question: Loc.spouseWorkExpensesQuestion,
                            placeholder: AppConstatns.Common.optionalAmountPlaceholder,
                            explanation: nil,
                            text: $viewModel.taxEstimationInputData.spouseWorkExpenses
                        )
                        
                        QuestionRowView(
                            question: Loc.spouseSpecialExpensesQuestion,
                            placeholder: AppConstatns.Common.optionalAmountPlaceholder,
                            explanation: nil,
                            text: $viewModel.taxEstimationInputData.spouseSpecialExpenses
                        )
                    }
                    
                    NavigationLink(destination: TaxResultScreen(viewModel: viewModel)) {
                        Text(AppConstatns.Common.getEstimateButtonTitle)
                            .primaryButtonStyle(colorScheme: colorScheme)
                    }
                    .padding(.top, 20)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .taxEstimatorToolbar(dismiss: dismiss)
            .keyboardToolbar(isInputActive: $isInputActive)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    let viewModel = TaxEstimationViewModel(onFinishFlow: {})
    return PartnersOptionalQuestionsScreen(viewModel: viewModel)
}
