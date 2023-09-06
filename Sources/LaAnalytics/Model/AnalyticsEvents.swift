import Foundation

public enum AnalyticsEvents: CaseIterable {
    case pageLoaded
    
    case loggedIn
    case loginError
    case login
    case loginPage
    
    case signedUp
    case signUpPage
    case signOut
    case signUpError
    case signUp
    
    case googleSignIn
    case appleSignIn
    case emailVerified
    case recoverEmailSent
    case passwordReset
    
    case helpClick
    
    case appOpened
    
    case faqToggled
    case courseShareClicked
    case lessonTopicClick
    case playTrailerClicked
    case courseCardClicked
    case categoryPillClicked
    
    case hamburgerMenuClicked
    case resourceButtonClicked
    case courseVideoPlayed
    case courseVideoStarted
    case courseVideoEnded
    
    case profileEditButtonClicked
    
    case paymentStarted
    case paymentFailed
    case paymentCompleted
    
}

extension AnalyticsEvents {
    public var template: [String: Any]? {
        switch self {
        case .pageLoaded:
            return [EventProperty.page.rawValue:""]
            
        case .loggedIn:
            return [EventProperty.mode.rawValue: ""]
            
        case .loginError:
            return [EventProperty.mode.rawValue: "", EventProperty.error.rawValue: ""]
            
        case .login:
            return [EventProperty.email.rawValue: ""]
            
        case .loginPage:
            return [EventProperty.page.rawValue: "", EventProperty.from.rawValue: ""]
            
        case .signedUp:
            return [EventProperty.mode.rawValue: ""]
            
        case .signUpPage:
            return [EventProperty.page.rawValue: ""]
            
        case .signUpError:
            return [EventProperty.mode.rawValue: "", EventProperty.error.rawValue: "", EventProperty.errorStatus.rawValue: ""]
            
        case .signUp:
            return [EventProperty.email.rawValue: "", EventProperty.couponCode.rawValue: ""]
            
        case .signOut:
            return [EventProperty.page.rawValue:""]
            
        case .googleSignIn:
            return [EventProperty.page.rawValue: "", EventProperty.couponCode.rawValue:""]
            
        case .appleSignIn:
            return [EventProperty.page.rawValue: "", EventProperty.couponCode.rawValue:""]
            
        case .emailVerified:
            return nil
            
        case .recoverEmailSent:
            return nil
            
        case .passwordReset:
            return nil
            
        case .helpClick:
            return [EventProperty.page.rawValue:""]
            
        case .appOpened:
            return [EventProperty.eventCategory.rawValue: EventCategory.home.rawValue, EventProperty.eventAction.rawValue: EventAction.click.rawValue]
            
        case .faqToggled:
            return [EventProperty.page.rawValue:"", EventProperty.faqQuestion.rawValue:""]
            
        case .courseShareClicked:
            return [EventProperty.courseTheme.rawValue: "",
                    EventProperty.courseId.rawValue: "",
                    EventProperty.courseName.rawValue: "",
                    EventProperty.courseCategory.rawValue: "",
                    EventProperty.courseType.rawValue: "",
                    EventProperty.language.rawValue: "",
                    EventProperty.page.rawValue: ""]
            
        case .lessonTopicClick:
            return [EventProperty.courseTheme.rawValue: "",
                    EventProperty.courseId.rawValue: "",
                    EventProperty.courseName.rawValue: "",
                    EventProperty.courseCategory.rawValue: "",
                    EventProperty.courseType.rawValue: "",
                    EventProperty.language.rawValue: "",
                    EventProperty.page.rawValue: "",
                    EventProperty.courseLevel.rawValue: ""]
            
        case .playTrailerClicked:
            return [EventProperty.courseTheme.rawValue: "",
                    EventProperty.courseId.rawValue: "",
                    EventProperty.courseName.rawValue: "",
                    EventProperty.courseCategory.rawValue: "",
                    EventProperty.courseType.rawValue: "",
                    EventProperty.language.rawValue: "",
                    EventProperty.page.rawValue: "",
                    EventProperty.courseLevel.rawValue: ""]
            
        case .hamburgerMenuClicked:
            return [EventProperty.page.rawValue: ""]
            
        case .courseCardClicked:
            return [EventProperty.courseTheme.rawValue: "",
                    EventProperty.courseId.rawValue: "",
                    EventProperty.courseName.rawValue: "",
                    EventProperty.courseCategory.rawValue: "",
                    EventProperty.courseType.rawValue: "",
                    EventProperty.language.rawValue: "",
                    EventProperty.page.rawValue: ""]
            
        case .categoryPillClicked:
            return [ EventProperty.eventCategory.rawValue: "",
                     EventProperty.page.rawValue: ""]
            
        case .resourceButtonClicked:
            return [EventProperty.page.rawValue: "",
                    EventProperty.link.rawValue: ""]
            
        case .courseVideoPlayed:
            return [EventProperty.courseTheme.rawValue: "",
                    EventProperty.courseId.rawValue: "",
                    EventProperty.courseName.rawValue: "",
                    EventProperty.courseCategory.rawValue: "",
                    EventProperty.courseType.rawValue: "",
                    EventProperty.language.rawValue: "",
                    EventProperty.videoName.rawValue: "",
                    EventProperty.page.rawValue: ""]
            
        case .courseVideoStarted:
            return [EventProperty.courseTheme.rawValue: "",
                    EventProperty.courseId.rawValue: "",
                    EventProperty.courseName.rawValue: "",
                    EventProperty.courseCategory.rawValue: "",
                    EventProperty.courseType.rawValue: "",
                    EventProperty.language.rawValue: "",
                    EventProperty.videoName.rawValue: "",
                    EventProperty.page.rawValue: ""]
            
        case .courseVideoEnded:
            return [EventProperty.courseTheme.rawValue: "",
                    EventProperty.courseId.rawValue: "",
                    EventProperty.courseName.rawValue: "",
                    EventProperty.courseCategory.rawValue: "",
                    EventProperty.courseType.rawValue: "",
                    EventProperty.language.rawValue: "",
                    EventProperty.videoName.rawValue: "",
                    EventProperty.page.rawValue: ""]
            
        case .profileEditButtonClicked:
            return [EventProperty.page.rawValue:""]
            
        case .paymentStarted:
            return [EventProperty.paymentType.rawValue: "",
                    EventProperty.paymentGateway.rawValue: "",
                    EventProperty.planName.rawValue: "",
                    EventProperty.page.rawValue: "",
                    EventProperty.paymentAmount.rawValue: ""]
            
        case .paymentFailed:
            return [EventProperty.paymentType.rawValue: "",
                    EventProperty.paymentGateway.rawValue: "",
                    EventProperty.planName.rawValue: "",
                    EventProperty.page.rawValue: "",
                    EventProperty.error.rawValue: "",
                    EventProperty.errorStatus.rawValue: "",
                    EventProperty.paymentAmount.rawValue: ""]
        
        case .paymentCompleted:
            return [EventProperty.paymentType.rawValue: "",
                    EventProperty.paymentGateway.rawValue: "",
                    EventProperty.planName.rawValue: "",
                    EventProperty.page.rawValue: "",
                    EventProperty.paymentAmount.rawValue: ""]
        }
    }
}
