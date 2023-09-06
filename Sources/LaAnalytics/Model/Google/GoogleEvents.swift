import Foundation

enum GoogleEvents: CaseIterable {
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
    case recoveryEmailSent
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

extension GoogleEvents {
    var eventTemplate: (eventName: String, analyticsEvent: AnalyticsEvents, eventProperties: [String: Any]?) {
        switch self {
        case .pageLoaded:
            return (
                EventName.pageLoaded.rawValue,
                AnalyticsEvents.pageLoaded,
                [EventProperty.page.rawValue: ""]
            )
            
        case .loggedIn:
            return (EventName.loggedIn.rawValue, AnalyticsEvents.loggedIn, [EventProperty.mode.rawValue: ""])
            
        case .loginError:
            return (EventName.loginError.rawValue, AnalyticsEvents.loginError, [EventProperty.mode.rawValue: "", EventProperty.error.rawValue: ""])
            
        case .login:
            return (EventName.login.rawValue, AnalyticsEvents.login, [EventProperty.email.rawValue: ""])
            
        case .loginPage:
            return (EventName.loginPage.rawValue, AnalyticsEvents.loginPage, [EventProperty.page.rawValue: "", EventProperty.from.rawValue: ""])
            
        case .signedUp:
            return (EventName.signedUp.rawValue, AnalyticsEvents.signedUp, [EventProperty.mode.rawValue: ""])
            
        case .signUpPage:
            return (EventName.signUpPage.rawValue, AnalyticsEvents.signUpPage, [EventProperty.page.rawValue: ""])
            
        case .signUpError:
            return (EventName.signUpError.rawValue, AnalyticsEvents.signUpError, [EventProperty.mode.rawValue: "", EventProperty.error.rawValue: "", EventProperty.errorStatus.rawValue: ""])
            
        case .signUp:
            return (EventName.signUp.rawValue, AnalyticsEvents.signUp, [EventProperty.email.rawValue: "", EventProperty.couponCode.rawValue: ""])
            
        case .signOut:
            return (EventName.signUp.rawValue, AnalyticsEvents.signUp, [EventProperty.email.rawValue: "", EventProperty.couponCode.rawValue: ""])
            
        case .googleSignIn:
            return (EventName.googleSignIn.rawValue, AnalyticsEvents.googleSignIn, [EventProperty.page.rawValue: "", EventProperty.couponCode.rawValue:""])
            
        case .appleSignIn:
            return (EventName.appleSignIn.rawValue, AnalyticsEvents.appleSignIn, [EventProperty.page.rawValue: "", EventProperty.couponCode.rawValue:""])
            
        case .emailVerified:
            return (EventName.emailVerified.rawValue, AnalyticsEvents.emailVerified, nil)
            
        case .recoveryEmailSent:
            return (EventName.recoverEmailSent.rawValue, AnalyticsEvents.recoverEmailSent, nil)
            
        case .passwordReset:
            return (EventName.passwordReset.rawValue, AnalyticsEvents.passwordReset, nil)
            
        case .helpClick:
            return (EventName.pageLoaded.rawValue, AnalyticsEvents.helpClick, [EventProperty.page.rawValue: ""])
            
        case .appOpened:
            return (EventName.appOpened.rawValue, AnalyticsEvents.appOpened, [EventProperty.eventCategory.rawValue: EventCategory.home.rawValue, EventProperty.eventAction.rawValue: EventAction.click.rawValue])
            
        case .faqToggled:
            return (EventName.faqToggle.rawValue, AnalyticsEvents.faqToggled, [EventProperty.page.rawValue: "", EventProperty.faqQuestion.rawValue:""])
            
        case .courseShareClicked:
            return (EventName.courseShareClicked.rawValue, AnalyticsEvents.courseShareClicked,[EventProperty.courseTheme.rawValue: "",
                                                                                               EventProperty.courseId.rawValue: "",
                                                                                               EventProperty.courseName.rawValue: "",
                                                                                               EventProperty.courseCategory.rawValue: "",
                                                                                               EventProperty.courseType.rawValue: "",
                                                                                               EventProperty.language.rawValue: "",
                                                                                               EventProperty.page.rawValue: ""])
            
        case .lessonTopicClick:
            return (EventName.lessonTopicClick.rawValue, AnalyticsEvents.lessonTopicClick, [EventProperty.courseTheme.rawValue: "",
                                                                                            EventProperty.courseId.rawValue: "",
                                                                                            EventProperty.courseName.rawValue: "",
                                                                                            EventProperty.courseCategory.rawValue: "",
                                                                                            EventProperty.courseType.rawValue: "",
                                                                                            EventProperty.language.rawValue: "",
                                                                                            EventProperty.page.rawValue: "",
                                                                                            EventProperty.courseLevel.rawValue: ""])
            
        case .courseCardClicked:
            return (EventName.courseCardClicked.rawValue, AnalyticsEvents.courseCardClicked, [EventProperty.courseTheme.rawValue: "",
                                                                                              EventProperty.courseId.rawValue: "",
                                                                                              EventProperty.courseName.rawValue: "",
                                                                                              EventProperty.courseCategory.rawValue: "",
                                                                                              EventProperty.courseType.rawValue: "",
                                                                                              EventProperty.language.rawValue: "",
                                                                                              EventProperty.page.rawValue: ""])
        case .categoryPillClicked:
            return (EventName.categoryPillClicked.rawValue, AnalyticsEvents.categoryPillClicked, [EventProperty.eventCategory.rawValue: "",
                                                                                                  EventProperty.page.rawValue: ""])
            
        case .playTrailerClicked:
            return (EventName.playTrailerClicked.rawValue, AnalyticsEvents.playTrailerClicked, [EventProperty.courseTheme.rawValue: "",
                                                                                                EventProperty.courseId.rawValue: "",
                                                                                                EventProperty.courseName.rawValue: "",
                                                                                                EventProperty.courseCategory.rawValue: "",
                                                                                                EventProperty.courseType.rawValue: "",
                                                                                                EventProperty.language.rawValue: "",
                                                                                                EventProperty.page.rawValue: "",
                                                                                                EventProperty.courseLevel.rawValue: ""])
        case .hamburgerMenuClicked:
            return (EventName.hamburgerMenuClicked.rawValue, AnalyticsEvents.hamburgerMenuClicked, [EventProperty.page.rawValue: ""])
            
        case .resourceButtonClicked:
            return (EventName.resourceButtonClicked.rawValue, AnalyticsEvents.resourceButtonClicked, [EventProperty.page.rawValue: "",
                                                                                                      EventProperty.link.rawValue: ""])
            
        case .courseVideoPlayed:
            return (EventName.courseVideoPlayed.rawValue, AnalyticsEvents.courseVideoPlayed, [EventProperty.courseTheme.rawValue: "",
                                                                                              EventProperty.courseId.rawValue: "",
                                                                                              EventProperty.courseName.rawValue: "",
                                                                                              EventProperty.courseCategory.rawValue: "",
                                                                                              EventProperty.courseType.rawValue: "",
                                                                                              EventProperty.language.rawValue: "",
                                                                                              EventProperty.videoName.rawValue: "",
                                                                                              EventProperty.page.rawValue: ""])
            
        case .courseVideoStarted:
            return (EventName.courseVideoStarted.rawValue, AnalyticsEvents.courseVideoStarted, [EventProperty.courseTheme.rawValue: "",
                                                                                                EventProperty.courseId.rawValue: "",
                                                                                                EventProperty.courseName.rawValue: "",
                                                                                                EventProperty.courseCategory.rawValue: "",
                                                                                                EventProperty.courseType.rawValue: "",
                                                                                                EventProperty.language.rawValue: "",
                                                                                                EventProperty.videoName.rawValue: "",
                                                                                                EventProperty.page.rawValue: ""])
            
        case .courseVideoEnded:
            return (EventName.courseVideoEnded.rawValue, AnalyticsEvents.courseVideoEnded, [EventProperty.courseTheme.rawValue: "",
                                                                                            EventProperty.courseId.rawValue: "",
                                                                                            EventProperty.courseName.rawValue: "",
                                                                                            EventProperty.courseCategory.rawValue: "",
                                                                                            EventProperty.courseType.rawValue: "",
                                                                                            EventProperty.language.rawValue: "",
                                                                                            EventProperty.videoName.rawValue: "",
                                                                                            EventProperty.page.rawValue: ""])
            
        case .profileEditButtonClicked:
            return (EventName.pageLoaded.rawValue, AnalyticsEvents.profileEditButtonClicked, [EventProperty.page.rawValue: ""])
            
        case .paymentStarted:
            return (EventName.paymentStarted.rawValue, AnalyticsEvents.paymentStarted, [EventProperty.paymentType.rawValue: "",
                                                                                        EventProperty.paymentGateway.rawValue: "",
                                                                                        EventProperty.planName.rawValue: "",
                                                                                        EventProperty.page.rawValue: "",
                                                                                        EventProperty.paymentAmount.rawValue: ""])
        case .paymentFailed:
            return (EventName.paymentFailed.rawValue, AnalyticsEvents.paymentFailed, [EventProperty.paymentType.rawValue: "",
                                                                                      EventProperty.paymentGateway.rawValue: "",
                                                                                      EventProperty.planName.rawValue: "",
                                                                                      EventProperty.page.rawValue: "",
                                                                                      EventProperty.error.rawValue: "",
                                                                                      EventProperty.errorStatus.rawValue: "",
                                                                                      EventProperty.paymentAmount.rawValue: ""])
        case .paymentCompleted:
            return (EventName.paymentCompleted.rawValue, AnalyticsEvents.paymentCompleted, [EventProperty.paymentType.rawValue: "",
                                                                                            EventProperty.paymentGateway.rawValue: "",
                                                                                            EventProperty.planName.rawValue: "",
                                                                                            EventProperty.page.rawValue: "",
                                                                                            EventProperty.paymentAmount.rawValue: ""])
        }
    }
}
