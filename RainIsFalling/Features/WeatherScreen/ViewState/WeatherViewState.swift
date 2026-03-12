struct HourlyItem {
    let time: String
    let temp: String
}

struct DailyItem {
    let day: String
    let range: String
}

struct WeatherViewState {
    private(set) var city: String
    private(set) var currentTemp: String
    private(set) var hourly: [HourlyItem]
    private(set) var daily: [DailyItem]
    private(set) var isLoading: Bool
    private(set) var errorMessage: String?
}

extension WeatherViewState {
    init(city: String) {
        self.city = city
        self.currentTemp = "--"
        self.hourly = []
        self.daily = []
        self.isLoading = false
        self.errorMessage = nil
    }
    
    func copy(
        city: String? = nil,
        currentTemp: String? = nil,
        hourly: [HourlyItem]? = nil,
        daily: [DailyItem]? = nil,
        isLoading: Bool? = nil,
        errorMessage: String? = nil
    ) -> WeatherViewState {
        WeatherViewState(
            city: city ?? self.city,
            currentTemp: currentTemp ?? self.currentTemp,
            hourly: hourly ?? self.hourly,
            daily: daily ?? self.daily,
            isLoading: isLoading ?? self.isLoading,
            errorMessage: errorMessage
        )
    }
}
