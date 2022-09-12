//
//  AddressModel.swift
//  userTest
//
//  Created by Yazmin Carmona on 11/09/22.
//

import Foundation

struct AddressModel: Codable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: GeoModel
    
    enum CodingKeys: String, CodingKey {
        case street
        case suite
        case city
        case zipcode
        case geo
    }
}
