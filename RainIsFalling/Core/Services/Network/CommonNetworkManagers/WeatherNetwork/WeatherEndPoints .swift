import SwiftlyNetFlex

final class WeatherEndPoints {

    static let baseUrl = AppConfig.configuration.backendBaseURL

    static func fetchForecast(city: String, days: Int) -> EndPointType {
        let test = EndPointBuilder(
            baseUrl: baseUrl,
            path: "v1/forecast.json",
            httpMethod: .get,
            headers: [:],
            bodyParam: nil,
            urlParam: [
                "key": AppConfig.configuration.weatherAPIKey,
                "q": city,
                "days": String(days)
            ]
        ).build()
        
        print(test)
        
        return test
    }
}
