import SwiftUI

struct WelcomeScreen: View {
    typealias Loc = AppConstatns.WelcomeScreen
    
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject private(set) var viewModel: TaxEstimationViewModel
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    Color(Color.systemBlue(colorScheme: colorScheme))
                        .ignoresSafeArea()
                    
                    VStack {
                        Image(.logo)
                            .responsiveImage(geometry: geometry)
                        
                        Text(AppConstatns.anytax)
                            .font(.system(size: 60, weight: .regular, design: .rounded))
                            .foregroundColor(.white)
                            .padding(.top, 10)
                        
                        Text(Loc.estimatorTitle)
                            .font(.system(size: 30, weight: .regular, design: .default))
                            .italic()
                            .foregroundColor(.white)
                            .padding(.bottom, geometry.size.height * 0.1)
                        
                        NavigationLink(destination: TaxEstimatorScreen(viewModel: viewModel)) {
                            Text(Loc.getEstimateButtonTitle)
                                .font(.system(size: 15, weight: .semibold, design: .rounded))
                                .lineSpacing(7.5)
                                .foregroundColor(Color.systemBlue(colorScheme: colorScheme))
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
        }.navigationBarBackButtonHidden(true)
    }
}

#Preview {
    let viewModel = TaxEstimationViewModel(onFinishFlow: {})
    return WelcomeScreen(viewModel: viewModel)
}
