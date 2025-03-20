import SwiftUI

struct QuestionRowView: View {
    @Environment(\.colorScheme) var colorScheme
    let question: AttributedString
    let placeholder: AttributedString
    let explanation: String?
    
    @FocusState private var isFocused: Bool
    @Binding var text: String
    @State private var showExplanation = false
    
    private var infoButtonColor: Color {
        colorScheme == .light ? Color.systemBlue(colorScheme: colorScheme) : .white
    }
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                Text(question)
                    .questionTextStyle()
                
                if let explanation = explanation {
                    Button(action: {
                        withAnimation {
                            showExplanation.toggle()
                        }
                    }) {
                        HStack(spacing: 5) {
                            Image(systemName: showExplanation ? "x.circle" : "info.circle")
                            Text(showExplanation
                                 ? AppConstatns.Common.minimizeButtonTitle
                                 : AppConstatns.Common.learnMoreButtonTitle
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
                            .grayInfoTextStyle(colorScheme: colorScheme)
                            .padding(.top)
                    }
                }
            }
            .questionRowBackgroundStyle(colorScheme: colorScheme)
            
            ZStack(alignment: .leading) {
                if text.isEmpty && !isFocused {
                    Text(placeholder)
                        .font(.system(size: 17, weight: .regular, design: .rounded))
                        .foregroundColor(.secondaryLabel)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .frame(height: 50, alignment: .center)
                        .padding(.horizontal, 10)
                        .multilineTextAlignment(.center)
                }
                TextField("", text: $text)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding(10)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .cornerRadius(10)
                    .padding(.horizontal, 10)
                    .multilineTextAlignment(.center)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.secondary.opacity(0.3), lineWidth: 1)
                    )
                    .keyboardType(.numberPad)
                    .focused($isFocused)
                    .onTapGesture {
                        isFocused = true
                    }
            }
            .padding(.horizontal)
        }
    }
}


#Preview {
    QuestionRowView(
        question: "What is your yearly gross\nincome from employment?",
        placeholder: "Enter Amount",
        explanation: "If you choose to file jointly with your spouse this will affect your tax refund and we will ask some questions about your spouse as well.",
        text: .constant("")
    )
}
