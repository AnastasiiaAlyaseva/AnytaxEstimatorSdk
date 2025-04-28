import SwiftUI

extension View {
    func taxEstimatorToolbar(
        title: String = AppConstants.navigationBarTitle,
        dismiss: DismissAction,
        shouldShowBackButton: Bool = true,
        colorScheme: ColorScheme,
        theme: Theme
    ) -> some View {
        self.toolbar {
            if shouldShowBackButton {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .foregroundColor(theme.primaryText.resolve(for: colorScheme))
                    }
                }
            }
            ToolbarItem(placement: .principal) {
                Text(title)
                    .font(.system(size: 17, weight: .semibold, design: .rounded))
                    .foregroundColor(theme.primaryText.resolve(for: colorScheme))
                    .lineSpacing(5)
            }
        }
    }
    
    func questionRowBackgroundStyle(colorScheme: ColorScheme, theme: Theme) -> some View {
        self
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(minHeight: 120)
            .background(theme.questionRowBackground.resolve(for: colorScheme))
            .cornerRadius(10)
            .padding(.horizontal)
            .padding(.vertical, 20)
    }
    
    func keyboardButtonToolbar(
        fields: [FocusField],
        currentField: FocusField?,
        focusedField: FocusState<FocusField?>.Binding,
        nextButtonTitle: String = AppConstants.Common.keyboardToolbarNextButtonTitle,
        doneButtonTitle: String = AppConstants.Common.keyboardToolbarDoneButtonTitle
    ) -> some View {
        self.toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button(action: {
                    if let currentIndex = fields.firstIndex(where: { $0 == currentField }) {
                        let nextFieldIndex = currentIndex + 1
                        if nextFieldIndex < fields.count {
                            focusedField.wrappedValue = fields[nextFieldIndex]
                        } else {
                            focusedField.wrappedValue = nil
                        }
                    }
                }) {
                    Text(currentField == fields.last
                         ? doneButtonTitle
                         : nextButtonTitle
                    )
                }
            }
        }
    }
    
    func withCloseButtonIfNeeded(
        isAppEmbedded: Bool,
        colorScheme: ColorScheme,
        theme: Theme,
        screen: AnalyticsScreen,
        action: @escaping () -> Void
    ) -> some View {
        self.toolbar {
            if isAppEmbedded {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        action()
                    }) {
                        Image(systemName: "xmark.circle")
                            .font(.system(size: 20))
                            .foregroundColor(
                                screen == .welcome
                                    ? .white
                                    : theme.primaryText.resolve(for: colorScheme)
                            )
                    }
                }
            }
        }
    }
}
