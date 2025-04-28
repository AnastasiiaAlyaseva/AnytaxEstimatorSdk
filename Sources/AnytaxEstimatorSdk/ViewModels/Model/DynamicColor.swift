import SwiftUI

public enum DynamicColor: Sendable {
    case dynamic(light: Color, dark: Color)
    case systemColor(Color)
    
    public static func systemUIColor(_ uiColor: UIColor) -> DynamicColor {
        .systemColor(Color(uiColor))
    }
    
    // MARK: - Internal
    
    func resolve(for scheme: ColorScheme) -> Color {
        switch self {
        case .dynamic(let light, let dark):
            scheme == .dark ? dark : light
        case .systemColor(let color):
            color
        }
    }
    
    var lightColor: Color {
        resolve(for: .light)
    }
    
    var darkColor: Color {
        resolve(for: .dark)
    }
}
