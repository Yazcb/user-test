//
//  PostModel.swift
//  userTest
//
//  Created by Yazmin Carmona on 11/09/22.
//

import Foundation

struct PostModel: Codable {
    let userId: Int64
    let id: Int64
    let title: String
    let body: String
    
    enum CodingKeys: String, CodingKey {
        case userId
        case id
        case title
        case body
    }
}
