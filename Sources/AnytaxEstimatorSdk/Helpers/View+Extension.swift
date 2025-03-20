import SwiftUI

extension View {
    func taxEstimatorToolbar(
        title: String = AppConstatns.navigationBarTitle,
        dismiss: DismissAction
    ) -> some View {
        self.toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.label)
                }
            }
            ToolbarItem(placement: .principal) {
                Text(title)
                    .font(.system(size: 17, weight: .semibold, design: .rounded))
                    .foregroundColor(.label)
                    .lineSpacing(5)
            }
        }
    }
    
    func questionRowBackgroundStyle(colorScheme: ColorScheme) -> some View {
        self
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(minHeight: 120)
            .background(Color.backgroundColor(colorScheme: colorScheme))
            .cornerRadius(10)
            .padding(.horizontal)
            .padding(.vertical, 20)
    }
    
    func keyboardToolbar(
        isInputActive: FocusState<Bool>.Binding,
        buttonTitle: String = AppConstatns.Common.keyboardToolbarButtonTitle
    ) -> some View {
        self
            .focused(isInputActive)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button(buttonTitle) {
                        isInputActive.wrappedValue = false
                    }
                }
            }
    }
}
