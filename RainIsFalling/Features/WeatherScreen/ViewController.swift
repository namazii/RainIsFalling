import UIKit
import SwiftlyNetFlex

final class ViewController: UIViewController {

    private let weatherService: WeatherNetworkManagerProtocol = WeatherNetworkManager()

    override func viewDidLoad() {
        super.viewDidLoad()

#if DEBUG
        view.backgroundColor = .red
#else
        view.backgroundColor = .blue
#endif

        Task {
            await loadWeatherPreviewData()
        }
    }

    private func loadWeatherPreviewData() async {
        do {
            let response = try await weatherService.fetchForecast(city: "", days: 3)
         
        } catch {
           
        }
    }
}
