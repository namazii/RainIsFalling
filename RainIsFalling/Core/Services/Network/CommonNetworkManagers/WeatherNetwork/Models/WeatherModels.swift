struct WeatherResponse: Codable {
    let location: Location
    let current: CurrentWeather
    let forecast: Forecast
}

struct Location: Codable {
    let name: String
    let lat: Double
    let lon: Double
    let localtime: String
}

struct CurrentWeather: Codable {
    let tempC: Double?
    let feelslikeC: Double?
    let humidity: Int
    let windKph: Double?
    let condition: Condition
}

struct Condition: Codable {
    let text: String
    let icon: String
}

struct Forecast: Codable {
    let forecastday: [ForecastDay]
}

struct ForecastDay: Codable {
    let date: String
    let day: Day
    let hour: [Hour]
}

struct Day: Codable {
    let maxtempC: Double?
    let mintempC: Double?
    let condition: Condition
}

struct Hour: Codable {
    let time: String
    let tempC: Double?
    let isDay: Int?
    let condition: Condition
}
