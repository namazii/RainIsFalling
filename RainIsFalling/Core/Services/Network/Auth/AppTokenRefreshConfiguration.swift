import Foundation
import SwiftlyNetFlex

struct NoTokenRefreshConfiguration: TokenRefreshConfiguration {
    func getRefreshToken() -> String? {
        nil
    }

    func makeRefreshTokenEndpoint(refreshToken: String) -> EndPointType {
        EndPointBuilder(
            baseUrl: AppConfig.configuration.backendCleanPath,
            path: String.empty,
            httpMethod: .post,
            headers: [:],
            bodyParam: nil,
            urlParam: nil
        ).build()
    }
    
    var onTokenRefreshFailed: (() -> Void)?
    
    func saveTokens(_ token: AppTokenModel) {}
}
