import SwiftUI

struct TaxEstimatorScreen: View {
    typealias Loc = AppConstatns.TaxEstimatorScreen
    
    @Environment(\.dismiss) var dismiss
    @State private var showOptionalQuestions = false
    @State private var showMarriageTaxStatus = false
    @FocusState private var isInputActive: Bool
    
    @ObservedObject private(set) var viewModel: TaxEstimationViewModel
    
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
                    .padding(.vertical, 0)
                    
                    VStack(spacing: 25){
                        QuestionRowView(
                            question: Loc.yearlyGrossIncomeQuestion,
                            placeholder: AppConstatns.Common.yearlyGrossIncomePlaceholder,
                            explanation: Loc.yearlyGrossIncomeExplanation,
                            text: $viewModel.taxEstimationInputData.income
                        )
                        
                        QuestionRowView(
                            question: Loc.distanceToWorkQuestion,
                            placeholder: AppConstatns.Common.distanceToWorkPlaceholder,
                            explanation: nil,
                            text: $viewModel.taxEstimationInputData.distanceToWork
                        )
                        
                        QuestionRowView(
                            question: Loc.workFromHomeDaysQuestion,
                            placeholder: AppConstatns.Common.workFromHomeDaysPlaceholder,
                            explanation: Loc.workFromHomeDaysExplanation,
                            text: $viewModel.taxEstimationInputData.workFromHomeDays
                        )
                        
                        QuestionRowView(
                            question: Loc.childrenQuestion,
                            placeholder: Loc.childrenPlaceholder,
                            explanation: nil,
                            text: $viewModel.taxEstimationInputData.children
                        )
                    }
                    
                    AlmostDoneView()
                    
                    HStack(spacing: 20) {
                        NavigationLink(destination: OptionalQuestionsScreen(viewModel: viewModel)) {
                            ActionButton(
                                icon: "checkmark.circle",
                                title: AppConstatns.Common.yesButtonTitle,
                                foregroundColor: isFormValid ? .label : .secondaryLabel
                            )
                        }
                        .disabled(!isFormValid)
                        
                        NavigationLink(destination: MarriageTaxStatusScreen(viewModel: viewModel)) {
                            ActionButton(
                                icon: "x.circle",
                                title: AppConstatns.Common.noButtonTitle,
                                foregroundColor: isFormValid ? .label : .secondaryLabel
                            )
                        }
                        .disabled(!isFormValid)
                        
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
    return TaxEstimatorScreen(viewModel: viewModel)
}


