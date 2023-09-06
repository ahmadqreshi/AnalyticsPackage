import Foundation

// MARK: - Profile
struct ProfileModel: Codable {
    let userID,email: String
    let firstName, lastName, phone, avatarURL: String?
    let isVerified: Bool
    let isSuspended: Bool?
    let roles: [String]
    var preferences: Preferences?
    let orgID: String
    let notificationSettings: NotificationSettings
    let city, country: String?
    let accessPolicy: [AccessPolicy]
    let linkedAccounts: [LinkedAccount]?
    let createdAt, updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case firstName, lastName, phone, email
        case avatarURL = "avatarUrl"
        case isVerified, isSuspended, roles, preferences, city, country
        case orgID = "orgId"
        case notificationSettings, accessPolicy, linkedAccounts, createdAt, updatedAt
    }
}

// MARK: - AccessPolicy
struct AccessPolicy: Codable {
    let type: AccessType
    let access: [Access]
}

enum AccessType: String, CaseIterable, Codable {
    case course = "COURSE"
    case webinar = "WEBINAR"
    case playlist = "PLAYLIST"
    case learningMap = "LEARNING_MAP"
    case advanceCourse = "ADVANCE_COURSE"
    case workshop = "WORKSHOP"
    case basePlan = "BASE_PLAN"
}

// MARK: - Access
struct Access: Codable {
    let ids: [String]
    let expiry, planID, paymentType: String
    
    enum CodingKeys: String, CodingKey {
        case ids, expiry
        case planID = "planId"
        case paymentType
    }
}

// MARK: - LinkedAccount
struct LinkedAccount: Codable {
    let id, name: String
}

// MARK: - preferences
struct Preferences: Codable {
    let android: AndroidUserPreferences?
    let ios: iOSUserPreferences?
    var stats: AllCoursesStats?
    let freeCourse: FreeCourse?
    let onBoarding: OnBoarding?
}

struct OnBoarding: Codable {
    let type: String
    let experience: String?
}

struct FreeCourse: Codable {
    let id: String
}

struct AndroidUserPreferences: Codable {
    let utm: UtmParam?
    let fcmToken: String?
    let videoSettingsDto: VideoSettingsDto?
}

struct iOSUserPreferences: Codable {
    let utm: UtmParam?
}

struct AllCoursesStats: Codable {}

struct UtmParam: Codable {
    let utmSource: String?
    let utmMedium: String?
    let utmCampaign: String?
    let utmContent: String?
    let utmTerm: String?
}

struct VideoSettingsDto: Codable {
    let speed: String
    let quality: String?
    let downloadQuality: String?
}

struct NotificationSettings: Codable {
    let emailSetting: EmailSetting
    let pushSetting: PushSetting
}

// MARK: - EmailSetting
struct EmailSetting: Codable {
    let offers, newsLetters: Bool
}

// MARK: - PushSetting
struct PushSetting: Codable {
    let offers: Bool
}
