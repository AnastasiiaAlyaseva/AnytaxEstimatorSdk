import SwiftUI

struct TaxResultScreen: View {
    typealias Loc = AppConstants.TaxResultScreen
    
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dismiss) private var dismiss
    @Environment(\.theme) private var theme
    @ObservedObject private(set) var viewModel: TaxEstimationViewModel
    
    private var textColor: Color {
        colorScheme == .light ? theme.brandPrimaryColor.lightColor : .white
    }
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ScrollView {
                    VStack(spacing: 10) {
                        if viewModel.isLoading {
                            VStack {
                                ProgressView()
                                    .tint(textColor)
                                Text(Loc.calculatingText)
                                    .foregroundColor(textColor)
                            }
                            .frame(
                                width: geometry.size.width,
                                height: geometry.size.height,
                                alignment: .center
                            )
                        } else if let response = viewModel.taxEstimationResults {
                            if let customResultView = viewModel.config.resultView {
                                customResultView(response.displayValue)
                                    .frame(minHeight: geometry.size.height)
                            } else {
                                TaxResultContentView(
                                    displayValue: response.displayValue,
                                    colorScheme: colorScheme,
                                    theme: theme,
                                    onStart: {
                                        viewModel.config.onFinishFlow(.taxResult)
                                    }
                                )
                                .frame(minHeight: geometry.size.height)
                            }
                        }
                        else if let error = viewModel.errorMessage {
                            VStack {
                                Text(error)
                                    .foregroundColor(textColor)
                                    .multilineTextAlignment(.center)
                                    .padding()
                                
                                Button(action: {
                                    viewModel.getTaxEstimations()
                                }) {
                                    Text(Loc.tryAgainButtonTitle)
                                        .font(.system(size: 17, weight: .semibold, design: .rounded))
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(theme.elementBackground.resolve(for: colorScheme))
                                        .cornerRadius(10)
                                }
                            }
                            .frame(
                                width: geometry.size.width,
                                height: geometry.size.height,
                                alignment: .center
                            )
                        }
                        Spacer()
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    .taxEstimatorToolbar(
                        dismiss: dismiss,
                        colorScheme: colorScheme,
                        theme: theme
                    )
                    .onAppear {
                        viewModel.config.onScreenAppeared?(.taxResult)
                        viewModel.getTaxEstimations()
                    }
                    .withCloseButtonIfNeeded(
                        isAppEmbedded: viewModel.config.isAppEmbedded,
                        colorScheme: colorScheme,
                        theme: theme,
                        screen: .taxResult,
                        action: {
                            viewModel.config.onFinishFlow(.taxResult)
                        }
                    )
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

private struct TaxResultContentView: View {
    typealias Loc = AppConstants.TaxResultScreen
    
    let displayValue: String
    let colorScheme: ColorScheme
    let theme: Theme
    let onStart: () -> Void
    
    var body: some View {
        VStack(spacing: 10) {
            Text(Loc.greatTitle)
                .font(.system(size: 24, weight: .semibold, design: .rounded))
                .foregroundColor(theme.primaryText.resolve(for: colorScheme))
                .lineSpacing(12)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            HStack {
                Text(Loc.estimatedTaxReturnTitle)
                    .font(.system(size: 17, weight: .bold, design: .rounded))
                    .foregroundColor(theme.primaryText.resolve(for: colorScheme))
                    .lineSpacing(8)
                    .padding(.horizontal, 20)
                
                Text(displayValue)
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                    .foregroundColor(theme.brandPrimaryColor.resolve(for: colorScheme))
                    .padding(.horizontal, 20)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 80)
            .background(theme.semiTransparentBackground.resolve(for: colorScheme))
            .padding(.vertical, 20)
            
            HStack {
                Image(.onChair)
                    .resizable()
                    .frame(width: 110, height: 70)
                    .padding()
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(Loc.completeTaxReturnTitle)
                        .font(.system(size: 20, weight: .medium, design: .rounded))
                        .foregroundColor(theme.primaryText.resolve(for: colorScheme))
                        .lineSpacing(8)
                    
                    Text(Loc.finishIn30Minutes)
                        .font(.system(size: 12, weight: .medium, design: .rounded))
                        .foregroundColor(theme.brandPrimaryColor.resolve(for: colorScheme))
                        .lineSpacing(6)
                    
                    HStack(alignment: .bottom){
                        Spacer()
                        Button(action: onStart) {
                            Text(Loc.startButtonTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                                .background(theme.brandPrimaryColor.resolve(for: colorScheme))
                                .cornerRadius(20)
                        }
                    }
                    .padding(.top)
                }
            }
            .padding()
            .background(theme.elementBackground.resolve(for: colorScheme))
            .cornerRadius(15)
            .shadow(
                color: theme.secondaryText.resolve(for: colorScheme).opacity(0.5),
                radius: 5
            )
            .padding(.horizontal)
            
            Spacer()
            
            Image(.withLoading)
                .resizable()
                .scaledToFit()
                .frame(width: 345, height: 345)
                .foregroundColor(.blue)
        }
    }
}


#Preview {
    let config = AnytaxEstimatorConfig(
        apiKey: "anytax-api-key-2023",
        onFinishFlow: { _ in }
    )
    let viewModel = TaxEstimationViewModel(config: config)
    TaxResultScreen(viewModel: viewModel)
}
