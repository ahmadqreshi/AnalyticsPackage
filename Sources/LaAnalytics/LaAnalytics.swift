import Combine
import Foundation
import MoEngageSDK
import FirebaseAnalytics
import UXCam

public class LaAnalytics {
    
    public static let shared = LaAnalytics()
    
    private let userDefault = AnalyticsUserDefaults.shared
    
    private let OPTIONAL_NAME = "Learner"
    
    private init() {}
    
    public func setUpMoEngage(appId: String) {
        let sdkConfig = MoEngageSDKConfig(withAppID: appId)
//        #if DEBUG
//            debugPrint("LaAnalytics - MoEngage Test Environment")
//            MoEngage.sharedInstance.initializeDefaultTestInstance(sdkConfig, sdkState: .enabled)
//            sdkConfig.enableLogs = true
//        #else
//            debugPrint("LaAnalytics - MoEngage Live Environment")
//            MoEngage.sharedInstance.initializeDefaultLiveInstance(sdkConfig, sdkState: .enabled)
//        #endif
        sdkConfig.appGroupID = "group.com.learnapp.learnapp.moengage"
        MoEngage.sharedInstance.initializeDefaultLiveInstance(sdkConfig, sdkState: .enabled)
    }
    
    public func setUpUxCam(appKey: String) {
        let configuration = UXCamConfiguration(appKey: appKey)
        configuration.enableAdvancedGestureRecognition = true
        configuration.enableAutomaticScreenNameTagging  = true
        configuration.enableCrashHandling = true
        configuration.enableAdvancedGestureRecognition = true
//        configuration.enableNetworkLogging = true
        UXCam.optIntoSchematicRecordings()
        UXCam.start(with: configuration)
    }
    
    public func postEvent(eventMessage: EventMessage) {
        DispatchQueue.global(qos: .background).async {
            
            let moengageEvents = MoEngageEvents.allCases.filter({$0.eventTemplate.analyticsEvent == eventMessage.analyticsEvent})
            for event in moengageEvents {
                self.postMoEngageEvents(eventMessage: MoEngageEventMessage(event: event, eventProperties: eventMessage.eventProperties))
                self.postUxCamEvent(eventMessage: MoEngageEventMessage(event: event, eventProperties: eventMessage.eventProperties))
            }
            
            let googleEvents = GoogleEvents.allCases.filter({$0.eventTemplate.analyticsEvent == eventMessage.analyticsEvent})
            for event in googleEvents {
                self.postGoogleEvents(eventMessage: GoogleEventMessage(event: event, eventProperties: eventMessage.eventProperties))
            }
        }
    }
    
    private func filterEventProperties(sentProperties: [String: Any]?, templateProperties: [String: Any]?) -> [String: Any]? {
        if let tempSentProperties = sentProperties, let tempTemplateProperties = templateProperties {
            var properties = [String: Any]()
            for (key, _) in tempTemplateProperties {
                if tempSentProperties.contains(where: { $0.key == key }) {
                    properties[key] = tempSentProperties[key]
                }
            }
            return properties
        }
        return nil
    }
    
    private func filterLowerCaseEventProperties(sentProperties: [String: Any]?, templateProperties: [String: Any]?) -> [String: Any]? {
        if let tempSentProperties = sentProperties, let tempTemplateProperties = templateProperties {
            var properties = [String: Any]()
            for (key, _) in tempTemplateProperties {
                if tempSentProperties.contains(where: { $0.key == key }) {
                    properties[key.lowercased().replacingOccurrences(of: " ", with: "_")] = tempSentProperties[key]
                }
            }
            return properties
        }
        return nil
    }
    
    private func getFullName(userProfile: ProfileModel) -> String {
        var fullName = ""
        if let firstName = userProfile.firstName {
            fullName = firstName
        }
        
        if let lastName = userProfile.lastName {
            if fullName.isEmpty {
                fullName = lastName
            } else {
                fullName = fullName + " " + lastName
            }
        }
        
        if (fullName.isEmpty) {
            fullName = OPTIONAL_NAME
        }
        
        return fullName
    }
    
    //MARK: - Google Events and Properties
    private func postGoogleEvents(eventMessage: GoogleEventMessage) {
        debugPrint("LaAnalytics - postGoogleEvents \(eventMessage.event.eventTemplate.eventName)")
        if eventMessage.event == GoogleEvents.pageLoaded {
            Analytics.logEvent(AnalyticsEventScreenView, parameters: [AnalyticsParameterScreenName: eventMessage.eventProperties?[EventProperty.page.rawValue] as? String ?? ""])
        } else {
            let eventProperties = filterLowerCaseEventProperties(
                sentProperties: eventMessage.eventProperties,
                templateProperties: eventMessage.event.eventTemplate.eventProperties
            )
            Analytics.logEvent(eventMessage.event.eventTemplate.eventName, parameters: eventProperties)
        }
        setGooglePeople(eventMessage: eventMessage)
    }
    /// set Google user properties
    private func setGooglePeople(eventMessage: GoogleEventMessage) {
        debugPrint("LaAnalytics - setGooglePeople \(eventMessage.event.eventTemplate.eventName)")
        let profile = userDefault.getUserProfile()
        
        if (eventMessage.event == .loggedIn || eventMessage.event == .signedUp) && profile != nil {
            Analytics.setUserID(profile!.userID)
        }
        
        Analytics.setUserProperty(profile?.firstName, forName: GoogleUserProperty.firstName.rawValue)
        Analytics.setUserProperty(profile?.lastName, forName: GoogleUserProperty.lastName.rawValue)
        Analytics.setUserProperty(profile?.phone, forName: GoogleUserProperty.phoneNumber.rawValue)
        
        if let userProfile = profile {
            Analytics.setUserProperty(getFullName(userProfile: userProfile), forName: GoogleUserProperty.fullName.rawValue)
            Analytics.setUserProperty(userProfile.email, forName: GoogleUserProperty.email.rawValue)
            Analytics.setUserProperty(UserState.loggedIn.rawValue, forName: GoogleUserProperty.state.rawValue)
            
            setGoogleUtmParams(utmParams: userProfile.preferences?.ios?.utm)
        } else {
            Analytics.setUserProperty(UserState.loggedOut.rawValue, forName: GoogleUserProperty.state.rawValue)
            
            setGoogleUtmParams(utmParams: userDefault.value(forKey: .utm) as? UtmParam)
        }
        
        Analytics.setUserProperty(userDefault.value(forKey: .subscriptionExpiry) as? String, forName: GoogleUserProperty.subscriptionExpiry.rawValue)
        Analytics.setUserProperty(String(userDefault.value(forKey: .isBasePlanSubscribed) as? Bool ?? false), forName: GoogleUserProperty.subscriptionPaid.rawValue)
        Analytics.setUserProperty(String(userDefault.value(forKey: .isAdvancedCourseSubscribed) as? Bool ?? false), forName: GoogleUserProperty.advancedPaid.rawValue)
        Analytics.setUserProperty(String(userDefault.value(forKey: .isSingleCourseSubscribed) as? Bool ?? false), forName: GoogleUserProperty.coursesPaid.rawValue)
        Analytics.setUserProperty(String(userDefault.value(forKey: .subscriptionCount) as? Int ?? 0), forName: GoogleUserProperty.subscriptionCount.rawValue)
        Analytics.setUserProperty(String(userDefault.value(forKey: .subscriptionStartDate) as? String ?? ""), forName: GoogleUserProperty.subscriptionStartDate.rawValue)
        Analytics.setUserProperty(profile?.createdAt, forName: GoogleUserProperty.signUpDate.rawValue)
        Analytics.setUserProperty(String(profile?.notificationSettings.emailSetting.offers ?? false), forName: GoogleUserProperty.emailSettingOffer.rawValue)
        Analytics.setUserProperty(profile?.preferences?.onBoarding?.type, forName: GoogleUserProperty.onBoardingType.rawValue)
        Analytics.setUserProperty(profile?.preferences?.onBoarding?.experience, forName: GoogleUserProperty.onBoardingExperience.rawValue)
        
        // Add User Activated
        
    }
    /// UTM parameters from user profile
    private func setGoogleUtmParams(utmParams: UtmParam?) {
        debugPrint("LaAnalytics - setGoogleUtmParams")
        Analytics.setUserProperty(utmParams?.utmSource, forName: GoogleUserProperty.utmSource.rawValue)
        Analytics.setUserProperty(utmParams?.utmMedium, forName: GoogleUserProperty.utmMedium.rawValue)
        Analytics.setUserProperty(utmParams?.utmCampaign, forName: GoogleUserProperty.utmCampaign.rawValue)
        Analytics.setUserProperty(utmParams?.utmContent, forName: GoogleUserProperty.utmContent.rawValue)
        Analytics.setUserProperty(utmParams?.utmTerm, forName: GoogleUserProperty.utmTerm.rawValue)
    }
    
    //MARK: - MoEngage Events and Properties
    private func postMoEngageEvents(eventMessage: MoEngageEventMessage) {
        debugPrint("LaAnalytics - postMoEngageEvents \(eventMessage.event.eventTemplate.eventName)")
        let eventProperties = filterEventProperties(sentProperties: eventMessage.eventProperties, templateProperties: eventMessage.event.eventTemplate.eventProperties)
        
        MoEngageSDKAnalytics.sharedInstance.trackEvent(
            eventMessage.event.eventTemplate.eventName,
            withProperties: eventProperties == nil || eventProperties?.isEmpty ?? false ? nil : MoEngageProperties(withAttributes: eventProperties)
        )
        setMoEngagePeople(eventMessage: eventMessage)
        MoEngageSDKAnalytics.sharedInstance.flush()
    }
    
    /// Set Moenengage user properties
    private func setMoEngagePeople(eventMessage: MoEngageEventMessage) {
        debugPrint("LaAnalytics - setMoEngagePeople \(eventMessage.event.eventTemplate.eventName)")
        let profile = userDefault.getUserProfile()
        //if (eventMessage.event == .loggedIn || eventMessage.event == .signedUp) && profile != nil {
        if let userProfile = profile {
            MoEngageSDKAnalytics.sharedInstance.setUniqueID(userProfile.userID)
        } else if eventMessage.event == .signOut {
            MoEngageSDKAnalytics.sharedInstance.resetUser()
        }
        
        // Default User Attributes
        MoEngageSDKAnalytics.sharedInstance.setFirstName(profile?.firstName ?? OPTIONAL_NAME)
        MoEngageSDKAnalytics.sharedInstance.setLastName(profile?.lastName ?? "")
        MoEngageSDKAnalytics.sharedInstance.setMobileNumber(profile?.phone ?? "")
        
        if let userProfile = profile {
            MoEngageSDKAnalytics.sharedInstance.setName(getFullName(userProfile: userProfile))
            MoEngageSDKAnalytics.sharedInstance.setEmailID(userProfile.email)
            
            MoEngageSDKAnalytics.sharedInstance.setUserAttribute(
                UserState.loggedIn.rawValue,
                withAttributeName: UserProperty.state.rawValue
            )
            setUtmParams(utmParams: userProfile.preferences?.ios?.utm)
        } else {
            MoEngageSDKAnalytics.sharedInstance.setUserAttribute(
                UserState.loggedOut.rawValue,
                withAttributeName: UserProperty.state.rawValue
            )
            setUtmParams(utmParams: userDefault.value(forKey: .utm) as? UtmParam)
        }
        
        MoEngageSDKAnalytics.sharedInstance.setUserAttribute(
            userDefault.value(forKey: .subscriptionExpiry) as? String ?? "None",
            withAttributeName: UserProperty.subscriptionExpiry.rawValue
        )
        
        MoEngageSDKAnalytics.sharedInstance.setUserAttribute(
            userDefault.value(forKey: .subscriptionCount) as? Int ?? 0,
            withAttributeName: UserProperty.subscriptionCount.rawValue
        )
        
        MoEngageSDKAnalytics.sharedInstance.setUserAttribute(
            userDefault.value(forKey: .subscriptionStartDate) as? String ?? "None",
            withAttributeName: UserProperty.subscriptionCount.rawValue
        )
        
        MoEngageSDKAnalytics.sharedInstance.setUserAttribute(
            "\(userDefault.value(forKey: .isBasePlanSubscribed) as? Bool ?? false)",
            withAttributeName: UserProperty.isSubscriptionPaid.rawValue
        )
        
        MoEngageSDKAnalytics.sharedInstance.setUserAttribute(
            "\((userDefault.value(forKey: .isBasePlanSubscribed) as? Bool ?? false) ? "All" : "None")",
            withAttributeName: UserProperty.subscriptionPaid.rawValue
        )
        
        MoEngageSDKAnalytics.sharedInstance.setUserAttribute(
            "\(userDefault.value(forKey: .isAdvancedCourseSubscribed) as? Bool ?? false)",
            withAttributeName: UserProperty.isAdvancePaid.rawValue
        )
        
        MoEngageSDKAnalytics.sharedInstance.setUserAttribute(
            "\(userDefault.value(forKey: .subscriptionCount) as? Int ?? 0)",
            withAttributeName: UserProperty.subscriptionCount.rawValue
        )
        
        MoEngageSDKAnalytics.sharedInstance.setUserAttribute(
            userDefault.value(forKey: .subscriptionStartDate) as? String ?? "",
            withAttributeName: UserProperty.subscriptionStartDate.rawValue
        )
        
        MoEngageSDKAnalytics.sharedInstance.setUserAttribute(
            profile?.createdAt ?? "",
            withAttributeName: UserProperty.signUpDate.rawValue
        )
        
        MoEngageSDKAnalytics.sharedInstance.setUserAttribute(
            "\(profile?.notificationSettings.emailSetting.offers ?? true)",
            withAttributeName: UserProperty.emailSettingOffer.rawValue
        )
        
        MoEngageSDKAnalytics.sharedInstance.setUserAttribute(
            "\(profile?.notificationSettings.emailSetting.newsLetters ?? true)",
            withAttributeName: UserProperty.emailSettingsNewsLetter.rawValue
        )
        
        
//        MoEngageSDKAnalytics.sharedInstance.setUserAttribute(
//            "\(userDefault.value(forKey: .isSingleCourseSubscribed) as? Bool ?? false)",
//            withAttributeName: UserProperty.coursesPaid.rawValue
//        )
//
//        MoEngageSDKAnalytics.sharedInstance.setUserAttribute(
//            profile?.userID ?? "",
//            withAttributeName: UserProperty.moengageUserId.rawValue
//        )
//
//        MoEngageSDKAnalytics.sharedInstance.setUserAttribute(
//            profile?.preferences?.onBoarding?.type ?? "",
//            withAttributeName: UserProperty.onBoardingType.rawValue
//        )
//
//        MoEngageSDKAnalytics.sharedInstance.setUserAttribute(
//            profile?.preferences?.onBoarding?.experience ?? "",
//            withAttributeName: UserProperty.onBoardingExperience.rawValue
//        )
        
    }
    
    /// UTM parameters from user profile
    private func setUtmParams(utmParams: UtmParam?) {
        debugPrint("LaAnalytics - setMoengage UtmParams")
        if let utmSource = utmParams?.utmSource,
           let utmMedium = utmParams?.utmMedium,
           let utmCampaign = utmParams?.utmCampaign,
           let utmContent = utmParams?.utmContent,
           let utmTerm = utmParams?.utmTerm {
            
            MoEngageSDKAnalytics.sharedInstance.setUserAttribute(
                utmSource,
                withAttributeName: UserProperty.utmSource.rawValue
            )
            
            MoEngageSDKAnalytics.sharedInstance.setUserAttribute(
                utmMedium,
                withAttributeName: UserProperty.utmMedium.rawValue
            )
            
            MoEngageSDKAnalytics.sharedInstance.setUserAttribute(
                utmCampaign,
                withAttributeName: UserProperty.utmCampaign.rawValue
            )
            MoEngageSDKAnalytics.sharedInstance.setUserAttribute(
                utmContent,
                withAttributeName: UserProperty.utmContent.rawValue
            )
            MoEngageSDKAnalytics.sharedInstance.setUserAttribute(
                utmTerm,
                withAttributeName: UserProperty.utmTerm.rawValue
            )
        }
        
    }
    
    //MARK: - UXCAM events and Properties
    private func postUxCamEvent(eventMessage: MoEngageEventMessage) {
        debugPrint("postUxCamEvent() \(eventMessage.event.eventTemplate.eventName)")
        if eventMessage.event == MoEngageEvents.pageLoaded {
            if let screenName = eventMessage.eventProperties?[EventProperty.page.rawValue] as? String {
                DispatchQueue.main.async {
                    UXCam.tagScreenName(screenName)
                }
            }
        }
        
        let eventProperties = filterEventProperties(sentProperties: eventMessage.eventProperties, templateProperties: eventMessage.event.eventTemplate.eventProperties)
        
        UXCam.logEvent(eventMessage.event.eventTemplate.eventName, withProperties: eventProperties)
        setUxCamUserProperties(eventMessage: eventMessage)
        
    }
    
    /// set uxCam user properties
    private func setUxCamUserProperties(eventMessage: MoEngageEventMessage) {
        debugPrint("setUxCamUserProperties() \(eventMessage.event.eventTemplate.eventName)")
        
        let profile = userDefault.getUserProfile()
        if (eventMessage.event == .loggedIn || eventMessage.event == .signedUp) && profile != nil {
            UXCam.setUserIdentity(profile!.userID)
        }
        
        // Default User Attributes
        UXCam.setUserProperty(UserProperty.firstName.rawValue, value: profile?.firstName ?? OPTIONAL_NAME)
        UXCam.setUserProperty(UserProperty.lastName.rawValue, value: profile?.lastName ?? "")
        UXCam.setUserProperty(UserProperty.phoneNumber.rawValue, value: profile?.phone ?? "")
        
        if let userProfile = profile {
            UXCam.setUserProperty(UserProperty.fullName.rawValue, value: getFullName(userProfile: userProfile))
            UXCam.setUserProperty(UserProperty.email.rawValue, value: userProfile.email)
            UXCam.setUserProperty(UserProperty.state.rawValue, value: UserState.loggedIn.rawValue)
            
            setUxCamUtmParams(utmParams: userProfile.preferences?.ios?.utm)
        } else {
            UXCam.setUserProperty(UserProperty.state.rawValue, value: UserState.loggedOut.rawValue)
            setUxCamUtmParams(utmParams: userDefault.value(forKey: .utm) as? UtmParam)
        }
        
        UXCam.setUserProperty(
            UserProperty.subscriptionExpiry.rawValue,
            value: userDefault.value(forKey: .subscriptionExpiry) as? String ?? ""
        )
        UXCam.setUserProperty(
            UserProperty.subscriptionPaid.rawValue,
            value: "\(userDefault.value(forKey: .isBasePlanSubscribed) as? Bool ?? false)"
        )
        UXCam.setUserProperty(
            UserProperty.advancedPaid.rawValue,
            value: "\(userDefault.value(forKey: .isAdvancedCourseSubscribed) as? Bool ?? false)"
        )
        UXCam.setUserProperty(
            UserProperty.coursesPaid.rawValue,
            value: "\(userDefault.value(forKey: .isSingleCourseSubscribed) as? Bool ?? false)"
        )
        UXCam.setUserProperty(
            UserProperty.subscriptionCount.rawValue,
            value: "\(userDefault.value(forKey: .subscriptionCount) as? Int ?? 0)"
        )
        UXCam.setUserProperty(
            UserProperty.subscriptionStartDate.rawValue,
            value: userDefault.value(forKey: .subscriptionStartDate) as? String ?? ""
        )
        UXCam.setUserProperty(
            UserProperty.signUpDate.rawValue,
            value: profile?.createdAt ?? ""
        )
        UXCam.setUserProperty(
            UserProperty.emailSettingOffer.rawValue,
            value: "\(profile?.notificationSettings.emailSetting.offers ?? false)"
        )
        UXCam.setUserProperty(
            UserProperty.onBoardingType.rawValue,
            value: profile?.preferences?.onBoarding?.type ?? ""
        )
        UXCam.setUserProperty(
            UserProperty.onBoardingExperience.rawValue,
            value: profile?.preferences?.onBoarding?.experience ?? ""
        )
        
        // Add User Activated
        // add subscription count
    }
    
    // UTM parameters from user profile
    private func setUxCamUtmParams(utmParams: UtmParam?) {
        debugPrint("setUxCamUtmParams()")
        UXCam.setUserProperty(UserProperty.utmSource.rawValue, value: utmParams?.utmSource ?? "")
        UXCam.setUserProperty(UserProperty.utmMedium.rawValue, value: utmParams?.utmMedium ?? "")
        UXCam.setUserProperty(UserProperty.utmCampaign.rawValue, value: utmParams?.utmCampaign ?? "")
        UXCam.setUserProperty(UserProperty.utmContent.rawValue, value: utmParams?.utmContent ?? "")
        UXCam.setUserProperty(UserProperty.utmTerm.rawValue, value: utmParams?.utmTerm ?? "")
    }
    
}
