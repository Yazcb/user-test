//
//  GeoModel.swift
//  userTest
//
//  Created by Yazmin Carmona on 11/09/22.
//

import Foundation

struct GeoModel: Codable {
    let lat: String
    let lng: String
    
    enum CodingKeys: String, CodingKey {
        case lat
        case lng
    }
}
