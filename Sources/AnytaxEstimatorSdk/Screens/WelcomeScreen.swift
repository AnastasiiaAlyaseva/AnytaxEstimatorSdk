import SwiftUI

struct WelcomeScreen: View {
    typealias Loc = AppConstants.WelcomeScreen
    
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.theme) private var theme
    @ObservedObject private(set) var viewModel: TaxEstimationViewModel
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    theme.brandPrimaryColor.resolve(for: colorScheme)
                        .ignoresSafeArea()
                    
                    VStack {
                        Image(.logo)
                            .responsiveImage(geometry: geometry)
                        
                        Text(AppConstants.anytax)
                            .font(.system(size: 60, weight: .regular, design: .rounded))
                            .foregroundColor(.white)
                            .padding(.top, 10)
                        
                        Text(Loc.estimatorTitle)
                            .font(.system(size: 30, weight: .regular, design: .default))
                            .italic()
                            .foregroundColor(.white)
                            .padding(.bottom, geometry.size.height * 0.1)
                        
                        NavigationLink(
                            destination: TaxEstimatorScreen(viewModel: viewModel)
                                .environment(\.theme, theme)
                        ) {
                            Text(Loc.getEstimateButtonTitle)
                                .font(.system(size: 15, weight: .semibold, design: .rounded))
                                .lineSpacing(7.5)
                                .foregroundColor(theme.brandPrimaryColor.resolve(for: colorScheme))
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(.white)
                                .cornerRadius(10)
                                .shadow(radius: 2)
                        }
                        .padding(.horizontal, geometry.size.width * 0.1)
                    }
                }
            }
            .onAppear {
                viewModel.config.onScreenAppeared?(.welcome)
            }
            .withCloseButtonIfNeeded(
                isAppEmbedded: viewModel.config.isAppEmbedded,
                colorScheme: colorScheme,
                theme: theme,
                screen: .welcome,
                action: {
                    viewModel.config.onFinishFlow(.welcome)
                }
            )
        }.navigationBarBackButtonHidden(true)
    }
}

#Preview {
    let config = AnytaxEstimatorConfig(onFinishFlow: { _ in })
    let viewModel = TaxEstimationViewModel(config: config)
    return WelcomeScreen(viewModel: viewModel)
}
