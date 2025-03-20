import SwiftUI

struct TaxResultScreen: View {
    typealias Loc = AppConstatns.TaxResultScreen
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    @ObservedObject private(set) var viewModel: TaxEstimationViewModel
    
    private var textColor: Color {
        colorScheme == .light ? Color.systemBlue(colorScheme: colorScheme) : .white
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
                            Text(Loc.greatTitle)
                                .font(.system(size: 24, weight: .semibold, design: .rounded))
                                .foregroundColor(.label)
                                .lineSpacing(12)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal)
                            
                            HStack() {
                                Text(Loc.estimatedTaxReturnTitle)
                                    .font(.system(size: 17, weight: .bold, design: .rounded))
                                    .foregroundColor(.label)
                                    .lineSpacing(8)
                                    .padding(.horizontal, 20)
                                
                                Text(response.displayValue)
                                    .font(.system(size: 22, weight: .bold, design: .rounded))
                                    .foregroundColor(Color.systemBlue(colorScheme: colorScheme))
                                    .padding(.horizontal, 20)
                                
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .frame(height: 80)
                            .background(Color.backgroundColorWithOpacity(colorScheme: colorScheme))
                            .padding(.vertical, 20)
                            
                            HStack {
                                Image(.onChair)
                                    .resizable()
                                    .frame(width: 110, height: 70)
                                    .padding()
                                
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(Loc.completeTaxReturnTitle)
                                        .font(.system(size: 20, weight: .medium, design: .rounded))
                                        .foregroundColor(.label)
                                        .lineSpacing(8)
                                    
                                    Text(Loc.finishIn30Minutes)
                                        .font(.system(size: 12, weight: .medium, design: .rounded))
                                        .foregroundColor(Color.systemBlue(colorScheme: colorScheme))
                                        .lineSpacing(6)
                                    
                                    HStack(alignment: .bottom){
                                        Spacer()
                                        
                                        Button(action: {
                                            viewModel.onFinishFlow()
                                        }) {
                                            Text(Loc.startButtonTitle)
                                                .fontWeight(.bold)
                                                .foregroundColor(.white)
                                                .padding(.horizontal, 20)
                                                .padding(.vertical, 10)
                                                .background(Color.systemBlue(colorScheme: colorScheme))
                                                .cornerRadius(20)
                                        }
                                    }
                                    .padding(.top)
                                }
                            }
                            .padding()
                            .background(.background)
                            .cornerRadius(15)
                            .shadow(color: .secondaryLabel.opacity(0.5), radius: 5)
                            .padding(.horizontal)
                            
                            Spacer()
                            
                            Image(.withLoading)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 345, height: 345)
                                .foregroundColor(.blue)
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
                                        .background(Color.systemBlue(colorScheme: colorScheme))
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
                    .taxEstimatorToolbar(dismiss: dismiss)
                    .onAppear {
                        viewModel.getTaxEstimations()
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    let viewModel = TaxEstimationViewModel(onFinishFlow: {})
    return TaxResultScreen(viewModel: viewModel)
}
