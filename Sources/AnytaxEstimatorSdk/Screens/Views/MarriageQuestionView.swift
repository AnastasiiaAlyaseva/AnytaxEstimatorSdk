import SwiftUI

struct MarriageQuestionView: View {
    typealias Loc = AppConstants.MarriageQuestionView
    
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.theme) private var theme
    @Binding private(set) var showExplanation: Bool
    let explanation: String?
    let infoButtonColor: Color
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 0) {
                Text(Loc.title)
                    .questionTextStyle(
                        colorScheme: colorScheme,
                        theme: theme
                    )
                    .frame(minHeight: 87)
                    .cornerRadius(10)
                
                if let explanation = explanation {
                    Button(action: {
                        withAnimation {
                            showExplanation.toggle()
                        }
                    }) {
                        HStack(spacing: 5) {
                            Image(systemName: showExplanation ? "x.circle" : "info.circle")
                            Text(showExplanation
                                 ? AppConstants.Common.minimizeButtonTitle
                                 : AppConstants.Common.learnMoreButtonTitle
                            )
                        }
                        .font(.system(size: 15, weight: .regular, design: .rounded))
                        .foregroundColor(infoButtonColor)
                        .lineSpacing(7.5)
                    }
                    .padding(.leading, 15)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    if showExplanation {
                        Text(explanation)
                            .grayInfoTextStyle(
                                colorScheme: colorScheme,
                                theme: theme
                            )
                            .padding(.top)
                    }
                }
            }
        }
        .padding()
        .background(theme.elementBackground.resolve(for: colorScheme))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

#Preview {
    MarriageQuestionView(
        showExplanation: .constant(true),
        explanation: "If you choose to file jointly with your spouse this will affect your tax refund and we will ask some questions about your spouse as well.",
        infoButtonColor: .blue
    )
}
