import SwiftUI

struct ActionButton: View {
    let icon: String
    let title: String
    var foregroundColor: Color = .label
    
    var body: some View {
        HStack {
            Image(systemName: icon)
            Text(title)
        }
        .font(.system(size: 15, weight: .regular, design: .rounded))
        .lineSpacing(7.5)
        .foregroundColor(foregroundColor)
        .frame(maxWidth: .infinity)
        .padding()
        .background(.background)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.background, lineWidth: 0.5)
        )
        .shadow(color: .gray.opacity(0.3), radius: 3, x: 0, y: 2)
    }
}

#Preview {
    ActionButton(icon: "x.circle", title: "No")
}
