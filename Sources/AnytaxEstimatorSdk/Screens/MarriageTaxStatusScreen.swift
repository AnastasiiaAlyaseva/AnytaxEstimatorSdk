import SwiftUI

struct MarriageTaxStatusScreen: View {
    typealias Loc = AppConstatns.MarriageQuestionView
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    @State private var showExplanation = false
    @State private var showPartnersDetails = false
    @State private var showTaxResult = false
    
    @ObservedObject private(set) var viewModel: TaxEstimationViewModel
    
    private var infoButtonColor: Color {
        colorScheme == .light ? Color.systemBlue(colorScheme: colorScheme) : .white
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                MarriageQuestionView(
                    showExplanation: $showExplanation,
                    explanation: Loc.explanation,
                    infoButtonColor: infoButtonColor
                )
                
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
                
                NavigationLink(destination: TaxResultScreen(viewModel: viewModel)) {
                    Text(AppConstatns.Common.getEstimateButtonTitle)
                        .primaryButtonStyle(colorScheme: colorScheme)
                }
                .padding(.top, 15)
                
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .taxEstimatorToolbar(dismiss: dismiss)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    let viewModel = TaxEstimationViewModel(onFinishFlow: {})
    return MarriageTaxStatusScreen(viewModel: viewModel)
}
