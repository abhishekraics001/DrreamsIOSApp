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
    
    static let popularCourse = url + "popular-courses?v_device_token=\(Constants.deviceToken)&e_device_type=\(Constants.deviceType)&i_page_no=0&e_is_pagination=Yes&i_limit=5&v_search_keyword=&i_category_id=\(FilterVC().radiology)&i_course_badge_type_id=\(FilterVC().bestSeller+FilterVC().new+FilterVC().trending)&e_course_content_type\(FilterVC().contentType)=&e_is_certificate=\(FilterVC().certificate)&e_course_access=\(FilterVC().courseAccess)&e_type=\(FilterVC().courseType)&e_is_featured_course=\(FilterVC().featuredCourses)&i_course_limited_access_duration_id=\(FilterVC().duration)"
    static let countryCode = url + "countries?v_device_token=\(Constants.deviceToken)&e_device_type=\(Constants.deviceType)"
    static let getStartup = url + "app-startup-screens?v_device_token=\(Constants.deviceToken)&e_device_type=\(Constants.deviceType)"
    static var ser = ""
    let idddd = ""
    static let getDetails = url + "courses/\(ser)"
    
}
class variables {
    var ser = ""
}
