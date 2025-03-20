import SwiftUI

struct AlmostDoneView: View {
    @Environment(\.colorScheme) var colorScheme
    let title: String = AppConstatns.AlmostDoneView.title
    let subtitle: String = AppConstatns.AlmostDoneView.subtitle
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.system(size: 24, weight: .semibold, design: .rounded))
                .foregroundColor(.label)
                .lineSpacing(12)
                .padding(.horizontal)
                .padding(.vertical, 20)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(subtitle)
                    .font(.system(size: 17, weight: .regular, design: .rounded))
                    .padding(EdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15))
                    .foregroundColor(.label)
                    .lineSpacing(8.5)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(minHeight: 115)
            .background(Color.backgroundColorWithOpacity(colorScheme: colorScheme))
        }
        .padding(.vertical, 20)
    }
}

#Preview {
    AlmostDoneView()
}
