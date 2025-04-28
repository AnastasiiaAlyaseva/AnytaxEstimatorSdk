import SwiftUI

struct QuestionRowView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.theme) private var theme
    let question: AttributedString
    let placeholder: AttributedString
    let explanation: String?
    
    
    @Binding private(set) var text: String
    @State private var showExplanation = false
    let currentField: FocusField
    @FocusState.Binding private(set) var focusedField: FocusField?
    
    private var infoButtonColor: Color {
        colorScheme == .light ? theme.brandPrimaryColor.lightColor : .white
    }
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                Text(question)
                    .questionTextStyle(
                        colorScheme: colorScheme,
                        theme: theme
                    )
                
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
            .questionRowBackgroundStyle(
                colorScheme: colorScheme,
                theme: theme
            )
            
            ZStack(alignment: .leading) {
                if text.isEmpty && focusedField != currentField {
                    Text(placeholder)
                        .font(.system(size: 17, weight: .regular, design: .rounded))
                        .foregroundColor(theme.secondaryText.resolve(for: colorScheme))
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
                            .stroke(
                                theme.secondaryText.resolve(for: colorScheme).opacity(0.3),
                                lineWidth: 1
                            )
                    )
                    .keyboardType(.numberPad)
                    .focused($focusedField, equals: currentField)
                    .onTapGesture {
                        focusedField = currentField
                    }
            }
            .padding(.horizontal)
        }
    }
}


#Preview {
    @FocusState var previewFocusedField: FocusField?
    QuestionRowView(
        question: "What is your yearly gross\nincome from employment?",
        placeholder: "Enter Amount",
        explanation: "If you choose to file jointly with your spouse this will affect your tax refund and we will ask some questions about your spouse as well.",
        text: .constant(""),
        currentField: .income,
        focusedField: $previewFocusedField
    )
}
