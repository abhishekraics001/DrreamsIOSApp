//
//  ResponseModel.swift
//  Drreams
//
//  Created by Mohd Shams Naqvi on 17/12/22.
//

import Foundation

class ResponseModel<T: Decodable>: Decodable {
    
    var code: Int?
    var msg : String?
    var flag : Bool?
    var data : T?
    var common_data : [T]?
}
