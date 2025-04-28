import SwiftUI

struct MarriageTaxStatusScreen: View {
    typealias Loc = AppConstants.MarriageQuestionView
    
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dismiss) private var dismiss
    @Environment(\.theme) private var theme
    @State private var showExplanation = false
    @State private var showPartnersDetails = false
    @State private var showTaxResult = false
    
    @ObservedObject private(set) var viewModel: TaxEstimationViewModel
    
    private var infoButtonColor: Color {
        colorScheme == .light ? theme.brandPrimaryColor.lightColor : .white
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
                .padding(.top, 15)
                
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .taxEstimatorToolbar(
                dismiss: dismiss,
                colorScheme: colorScheme,
                theme: theme
            )
            .onAppear {
                viewModel.config.onScreenAppeared?(.marriageTaxStatus)
            }
            .withCloseButtonIfNeeded(
                isAppEmbedded: viewModel.config.isAppEmbedded,
                colorScheme: colorScheme,
                theme: theme,
                screen: .marriageTaxStatus,
                action: {
                    viewModel.config.onFinishFlow(.marriageTaxStatus)
                }
            )
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    let config = AnytaxEstimatorConfig(onFinishFlow: { _ in })
    let viewModel = TaxEstimationViewModel(config: config)
    return MarriageTaxStatusScreen(viewModel: viewModel)
}
