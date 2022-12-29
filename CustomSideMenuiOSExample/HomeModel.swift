//
//  HomeModel.swift
//  Drreams
//
//  Created by Mohd Shams Naqvi on 17/12/22.
//

import Foundation

struct HomeModel: Decodable {
    var total_category_count: Int!
    var category: [Catagory]!
    var sliders: [Slider]!
}

struct Catagory: Decodable {
  var id: Int!
    var v_name: String!
    var v_category_image_path: String!
    var i_total_course: Int!
    var i_total_user_enroll: Int!
        
}
struct Slider: Decodable {
    var id: Int!
    var v_title: String!
    var t_description: String!
    var i_order: String!
    var v_image: String!
    var v_bg_image: String!
    var v_mobile_image: String!
    var e_status: String!
    var created_at: String!
    var updated_at: String!
    var v_slider_image_path: String!
    var v_slider_mobile_image_path: String!
    var v_app_startup_screens_image_path: String!
    var v_app_startup_screens_bg_image_path: String!
}
struct StartUpModel: Decodable {
    var app_startup_screen: [Slider]!
}
struct PopularModel: Decodable {
    var total_course_count: Int!
    var page_no: String!
    var limit: String!
    var courses: [Courses]!
}
struct Courses: Decodable{
    var id: Int!
    var i_course_badge_type_id: Int!
    var v_course_code: String!
    var v_name: String!
    var v_slug: String!
    var v_image: String!
    var t_short_description: String!
    var t_long_description: String!
    var e_course_content_type: String!
    var e_type: String!
    var v_instructor_name: String!
    var t_instructor_description: String!
    var d_original_amount: String!
    var d_discounted_amount: String!
    var v_discount_off_text: String!
    var e_is_certificate: String!
    var e_is_demo_free_content: String!
    var e_course_access: String!
    var i_course_access_days: Int!
    var e_is_featured_course: String!
    var e_status: String!
    var t_meta_title: String!
    var t_meta_description: String!
    var t_keywords: String!
    var created_at: String!
    var updated_at: String!
    var v_course_image_path: String!
    var i_content_count: Int!
    var i_subject_count: Int!
    var i_total_user_enroll: Int!
    var v_course_duration_display_text: String!
    var course_badge_type: CourceType!
    var course_limited_access_price_list: [ Array<String?>]!
                
}
struct CourceType: Decodable{
    var id: Int!
    var v_name: String!
    var v_color_code: String!
    var e_status: String!
    var created_at: String!
    var updated_at: String!
    var i_total_course: Int!
}
