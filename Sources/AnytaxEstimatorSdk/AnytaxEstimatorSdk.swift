import SwiftUI
import UIKit

public struct AnytaxEstimatorContentView: View {
    @StateObject private var viewModel: TaxEstimationViewModel
    
    public init(onFinishFlow: @escaping () -> Void) {
        _viewModel = StateObject(
            wrappedValue: TaxEstimationViewModel(onFinishFlow: onFinishFlow)
        )
    }
    
    public var body: some View {
        WelcomeScreen(viewModel: viewModel)
    }
}

#Preview {
    AnytaxEstimatorContentView(onFinishFlow: {})
}

public class AnytaxEstimatorContentViewController: UIViewController {
    
    let onFinishFlow: () -> Void
    
    public init(onFinishFlow: @escaping () -> Void) {
        self.onFinishFlow = onFinishFlow
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        let swiftUIView = AnytaxEstimatorContentView(onFinishFlow: onFinishFlow)
        let hostingController = UIHostingController(rootView: swiftUIView)
        addChild(hostingController)
        hostingController.view.frame = view.bounds
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
    }
}
