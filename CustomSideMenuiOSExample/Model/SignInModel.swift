//
//  SignInModel.swift
//  Drreams
//
//  Created by Mohd Shams Naqvi on 17/12/22.
//

import Foundation
struct SignInModel: Decodable {
    var user_details: Details!
    
}
struct Details: Decodable {
    var v_otp_id: Int!
}
