import Foundation

enum UserProperty: String {
    case advancedPaid = "Advance Paid"
    case isAdvancePaid = "Is Advanced Paid"
    case coursesPaid = "Courses Paid"
    case email = "email"
    case moengageUserId = "moengage_user_id"
    case name = "name"
    case onBoardingExperience = "Onboarding Experience"
    case onBoardingType = "Onboarding Type"
    case phoneNumber = "phone"
    case signUpDate = "Sign Up Date"
    case state = "State"
    case subscriptionCount = "Subscription Count"
    case subscriptionExpiry = "Subscription Expiry"
    case isSubscriptionPaid = "Is Subscription Paid"
    case subscriptionPaid = "Subscription Paid"
    case subscriptionStartDate = "Subscription Start Date"
    case userActivated = "Activated"
    case userUniqueId = "ID"
    case utmCampaign = "UTM Campaign"
    case utmContent = "UTM Content"
    case utmMedium = "UTM Medium"
    case utmSource = "UTM Source"
    case utmTerm = "UTM Term"
    case emailSettingOffer = "Email Offers"
    case emailSettingsNewsLetter = "Email Newsletters"
    
    case fullName = "Full Name"
    case firstName = "First Name"
    case lastName = "Last Name"
    
}

enum UserState: String {
    case loggedIn = "Logged In"
    case loggedOut = "Logged Out"
}
