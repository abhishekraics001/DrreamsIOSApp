//
//  CountryListModel.swift
//  Drreams
//
//  Created by Mohd Shams Naqvi on 18/12/22.
//

import Foundation

struct CountryListModel: Decodable {
    var countries: [Countries]!
}

struct Countries: Decodable {
    var id: Int!
    var v_name: String!
    var v_iso_3166_2: String!
    var i_phone_code: Int!
    var e_status: String!
    var created_at: String!
    var updated_at: String!
}
