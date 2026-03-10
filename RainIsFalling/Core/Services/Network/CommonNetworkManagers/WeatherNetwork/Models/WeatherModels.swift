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
    let temp_c: Double?
    let feelslike_c: Double?
    let humidity: Int
    let wind_kph: Double?
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
    let maxtemp_c: Double?
    let mintemp_c: Double?
    let condition: Condition
}

struct Hour: Codable {
    let time: String
    let temp_c: Double?
    let is_day: Int?
    let condition: Condition
}
