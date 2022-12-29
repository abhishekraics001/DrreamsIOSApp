//
//  SignUpModel.swift
//  
//
//  Created by Mohd Shams Naqvi on 21/12/22.
//

import Foundation
struct SignUpModel:Decodable {
    var user_details: UserDetail!
    }
struct UserDetail: Decodable {
    var id: Int!
    var i_referral_given_user_id: String!
    var v_user_unique_id: String!
    var e_role_type: String!
    var v_first_name: String!
    var v_email_id: String!
    var v_phone_number: String!
    var v_profile_pic: String!
    var i_country_id: Int!
    var e_device_type: String!
    var v_device_token: String!
    var api_token: String!
    var v_app_version: String!
    var j_cart_courseids: String!
    var e_login_status: String!
    var e_app_login_status: String!
    var v_email_verification_code: String!
    var e_is_email_verify: String!
    var e_register_type: String!
    var e_forum_management_allow: String!
    var e_status: String!
    var e_is_newsletter_recieve_type: String!
    var e_is_notification_recieve_type: String!
    var e_is_notification: String!
    var d_last_login_date: String!
    var d_app_last_login_datetime: String!
    var i_profile_update_count: Int!
    var v_session_id: Int!
    var remember_token: String!
    var v_referral_code: String!
    var f_wallet_total_amount: Int!
    var f_wallet_remaning_total_amount: Int!
    var f_wallet_used_total_amount: Int!
    var f_user_referral_wallet_amount: Int!
    var f_course_referral_wallet_amount: Int!
    var i_user_otp: Int!
    var created_at: String!
    var updated_at: String!
    var v_profile_image_path: String!
    var v_cart_courseids: String!
    var i_total_cart_course: Int!
    var v_user_referral_link: String!
    var specialities: [Specialities]!
}
struct Specialities:Decodable {
    var id: Int!
    var v_name: String!
    var e_status: String!
    var created_at: String!
    var updated_at: String!
    var pivot: Pivot!
}
struct Pivot: Decodable{
    var i_user_id: Int!
    var i_speciality_id: Int!
}
