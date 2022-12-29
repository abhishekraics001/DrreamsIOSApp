//
//  DetailsModel.swift
//  Drreams
//
//  Created by Mohd Shams Naqvi on 25/12/22.
//

import Foundation

struct DetailsModel: Decodable {
    var course_detail: CourseDetail!
}

// MARK: - CourseDetail
struct CourseDetail: Decodable {
    var id, i_course_badge_type_id: Int!
    var v_course_code, v_name, v_slug, v_image: String!
    var t_short_description, t_long_description, e_course_content_type, e_type: String!
    var v_instructor_name: String!
    var t_instructor_description: String!
    var d_original_amount, d_discounted_amount: String!
    var v_discount_off_text: String!
    var e_is_certificate, e_is_demo_free_content, e_course_access: String!
    var i_course_access_days: Int!
    var e_is_featured_course, e_status: String!
    var t_meta_title, t_meta_description, t_keywords: String!
    var created_at, updated_at: String!
    var v_course_image_path: String!
    var i_content_count, i_subject_count, i_total_user_enroll: Int!
    var v_course_duration_display_text: String!
    var course_limited_access_price_list: [String?]!
    var course_badge_type: CourseBadgeType!
    var course_subjects: [CourseSubject]!
}

// MARK: - CourseBadgeType
struct CourseBadgeType: Decodable {
    var id: Int!
    var v_name, v_color_code, e_status, created_at: String!
    var updated_at: String!
    var i_total_course: Int!
}

// MARK: - CourseSubject
struct CourseSubject: Decodable {
    var id, i_course_id: Int!
    var v_name: String!
    var t_description: String!
    var e_is_demo_free_content_subject: String!
    var i_order: Int!
    var e_status, created_at, updated_at: String!
    var contents: [Content]!
}

// MARK: - Content
struct Content: Decodable {
    var id, i_course_id, i_course_subject_id: Int!
    var v_name: String!
    var t_description: String!
    var v_file_name, e_file_type, t_time, e_is_demo_free_content: String!
    var i_demo_free_content_minute: String!
    var i_order: Int!
    var e_status, created_at, updated_at: String!
    var v_course_content_path: Bool!
    var course_subject_content_images: [CourseSubjectContentImage]!
}

// MARK: - CourseSubjectContentImage
struct CourseSubjectContentImage: Decodable {
    var id, i_course_id, i_course_subject_id, i_course_subject_content_id: Int!
    var v_image, e_status: String!
    var i_order: Int!
    var created_at, updated_at: String!
    var v_course_content_path: String!
}


struct SendDetailId {
    var courseID : Int!
}
