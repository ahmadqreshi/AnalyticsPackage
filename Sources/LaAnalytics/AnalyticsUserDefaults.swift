import Foundation

class AnalyticsUserDefaults {
    static let shared = AnalyticsUserDefaults()
    
    private init() {}
    
    enum Key: String {
        case isUserLoggedIn
        case accessToken
        case refreshToken
        case tokenExpiryDate
        case userProfile
        case isAdvancedCourseSubscribed
        case isBasePlanSubscribed
        case isSingleCourseSubscribed
        case basePlanId
        case subscriptionExpiry
        case utm
        case subscriptionCount
        case subscriptionStartDate
    }
}

extension AnalyticsUserDefaults {
    func value(forKey key: Key) -> Any? {
        guard let value = UserDefaults.standard.object(forKey: key.rawValue) else {
            return nil
        }
        return value
    }
    
    func getUserProfile() -> ProfileModel? {
        return decodeAndFetch(ProfileModel.self, key: .userProfile)
    }
}

extension AnalyticsUserDefaults {
    
    private func decodeAndFetch<T: Codable>(_ type: T.Type, key: AnalyticsUserDefaults.Key) -> T? {
        guard let savedData = value(forKey: key) as? Data else { return nil }
        let decoder = JSONDecoder()
        guard let loadedData = try? decoder.decode(T.self, from: savedData) else { return nil }
        return loadedData
    }
}
