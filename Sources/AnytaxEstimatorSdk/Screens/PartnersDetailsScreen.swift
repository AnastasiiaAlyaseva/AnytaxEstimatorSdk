import SwiftUI

struct PartnersDetailsScreen: View {
    typealias Loc = AppConstatns.PartnersDetailsScreen
    
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
                            question: Loc.spouseIncomeQuestion,
                            placeholder: AppConstatns.Common.yearlyGrossIncomePlaceholder,
                            explanation: Loc.spouseIncomeExplanation,
                            text: $viewModel.taxEstimationInputData.spouseIncome
                        )
                        
                        QuestionRowView(
                            question: Loc.spouseDistanceToWorkQuestion,
                            placeholder: AppConstatns.Common.distanceToWorkPlaceholder,
                            explanation: nil,
                            text: $viewModel.taxEstimationInputData.spouseDistanceToWork
                        )
                        
                        QuestionRowView(
                            question: Loc.spouseWorkFromHomeDaysQuestion,
                            placeholder: AppConstatns.Common.workFromHomeDaysPlaceholder,
                            explanation: Loc.spouseWorkFromHomeDaysExplanation,
                            text: $viewModel.taxEstimationInputData.spouseWorkFromHomeDays
                        )
                    }
                    
                    AlmostDoneView()
                    
                    HStack(spacing: 20) {
                        NavigationLink(destination: PartnersOptionalQuestionsScreen(viewModel: viewModel)) {
                            ActionButton(
                                icon: "checkmark.circle",
                                title: AppConstatns.Common.yesButtonTitle
                            )
                        }
                        NavigationLink(destination: TaxResultScreen(viewModel: viewModel)) {
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
            .taxEstimatorToolbar(dismiss: dismiss)
            .keyboardToolbar(isInputActive: $isInputActive)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    let viewModel = TaxEstimationViewModel(onFinishFlow: {})
    return PartnersDetailsScreen(viewModel: viewModel)
}
