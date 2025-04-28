import SwiftUI

extension Text {
    func primaryButtonStyle(colorScheme: ColorScheme, theme: Theme) -> some View {
        self
            .font(.system(size: 17, weight: .semibold, design: .rounded))
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(theme.brandPrimaryColor.resolve(for: colorScheme))
            .lineSpacing(7.5)
            .cornerRadius(10)
            .padding(.horizontal)
    }
    
    func questionTextStyle(colorScheme: ColorScheme, theme: Theme) -> some View {
        self
            .font(.system(size: 20, weight: .semibold, design: .rounded))
            .foregroundColor(theme.primaryText.resolve(for: colorScheme))
            .frame(maxWidth: .infinity, alignment: .leading)
            .lineSpacing(9)
            .padding(EdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15))
    }
    
    func grayInfoTextStyle(colorScheme: ColorScheme, theme: Theme) -> some View {
        self
            .font(.system(size: 15, weight: .regular, design: .rounded))
            .foregroundColor(theme.secondaryText.resolve(for: colorScheme))
            .lineSpacing(7.5)
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(theme.infoBoxBackground.resolve(for: colorScheme))
            .cornerRadius(8)
    }
}
