import SwiftUI

struct OptionalQuestionsScreen: View {
    typealias Loc = AppConstants.OptionalQuestionsScreen
    
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dismiss) private var dismiss
    @Environment(\.theme) private var theme
    @FocusState private var focusedField: FocusField?
    @State private var showExplanation = false
    
    @ObservedObject private(set) var viewModel: TaxEstimationViewModel
    
    private let fieldsOrder: [FocusField] = [.householdServices, .workExpenses, .specialExpenses, .taxWithheld]
    private var infoButtonColor: Color {
        colorScheme == .light ? theme.brandPrimaryColor.lightColor : .white
    }
    
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
                            question: Loc.householdServicesQuestion,
                            placeholder: AppConstants.Common.optionalAmountPlaceholder,
                            explanation: Loc.householdServicesExplanation,
                            text: $viewModel.taxEstimationInputData.householdServices,
                            currentField: .householdServices,
                            focusedField: $focusedField
                        )
                        
                        QuestionRowView(
                            question: Loc.workExpensesQuestion,
                            placeholder: AppConstants.Common.optionalAmountPlaceholder,
                            explanation: nil,
                            text: $viewModel.taxEstimationInputData.workExpenses,
                            currentField: .workExpenses,
                            focusedField: $focusedField
                        )
                        
                        QuestionRowView(
                            question: Loc.specialExpensesQuestion,
                            placeholder: AppConstants.Common.optionalAmountPlaceholder,
                            explanation: nil,
                            text: $viewModel.taxEstimationInputData.specialExpenses,
                            currentField: .specialExpenses,
                            focusedField: $focusedField
                        )
                        
                        QuestionRowView(
                            question: Loc.taxWithheldQuestion,
                            placeholder: AppConstants.Common.optionalAmountPlaceholder,
                            explanation: Loc.taxWithheldExplanation,
                            text: $viewModel.taxEstimationInputData.taxWithheld,
                            currentField: .taxWithheld,
                            focusedField: $focusedField
                        )
                    }
                    
                    MarriageQuestionView(
                        showExplanation: $showExplanation,
                        explanation: nil,
                        infoButtonColor: infoButtonColor
                    )
                    .padding(.vertical, 20)
                    
                    HStack(spacing: 20) {
                        NavigationLink(
                            destination: PartnersDetailsScreen(viewModel: viewModel)
                                .environment(\.theme, theme)
                        ) {
                            ActionButton(
                                icon: "checkmark.circle",
                                title: AppConstants.Common.yesButtonTitle
                            )
                        }
                        .simultaneousGesture(TapGesture().onEnded {
                            viewModel.taxEstimationInputData.married = true
                        })
                        
                        NavigationLink(
                            destination: TaxResultScreen(viewModel: viewModel)
                                .environment(\.theme, theme)
                        ) {
                            ActionButton(
                                icon: "x.circle",
                                title: AppConstants.Common.noButtonTitle
                            )
                        }
                        .simultaneousGesture(TapGesture().onEnded {
                            viewModel.taxEstimationInputData.married = false
                        })
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 40)
                    
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
                viewModel.config.onScreenAppeared?(.optionalQuestions)
            }
            .withCloseButtonIfNeeded(
                isAppEmbedded: viewModel.config.isAppEmbedded,
                colorScheme: colorScheme,
                theme: theme,
                screen: .optionalQuestions,
                action: {
                    viewModel.config.onFinishFlow(.optionalQuestions)
                }
            )
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    let config = AnytaxEstimatorConfig(
        apiKey: "anytax-api-key-2023",
        onFinishFlow: { _ in }
    )
    let viewModel = TaxEstimationViewModel(config: config)
    OptionalQuestionsScreen(viewModel: viewModel)
}
