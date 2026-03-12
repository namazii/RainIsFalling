import Foundation
import Combine

enum WeatherIntent {
    case fetchForecast
    case retry
    case setLoading(Bool)
    case setData(city: String, currentTemp: String, hourly: [HourlyItem], daily: [DailyItem])
    case failed(String)
}

final class WeatherViewModel: ViewModelIntent {

    @Published private(set) var state: WeatherViewState

    private let cityQuery: String
    private let weatherService: WeatherNetworkManagerProtocol


    init(city: String, weatherService: WeatherNetworkManagerProtocol) {
        self.cityQuery = city
        self.weatherService = weatherService
        self.state = WeatherViewState(city: city)
    }

    var statePublisher: AnyPublisher<WeatherViewState, Never> {
        $state.eraseToAnyPublisher()
    }

    func send(_ intent: WeatherIntent) {
        switch intent {
        case .fetchForecast, .retry:
            Task { await fetchForecastTask() }
        default:
            state = reduce(intent)
        }
    }

    private func reduce(_ intent: WeatherIntent) -> WeatherViewState {
        switch intent {
        case .fetchForecast, .retry:
            return state
        case let .setLoading(isLoading):
            return state.copy(isLoading: isLoading, errorMessage: isLoading ? nil : state.errorMessage)
        case let .setData(city, currentTemp, hourly, daily):
            return state.copy(
                city: city,
                currentTemp: currentTemp,
                hourly: hourly,
                daily: daily,
                isLoading: false,
                errorMessage: nil
            )
        case let .failed(message):
            return state.copy(isLoading: false, errorMessage: message)
        }
    }

    @MainActor
    private func fetchForecastTask() async {
        send(.setLoading(true))
        do {
            let response = try await weatherService.fetchForecast(city: cityQuery, days: 3)
            let data = makeData(from: response)
            send(.setData(city: data.city, currentTemp: data.currentTemp, hourly: data.hourly, daily: data.daily))
        } catch {
            send(.failed("Не удалось загрузить погоду.\nПроверьте интернет и попробуйте снова."))
        }
    }

    private func makeData(from response: WeatherResponse) -> (city: String, currentTemp: String, hourly: [HourlyItem], daily: [DailyItem]) {
        let currentTemp: String
        if let temp = response.current.tempC {
            currentTemp = "\(Int(temp))°"
        } else {
            currentTemp = "--"
        }

        let now = Date()
        let todayHours = response.forecast.forecastday.first?.hour ?? []
        let remainingToday = todayHours.filter { hour in
            guard let date = Formatter.weatherHour.date(from: hour.time) else { return false }
            return date >= now
        }
        let tomorrowHours = response.forecast.forecastday.dropFirst().first?.hour ?? []
        let combinedHours = remainingToday + tomorrowHours
        let hourly = combinedHours.map {
            let time = $0.time.components(separatedBy: " ").last ?? "00:00"
            let temp = Int($0.tempC ?? 0)
            return HourlyItem(time: time, temp: "\(temp)°")
        }

        let daily = response.forecast.forecastday.map { forecastDay in
            let date = Formatter.weatherDate.date(from: forecastDay.date) ?? Date()
            let weekday = Formatter.weatherWeekday.string(from: date).capitalized
            let minTemp = Int(forecastDay.day.mintempC ?? 0)
            let maxTemp = Int(forecastDay.day.maxtempC ?? 0)
            return DailyItem(day: weekday, range: "\(minTemp)-\(maxTemp)°")
        }

        return (city: response.location.name, currentTemp: currentTemp, hourly: hourly, daily: daily)
    }
}
