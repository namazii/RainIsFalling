final class SplashAssembly {
    private let locationService: LocationServicing

    init(locationService: LocationServicing) {
        self.locationService = locationService
    }

    func makeSplashViewController() -> SplashVC {
        let viewModel = SplashViewModel(locationService: locationService)
        return SplashVC(viewModel: viewModel)
    }
}
