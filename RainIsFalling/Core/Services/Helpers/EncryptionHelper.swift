import Foundation
import Security

final class APIKeyManager {
    
    static let shared = APIKeyManager()
    
    private let keyBytes: [UInt8] = [
        101,50,55,49,102,97,102,53,55,55,97,56,52,48,102,
        50,57,50,50,50,50,51,50,53,55,50,54,48,57,48,51
    ]
    
    func getKey() -> String {
        if let existing = KeychainAPIKeyStorage.shared.load() {
            return existing
        }
        
        let key = String(bytes: keyBytes, encoding: .utf8) ?? ""
        
        KeychainAPIKeyStorage.shared.save(key: key)
        
        return key
    }
}
