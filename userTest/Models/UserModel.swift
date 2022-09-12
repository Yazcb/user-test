//
//  UserModel.swift
//  userTest
//
//  Created by Yazmin Carmona on 11/09/22.
//

import Foundation

struct UserModel: Codable {
    let id: Int64
    let name: String
    let username: String
    let email: String
    let address: AddressModel
    let phone: String
    let website: String
    let company: CompanyModel

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case username
        case email
        case address
        case phone
        case website
        case company
    }
}
