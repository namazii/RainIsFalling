import UIKit
import SnapKit

final class SplashVC: UIViewController {

    var onCityResolved: ((String) -> Void)?

    private let viewModel: SplashViewModel

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "RainIsFalling"
        label.font = .systemFont(ofSize: 34, weight: .bold)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()

    private var didTransition = false

    init(viewModel: SplashViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Colors.BackGround.primary
        view.addSubview(titleLabel)

        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        guard !didTransition else { return }
        didTransition = true

        requestLocation()
    }

    private func requestLocation() {
        viewModel.requestCity { [weak self] city in
            guard let self else { return }
            DispatchQueue.main.async {
                self.onCityResolved?(city)
            }
        }
    }
}
