final class SplashViewModel {

    private let locationService: LocationServicing

    init(locationService: LocationServicing) {
        self.locationService = locationService
    }

    func requestCity(completion: @escaping (String) -> Void) {
        locationService.requestCity(completion: completion)
    }
}
