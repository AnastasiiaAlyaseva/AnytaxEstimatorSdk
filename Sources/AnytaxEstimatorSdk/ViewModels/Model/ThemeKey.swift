import SwiftUI

extension EnvironmentValues {
    private struct ThemeKey: EnvironmentKey {
        static let defaultValue: Theme = .default
    }
    
    var theme: Theme {
        get { self[ThemeKey.self] }
        set { self[ThemeKey.self] = newValue }
    }
}
