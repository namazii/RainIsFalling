import UIKit
import SnapKit

final class SplashVC: UIViewController {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String ?? "RainIsFalling"
        label.font = .systemFont(ofSize: 34, weight: .bold)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()

    private var didTransition = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.BackGround.primary
        view.addSubview(titleLabel)

        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        guard !didTransition else { return }
        didTransition = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) { [weak self] in
            self?.showMainScreen()
        }
    }

    private func showMainScreen() {
        guard let windowScene = view.window?.windowScene else { return }
        guard let sceneDelegate = windowScene.delegate as? SceneDelegate else { return }

        let mainViewController = ViewController()
        UIView.transition(
            with: sceneDelegate.window ?? UIWindow(),
            duration: 0.25,
            options: .transitionCrossDissolve,
            animations: {
                sceneDelegate.window?.rootViewController = mainViewController
            }
        )
    }
}
