import SwiftUI

/*
 More information about dynamic colours in UIKit can be found in Apple's documentation:
 https://developer.apple.com/design/human-interface-guidelines/colo
 */

extension Color {
    static func systemBlue(colorScheme: ColorScheme) -> Color {
        Color(red: 45/255, green: 64/255, blue: 239/255)
    }
    
    static func backgroundColorWithOpacity(colorScheme: ColorScheme) -> Color {
        colorScheme == .dark
            ? Color(red: 60/255, green: 63/255, blue: 94/255).opacity(0.6)
            : Color(red: 235/255, green: 237/255, blue: 255/255).opacity(0.6)
    }
    
    static func backgroundColor(colorScheme: ColorScheme) -> Color {
        colorScheme == .dark
            ? Color(red: 60/255, green: 63/255, blue: 94/255)
            : Color(red: 235/255, green: 237/255, blue: 255/255)
    }
    static func infoTextStyle(colorScheme: ColorScheme) -> Color {
        colorScheme == .dark
            ? Color(red: 60/255, green: 63/255, blue: 94/255).opacity(0.6)
            : Color(red: 247/255, green: 245/255, blue: 250/255)
    }
    
    //Use UIColor for dynamic colours, since in SwiftUI Color is static
    static var label: Color {
        Color(UIColor.label)
    }
    
    static var secondaryLabel: Color {
        Color(UIColor.secondaryLabel)
    }
    
    static var background: Color {
        Color(UIColor.systemBackground)
    }
}
