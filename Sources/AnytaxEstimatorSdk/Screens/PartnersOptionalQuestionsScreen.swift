import SwiftUI

struct PartnersOptionalQuestionsScreen: View {
    typealias Loc = AppConstants.PartnersOptionalQuestionsScreen
    
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dismiss) private var dismiss
    @Environment(\.theme) private var theme
    @FocusState private var focusedField: FocusField?
    
    @ObservedObject private(set) var viewModel: TaxEstimationViewModel
    
    private let fieldsOrder: [FocusField] = [.spouseHouseholdServices, .spouseWorkExpenses, .spouseSpecialExpenses]
    
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
                            placeholder: AppConstants.Common.optionalAmountPlaceholder,
                            explanation: Loc.spouseHouseholdServicesExplanation,
                            text: $viewModel.taxEstimationInputData.spouseHouseholdServices,
                            currentField: .spouseHouseholdServices,
                            focusedField: $focusedField
                        )
                        
                        QuestionRowView(
                            question: Loc.spouseWorkExpensesQuestion,
                            placeholder: AppConstants.Common.optionalAmountPlaceholder,
                            explanation: nil,
                            text: $viewModel.taxEstimationInputData.spouseWorkExpenses,
                            currentField: .spouseWorkExpenses,
                            focusedField: $focusedField
                        )
                        
                        QuestionRowView(
                            question: Loc.spouseSpecialExpensesQuestion,
                            placeholder: AppConstants.Common.optionalAmountPlaceholder,
                            explanation: nil,
                            text: $viewModel.taxEstimationInputData.spouseSpecialExpenses,
                            currentField: .spouseSpecialExpenses,
                            focusedField: $focusedField
                        )
                    }
                    .padding(.bottom, 35)
                    
                    NavigationLink(
                        destination: TaxResultScreen(viewModel: viewModel)
                            .environment(\.theme, theme)
                    ) {
                        Text(AppConstants.Common.getEstimateButtonTitle)
                            .primaryButtonStyle(
                                colorScheme: colorScheme,
                                theme: theme
                            )
                    }
                    .padding(.bottom, 20)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .taxEstimatorToolbar(
                dismiss: dismiss,
                colorScheme: colorScheme,
                theme: theme
            )
            .keyboardButtonToolbar(
                fields: fieldsOrder,
                currentField: focusedField,
                focusedField: $focusedField
            )
            .onAppear {
                viewModel.config.onScreenAppeared?(.partnersOptionalQuestions)
            }
            .withCloseButtonIfNeeded(
                isAppEmbedded: viewModel.config.isAppEmbedded,
                colorScheme: colorScheme,
                theme: theme,
                screen: .partnersOptionalQuestions,
                action: {
                    viewModel.config.onFinishFlow(.partnersOptionalQuestions)
                }
            )
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    let config = AnytaxEstimatorConfig(onFinishFlow: { _ in })
    let viewModel = TaxEstimationViewModel(config: config)
    return PartnersOptionalQuestionsScreen(viewModel: viewModel)
}
