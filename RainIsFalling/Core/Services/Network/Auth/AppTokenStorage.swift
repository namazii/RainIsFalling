import Foundation
import Security
import SwiftlyNetFlex

struct AppTokenModel: TokenModelProtocol {
    var accessToken: String
    var refreshToken: String
}

protocol AppTokenStorageProtocol {
    func save(key: String)
    func load() -> String?
    func delete() 
}

final class KeychainAPIKeyStorage {

    static let shared = KeychainAPIKeyStorage()

    private let service = "weather.api.key"
    private let account = "default"

    func save(key: String) {

        let data = key.data(using: .utf8)!

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecValueData as String: data
        ]

        SecItemDelete(query as CFDictionary)
        SecItemAdd(query as CFDictionary, nil)
    }

    func load() -> String? {

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecReturnData as String: true
        ]

        var result: AnyObject?

        let status = SecItemCopyMatching(query as CFDictionary, &result)

        guard status == errSecSuccess else { return nil }

        guard let data = result as? Data else { return nil }

        return String(data: data, encoding: .utf8)
    }

    func delete() {

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]

        SecItemDelete(query as CFDictionary)
    }
}
