import SwiftUI

extension Text {
    func primaryButtonStyle(colorScheme: ColorScheme) -> some View {
        self
            .font(.system(size: 17, weight: .semibold, design: .rounded))
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.systemBlue(colorScheme: colorScheme))
            .lineSpacing(7.5)
            .cornerRadius(10)
            .padding(.horizontal)
    }
    
    func questionTextStyle() -> some View {
        self
            .font(.system(size: 20, weight: .semibold, design: .rounded))
            .foregroundColor(.label)
            .frame(maxWidth: .infinity, alignment: .leading)
            .lineSpacing(9)
            .padding(EdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15))
    }
    
    func grayInfoTextStyle(colorScheme: ColorScheme) -> some View {
        self
            .font(.system(size: 15, weight: .regular, design: .rounded))
            .foregroundColor(.secondaryLabel)
            .lineSpacing(7.5)
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.infoTextStyle(colorScheme: colorScheme))
            .cornerRadius(8)
    }
}
