//
//  Routes.swift
//  Drreams
//
//  Created by Mohd Shams Naqvi on 17/12/22.
//

import Foundation

struct Routes {
    static let url = "https://staging.drreams.org/api/v1.0/"
//    static let login = Constants.baseUrl + "patient/login"
    static let signIn = url + "users/signin-send-otp"
    static let signUp = url + "users/signup-send-otp"
    static let varifyOtp = url + "users/signup-verify-otp"
    static let seprateSignUp = url + "users/seprate-signup"
    static let varifyOtpSignIn = url + "users/signin-verify-otp"
    static let slide = url + "home?v_device_token=\(Constants.deviceToken)&e_device_type=\(Constants.deviceType)&v_search_keyword="
    
    static let popularCourse = url + "popular-courses?v_device_token=\(Constants.deviceToken)&e_device_type=\(Constants.deviceType)"
    static let countryCode = url + "countries?v_device_token=\(Constants.deviceToken)&e_device_type=\(Constants.deviceType)"
    static let getStartup = url + "app-startup-screens?v_device_token=\(Constants.deviceToken)&e_device_type=\(Constants.deviceType)"
    static var getDetails = url + "courses/"
    static var getCartCourses = url + "users/\(Constants.userId)/course-cart"
    static var addCartCourses = url + "users/\(Constants.userId)/add-remove-course-cart"
    static var faq = url + "faqs?v_device_token=\(Constants.deviceToken)&e_device_type=\(Constants.deviceType)"
    static var contactUs = url + "/users/contact-us"
    static var mycourses = url 
}
