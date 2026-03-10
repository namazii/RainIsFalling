import Foundation

enum AppEnvironment {
    case production
    case staging

    static var current: AppEnvironment {
        #if DEBUG
        return .staging
        #else
        return .production
        #endif
    }
}

enum AppConfig {

    static let environment = AppEnvironment.current

    static let configuration = AppEnvironmentConfiguration.configuration(
        for: environment
    )
}

struct AppEnvironmentConfiguration {

    let backendBaseURL: String
    let backendCleanPath: String
    let weatherAPIKey: String

    static func configuration(for environment: AppEnvironment) -> Self {
        let key = APIKeyManager.shared.getKey()

        switch environment {
        case .production:
            return .init(
                backendBaseURL: "https://api.weatherapi.com/",
                backendCleanPath: .empty,
                weatherAPIKey: key
            )

        case .staging:
            return .init(
                backendBaseURL: "https://api.weatherapi.com/",
                backendCleanPath: .empty,
                weatherAPIKey: key
            )
        }
    }
}
