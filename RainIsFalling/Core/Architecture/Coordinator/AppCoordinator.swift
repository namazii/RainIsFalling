import UIKit

@MainActor
final class AppCoordinator:  Coordinator {

    private let router: AppRouting
    private let splashFactory: () -> SplashVC
    private let weatherFactory: (String) -> UIViewController

    init(
        router: AppRouting,
        splashFactory: @escaping () -> SplashVC,
        weatherFactory: @escaping (String) -> UIViewController
    ) {
        self.router = router
        self.splashFactory = splashFactory
        self.weatherFactory = weatherFactory
    }

    func start() {
        let splash = splashFactory()
        splash.onCityResolved = { [weak self] city in
            self?.showWeather(city: city)
        }
        router.setRoot(splash, animated: false)
    }

    private func showWeather(city: String) {
        let weather = weatherFactory(city)
        router.setRoot(weather, animated: true)
    }
}
