import SwiftlyNetFlex

protocol WeatherNetworkManagerProtocol {
    func fetchForecast(city: String, days: Int) async throws -> WeatherResponse
}

final class WeatherNetworkManager: WeatherNetworkManagerProtocol {

    private let router = NetworkRouter<NoTokenRefreshConfiguration>(
        refreshTokenConfigurator: NoTokenRefreshConfiguration()
    )

    func fetchForecast(city: String, days: Int) async throws -> WeatherResponse {
        try await self.router.request(
            dataType: WeatherResponse.self,
            WeatherEndPoints.fetchForecast(city: city, days: days)
        )
    }
}
