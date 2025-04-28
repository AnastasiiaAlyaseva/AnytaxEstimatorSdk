import SwiftUI

struct PartnersDetailsScreen: View {
    typealias Loc = AppConstants.PartnersDetailsScreen
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.theme) private var theme
    @FocusState private var focusedField: FocusField?
    
    @ObservedObject private(set) var viewModel: TaxEstimationViewModel
    
    private let fieldsOrder: [FocusField] = [.spouseIncome, .spouseDistanceToWork, .spouseWorkFromHomeDays]
    
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
                            question: Loc.spouseIncomeQuestion,
                            placeholder: AppConstants.Common.yearlyGrossIncomePlaceholder,
                            explanation: Loc.spouseIncomeExplanation,
                            text: $viewModel.taxEstimationInputData.spouseIncome,
                            currentField: .spouseIncome,
                            focusedField: $focusedField
                        )
                        
                        QuestionRowView(
                            question: Loc.spouseDistanceToWorkQuestion,
                            placeholder: AppConstants.Common.distanceToWorkPlaceholder,
                            explanation: nil,
                            text: $viewModel.taxEstimationInputData.spouseDistanceToWork,
                            currentField: .spouseDistanceToWork,
                            focusedField: $focusedField
                        )
                        
                        QuestionRowView(
                            question: Loc.spouseWorkFromHomeDaysQuestion,
                            placeholder: AppConstants.Common.workFromHomeDaysPlaceholder,
                            explanation: Loc.spouseWorkFromHomeDaysExplanation,
                            text: $viewModel.taxEstimationInputData.spouseWorkFromHomeDays,
                            currentField: .spouseWorkFromHomeDays,
                            focusedField: $focusedField
                        )
                    }
                    
                    AlmostDoneView()
                    
                    HStack(spacing: 20) {
                        NavigationLink(
                            destination: PartnersOptionalQuestionsScreen(viewModel: viewModel)
                                .environment(\.theme, theme)
                        ) {
                            ActionButton(
                                icon: "checkmark.circle",
                                title: AppConstants.Common.yesButtonTitle
                            )
                        }
                        NavigationLink(
                            destination: TaxResultScreen(viewModel: viewModel)
                                .environment(\.theme, theme)
                        ) {
                            ActionButton(
                                icon: "x.circle",
                                title: Loc.getResultButtonTitle
                            )
                        }
                    }
                    .padding(.horizontal, 20)
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
                viewModel.config.onScreenAppeared?(.partnersDetails)
            }
            .withCloseButtonIfNeeded(
                isAppEmbedded: viewModel.config.isAppEmbedded,
                colorScheme: colorScheme,
                theme: theme,
                screen: .partnersDetails,
                action: {
                    viewModel.config.onFinishFlow(.partnersDetails)
                }
            )
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    let config = AnytaxEstimatorConfig(onFinishFlow: { _ in })
    let viewModel = TaxEstimationViewModel(config: config)
    return PartnersDetailsScreen(viewModel: viewModel)
}

