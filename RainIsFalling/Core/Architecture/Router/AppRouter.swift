import UIKit

final class AppRouter: AppRouting {

    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func setRoot(_ viewController: UIViewController, animated: Bool) {
        if animated {
            UIView.transition(
                with: window,
                duration: 0.25,
                options: .transitionCrossDissolve,
                animations: {
                    self.window.rootViewController = viewController
                }
            )
        } else {
            window.rootViewController = viewController
        }
    }
}
