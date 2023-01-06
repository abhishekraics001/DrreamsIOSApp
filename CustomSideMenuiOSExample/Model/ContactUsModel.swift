//
//  ContactUsModel.swift
//  Drreams
//
//  Created by Mohd Shams Naqvi on 05/01/23.
//

import Foundation
struct ContactUsModel:Decodable {
    var contactus_detail: ContactUsDetail!
                
}
struct ContactUsDetail:Decodable {
    var id: Int!
    var v_request_id: String!
    var i_user_id: Int!
    var v_user_name: String!
    var v_email_id: String!
    var v_phone_number: String!
    var v_title: String!
    var t_comment: String!
    var t_reply_message: String!
    var e_is_reply: String!
    var e_is_read: String!
    var deleted_at: String!
    var created_at: String!
    var updated_at: String!
    var user: String!
}
