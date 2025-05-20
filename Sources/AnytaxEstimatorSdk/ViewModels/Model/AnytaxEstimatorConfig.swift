import SwiftUI

public struct AnytaxEstimatorConfig {
    public let isAppEmbedded: Bool
    public let skipSplashScreen: Bool
    public let theme: Theme
    public let apiKey: String
    public let resultView: ((_ displayValue: String) -> AnyView)?
    public let onScreenAppeared: ((_ screen: AnalyticsScreen) -> Void)?
    public let onFinishFlow: (_ screen: AnalyticsScreen) -> Void
    
    public init(
        isAppEmbedded: Bool = false,
        skipSplashScreen: Bool = false,
        theme: Theme = .default,
        apiKey: String,
        resultView: ((_ displayValue: String) -> AnyView)? = nil,
        onScreenAppeared: ((AnalyticsScreen) -> Void)? = nil,
        onFinishFlow: @escaping (_ screen: AnalyticsScreen) -> Void
    ) {
        self.isAppEmbedded = isAppEmbedded
        self.skipSplashScreen = skipSplashScreen
        self.theme = theme
        self.apiKey = apiKey
        self.resultView = resultView
        self.onScreenAppeared = onScreenAppeared
        self.onFinishFlow = onFinishFlow
    }
}
