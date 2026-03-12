import UIKit

final class AppAssembly {

    private let locationService: LocationServicing
    private let weatherService: WeatherNetworkManagerProtocol

    init(
        locationService: LocationServicing = LocationManager.shared,
        weatherService: WeatherNetworkManagerProtocol = WeatherNetworkManager()
    ) {
        self.locationService = locationService
        self.weatherService = weatherService
    }

    @MainActor
    func makeAppCoordinator(window: UIWindow) -> AppCoordinator {
        let router = AppRouter(window: window)
        let splashAssembly = SplashAssembly(locationService: locationService)
        let weatherAssembly = WeatherAssembly(weatherService: weatherService)

        return AppCoordinator(
            router: router,
            splashFactory: {
                splashAssembly.makeSplashViewController()
            },
            weatherFactory: { city in
                weatherAssembly.makeWeatherViewController(city: city)
            }
        )
    }
}
