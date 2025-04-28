import SwiftUI
import UIKit

public struct AnytaxEstimatorContentView: View {
    @StateObject private var viewModel: TaxEstimationViewModel
    @Environment(\.theme) private var theme
    
    public init(config: AnytaxEstimatorConfig) {
        _viewModel = StateObject(
            wrappedValue: TaxEstimationViewModel(config: config)
        )
    }
    
    public var body: some View {
        Group {
            if viewModel.config.skipSplashScreen {
                TaxEstimatorScreen(viewModel: viewModel)
            } else {
                WelcomeScreen(viewModel: viewModel)
            }
        }
        .environment(\.theme, viewModel.config.theme)
    }
}

#Preview {
    AnytaxEstimatorContentView(
        config: AnytaxEstimatorConfig(
            onFinishFlow: { _ in }
        )
    )
}

public class AnytaxEstimatorContentViewController: UIViewController {
    private let config: AnytaxEstimatorConfig
    
    public init(config: AnytaxEstimatorConfig) {
        self.config = config
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        let swiftUIView = AnytaxEstimatorContentView(config: config)
        let hostingController = UIHostingController(rootView: swiftUIView)
        addChild(hostingController)
        hostingController.view.frame = view.bounds
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
    }
}
