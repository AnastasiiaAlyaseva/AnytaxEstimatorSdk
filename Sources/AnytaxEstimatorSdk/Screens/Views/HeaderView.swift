import SwiftUI

struct HeaderView: View {
    let title: String
    let subtitle: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.system(size: 24, weight: .semibold, design: .rounded))
                .foregroundColor(.label)
                .lineSpacing(12)
            
            Text(subtitle)
                .font(.system(size: 15, weight: .regular, design: .rounded))
                .foregroundColor(.secondaryLabel)
                .lineSpacing(7.5)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
        .padding(.top)
    }
}

#Preview {
    HeaderView(
        title: "Want to find out much of\na tax refund you can get?",
        subtitle: "Answer a couple of questions to quickly get an estimate of your potential refund from the tax office:"
    )
}
