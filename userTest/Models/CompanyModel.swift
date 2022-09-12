//
//  CompanyModel.swift
//  userTest
//
//  Created by Yazmin Carmona on 11/09/22.
//

import Foundation

struct CompanyModel: Codable {
    let name: String
    let catchPhrase: String
    let bs: String
    
    
    enum CodingKeys: String, CodingKey {
        case name
        case catchPhrase
        case bs
    }
}
