import UIKit

final class WeatherAssembly {

    private let weatherService: WeatherNetworkManagerProtocol

    init(weatherService: WeatherNetworkManagerProtocol) {
        self.weatherService = weatherService
    }

    @MainActor
    func makeWeatherViewController(city: String) -> UIViewController {
        let viewModel = WeatherViewModel(city: city, weatherService: weatherService)
        return WeatherVC(viewModel: viewModel)
    }
}
