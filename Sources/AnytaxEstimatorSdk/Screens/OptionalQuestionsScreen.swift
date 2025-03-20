import SwiftUI

struct OptionalQuestionsScreen: View {
    typealias Loc = AppConstatns.OptionalQuestionsScreen
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    @FocusState private var isInputActive: Bool
    
    @ObservedObject private(set) var viewModel: TaxEstimationViewModel
    @State private var showExplanation = false
    
    private var infoButtonColor: Color {
        colorScheme == .light ? Color.systemBlue(colorScheme: colorScheme) : .white
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
                            placeholder: AppConstatns.Common.optionalAmountPlaceholder,
                            explanation: Loc.householdServicesExplanation,
                            text: $viewModel.taxEstimationInputData.householdServices
                        )
                        
                        QuestionRowView(
                            question: Loc.workExpensesQuestion,
                            placeholder: AppConstatns.Common.optionalAmountPlaceholder,
                            explanation: nil,
                            text: $viewModel.taxEstimationInputData.workExpenses
                        )
                        
                        QuestionRowView(
                            question: Loc.specialExpensesQuestion,
                            placeholder: AppConstatns.Common.optionalAmountPlaceholder,
                            explanation: nil,
                            text: $viewModel.taxEstimationInputData.specialExpenses
                        )
                        
                        QuestionRowView(
                            question: Loc.taxWithheldQuestion,
                            placeholder: AppConstatns.Common.optionalAmountPlaceholder,
                            explanation: Loc.taxWithheldExplanation,
                            text: $viewModel.taxEstimationInputData.taxWithheld
                        )
                    }
                    
                    MarriageQuestionView(
                        showExplanation: $showExplanation,
                        explanation: nil,
                        infoButtonColor: infoButtonColor
                    )
                    .padding(.vertical, 20)
                    
                    HStack(spacing: 20) {
                        NavigationLink(destination: PartnersDetailsScreen(viewModel: viewModel)) {
                            ActionButton(
                                icon: "checkmark.circle",
                                title: AppConstatns.Common.yesButtonTitle
                            )
                        }
                        .simultaneousGesture(TapGesture().onEnded {
                            viewModel.taxEstimationInputData.married = true
                        })
                        
                        NavigationLink(destination: TaxResultScreen(viewModel: viewModel)) {
                            ActionButton(
                                icon: "x.circle",
                                title: AppConstatns.Common.noButtonTitle
                            )
                        }
                        .simultaneousGesture(TapGesture().onEnded {
                            viewModel.taxEstimationInputData.married = false
                        })
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 40)
                    
                    NavigationLink(destination: TaxResultScreen(viewModel: viewModel)) {
                        Text(AppConstatns.Common.getEstimateButtonTitle)
                            .primaryButtonStyle(colorScheme: colorScheme)
                    }
                    .padding(.bottom, 20)
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
    return OptionalQuestionsScreen(viewModel: viewModel)
}
