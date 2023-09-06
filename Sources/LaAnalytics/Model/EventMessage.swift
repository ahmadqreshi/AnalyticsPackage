import Foundation

public struct EventMessage {
    let analyticsEvent: AnalyticsEvents
    var eventProperties: [String: Any]? = nil
    
    public init(analyticsEvent: AnalyticsEvents, eventProperties: [String: Any]?) {
        self.analyticsEvent = analyticsEvent
        self.eventProperties = eventProperties
    }
}
