//
//  VerifyOtpModel.swift
//  Drreams
//
//  Created by Mohd Shams Naqvi on 28/12/22.
//

import Foundation
struct VarifyOtpModel: Decodable {
    var user_details: UserDetails!
}

// MARK: - UserDetails
struct UserDetails: Decodable {
    var id: Int!
    var i_referral_given_user_id: String!
    var v_user_unique_id, e_role_type, v_first_name, v_email_id: String!
    var v_phone_number, v_profile_pic : String!
    var i_country_id: Int!
    var e_device_type, v_device_token, api_token, v_app_version: String!
    var j_cart_courseids: String!
    var e_login_status, e_app_login_status: String!
    var v_email_verification_code: Int!
    var e_is_email_verify, e_register_type, e_forum_management_allow, e_status: String!
    var e_is_newsletter_recieve_type, e_is_notification_recieve_type, e_is_notification: String!
    var d_last_login_date: String!
    var d_app_last_login_datetime: String!
    var i_profile_update_count: Int!
    var v_session_id, remember_token: String!
    var v_referral_code: String!
    var f_wallet_total_amount, f_wallet_remaning_total_amount, f_wallet_used_total_amount, f_user_referral_wallet_amount: Double!
    var f_course_referral_wallet_amount: Double!
    var i_user_otp: Int!
    var created_at, updated_at: String!
    var v_profile_image_path: String!
    var v_cart_courseids: String!
    var i_total_cart_course: Int!
    var v_user_referral_link: String!
    var specialities: [String?]
}
