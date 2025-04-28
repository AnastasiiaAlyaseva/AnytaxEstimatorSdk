import SwiftUI

public struct Theme: Sendable {
    public static let `default` = Theme()
    
    let brandPrimaryColor: DynamicColor
    let questionRowBackground: DynamicColor
    let semiTransparentBackground: DynamicColor
    let infoBoxBackground: DynamicColor
    let primaryText: DynamicColor
    let secondaryText: DynamicColor
    let elementBackground: DynamicColor
      
    // MARK: - Init
    
    public init(
        brandPrimaryColor: DynamicColor? = nil,
        questionRowBackground: DynamicColor? = nil,
        semiTransparentBackground: DynamicColor? = nil,
        infoBoxBackground: DynamicColor? = nil,
        primaryText: DynamicColor? = nil,
        secondaryText: DynamicColor? = nil,
        elementBackground: DynamicColor? = nil
    ) {
        self.brandPrimaryColor = brandPrimaryColor ?? .dynamic(
            light: Color.brandPrimaryColor,
            dark: Color.brandPrimaryColor
        )
        self.questionRowBackground = questionRowBackground ?? .dynamic(
            light: Color.questionRowBackground(colorScheme: .light),
            dark: Color.questionRowBackground(colorScheme: .dark)
        )
        self.semiTransparentBackground = semiTransparentBackground ?? .dynamic(
            light: Color.semiTransparentBackground(colorScheme: .light),
            dark:  Color.semiTransparentBackground(colorScheme: .dark)
        )
        self.infoBoxBackground = infoBoxBackground ?? .dynamic(
            light: Color.infoBoxBackground(colorScheme: .light),
            dark: Color.infoBoxBackground(colorScheme: .dark)
        )
        self.primaryText = primaryText ?? .systemColor(Color.primaryText)
        self.secondaryText = secondaryText ?? .systemColor(Color.secondaryText)
        self.elementBackground = elementBackground ?? .systemColor(Color.elementBackground)
    }
}
