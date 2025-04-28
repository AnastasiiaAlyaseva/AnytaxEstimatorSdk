import SwiftUI

struct ActionButton: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.theme) private var theme
    
    let icon: String
    let title: String
    var foregroundColor: DynamicColor = .systemColor(.primaryText)
    
    var body: some View {
        HStack {
            Image(systemName: icon)
            Text(title)
        }
        .font(.system(size: 15, weight: .regular, design: .rounded))
        .lineSpacing(7.5)
        .foregroundColor(foregroundColor.resolve(for: colorScheme))
        .frame(maxWidth: .infinity)
        .padding()
        .background(theme.elementBackground.resolve(for: colorScheme))
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(
                    theme.elementBackground.resolve(for: colorScheme),
                    lineWidth: 0.5
                )
        )
        .shadow(color: .gray.opacity(0.3), radius: 3, x: 0, y: 2)
    }
}

#Preview {
    ActionButton(icon: "x.circle", title: "No")
}
