import SwiftUI

struct TaxEstimatorScreen: View {
    typealias Loc = AppConstants.TaxEstimatorScreen
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.theme) private var theme
    @State private var showOptionalQuestions = false
    @State private var showMarriageTaxStatus = false
    @FocusState private var focusedField: FocusField?
    
    @ObservedObject private(set) var viewModel: TaxEstimationViewModel
    
    private let fieldsOrder: [FocusField] = [ .income, .distance, .workDays, .children]
    private var isFormValid: Bool {
        !viewModel.taxEstimationInputData.income.isEmpty &&
        !viewModel.taxEstimationInputData.distanceToWork.isEmpty &&
        !viewModel.taxEstimationInputData.workFromHomeDays.isEmpty &&
        !viewModel.taxEstimationInputData.children.isEmpty
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    HeaderView(
                        title: Loc.titleHeaderView,
                        subtitle: Loc.subtitleHeaderView
                    )
                    
                    VStack(spacing: 25) {
                        QuestionRowView(
                            question: Loc.yearlyGrossIncomeQuestion,
                            placeholder: AppConstants.Common.yearlyGrossIncomePlaceholder,
                            explanation: Loc.yearlyGrossIncomeExplanation,
                            text: $viewModel.taxEstimationInputData.income,
                            currentField: .income,
                            focusedField: $focusedField
                        )
                        
                        QuestionRowView(
                            question: Loc.distanceToWorkQuestion,
                            placeholder: AppConstants.Common.distanceToWorkPlaceholder,
                            explanation: nil,
                            text: $viewModel.taxEstimationInputData.distanceToWork,
                            currentField: .distance,
                            focusedField: $focusedField
                        )
                        
                        QuestionRowView(
                            question: Loc.workFromHomeDaysQuestion,
                            placeholder: AppConstants.Common.workFromHomeDaysPlaceholder,
                            explanation: Loc.workFromHomeDaysExplanation,
                            text: $viewModel.taxEstimationInputData.workFromHomeDays,
                            currentField: .workDays,
                            focusedField: $focusedField
                        )
                        
                        QuestionRowView(
                            question: Loc.childrenQuestion,
                            placeholder: Loc.childrenPlaceholder,
                            explanation: nil,
                            text: $viewModel.taxEstimationInputData.children,
                            currentField: .children,
                            focusedField: $focusedField
                        )
                    }
                    
                    AlmostDoneView()
                    
                    HStack(spacing: 20) {
                        NavigationLink(
                            destination: OptionalQuestionsScreen(viewModel: viewModel)
                                .environment(\.theme, theme)
                        ) {
                            ActionButton(
                                icon: "checkmark.circle",
                                title: AppConstants.Common.yesButtonTitle,
                                foregroundColor: isFormValid
                                ? theme.primaryText
                                : theme.secondaryText
                            )
                        }
                        .disabled(!isFormValid)
                        
                        NavigationLink(
                            destination: MarriageTaxStatusScreen(viewModel: viewModel)
                                .environment(\.theme, theme)
                        ) {
                            ActionButton(
                                icon: "x.circle",
                                title: AppConstants.Common.noButtonTitle,
                                foregroundColor: isFormValid
                                ? theme.primaryText
                                : theme.secondaryText
                            )
                        }
                        .disabled(!isFormValid)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .taxEstimatorToolbar(
                dismiss: dismiss,
                shouldShowBackButton: !viewModel.config.skipSplashScreen,
                colorScheme: colorScheme,
                theme: theme
            )
            .keyboardButtonToolbar(
                fields: fieldsOrder,
                currentField: focusedField,
                focusedField: $focusedField
            )
            .onAppear {
                viewModel.config.onScreenAppeared?(.taxEstimator)
            }
            .withCloseButtonIfNeeded(
                isAppEmbedded: viewModel.config.isAppEmbedded,
                colorScheme: colorScheme,
                theme: theme,
                screen: .taxEstimator,
                action: {
                    viewModel.config.onFinishFlow(.taxEstimator)
                }
            )
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    let config = AnytaxEstimatorConfig(onFinishFlow: { _ in })
    let viewModel = TaxEstimationViewModel(config: config)
    return TaxEstimatorScreen(viewModel: viewModel)
}
