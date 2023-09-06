import Foundation

enum EventName: String, CaseIterable {
    case pageLoaded = "Page Loaded"                     // When user loads any page of LearnApp and key event
    
    case loggedIn = "Logged In"                         // When user successfully login and key event
    case loginError = "Login Error"                     // When login fails
    case login = "Login"                                // When user clicks on login button from login page
    case loginPage = "Login Page"                       // When user clicks on login button from side navigation bar
    
    case signedUp = "Signed Up"                         // When user successfully signup and key event
    case signOut = "Sign Out"                           // When user clicks on sign out button from nav bar drop down
    case signUpPage = "Sign Up Page"                    // When user clicks on signup link from login page
    case signUpError = "Sign Up Error"                  // When user sign up fails
    case signUp = "Sign Up"                             // When user clicks on sign up button
    
    case googleSignIn = "Google Sign In"                // When user clicks on google sign in
    case appleSignIn = "Apple Sign In"                  //When User clicks on apple sign in
    case emailVerified = "Email Verified"               // When user verifies his email from the link he/she received
    case recoverEmailSent = "Recovery Email Sent"       // When user clicks on continue button from the forgot password page and it is successful
    case passwordReset = "Password Reset"               // When users resets his password via email link
    
    case helpClick = "Help Click"                       // click on help icon
    
    case appOpened = "App Opened"                       // When the app is opened
    case appClosed = "App Closed"                       // When the app is closed
    
    case faqToggle = "Faq Toggle"                       // When faq toggled
    case courseShareClicked = "Course Share Clicked"    // When user clicks on share button in any course
    case lessonTopicClick = "Lesson Topic Clicked"      // When user clicks any lesson click from lesson list
    case playTrailerClicked = "Play Trailer Clicked"    // When user plays the trailer
    case hamburgerMenuClicked = "Hamburger Menu Clicked"    // When user clicks on the hamburger menu
    case courseCardClicked = "Course Card Clicked"          //  When user clicks on course card
    case categoryPillClicked = "Category Pill Clicked"  // When user clicks on tag filter
    
    case resourceButtonClicked = "Resource"             // When user clicks on resource button on course video player screen
    case courseVideoPlayed = "Course Video Played"      // When user lands on course video player and key event
    case courseVideoStarted = "Course Video Started"    // When video has started
    case courseVideoEnded = "Course Video Ended"        // When video has ended
    case profileEditButtonClicked = "Profile Edit Button Clicked"  // When user clicked on edit profile button
    
    case paymentStarted = "Payment Started" //When user initiate payment from payment page
    case paymentFailed = "Payment Failed"   // When Payment Fails
    case paymentCompleted = "Payment Completed" // When payment is Succesful
}
