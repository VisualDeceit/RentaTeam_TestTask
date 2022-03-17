//
//  Response.swift
//  RentaTeam_TestTask
//
//  Created by Александр Фомин on 16.03.2022.
//

import Foundation

struct ImageData: Decodable {
    let id: String
    let created: String
    let updated: String
    let width: Int
    let height: Int
    let description: String?
    let likes: Int
    let user: User
    let urls: URLs
    
    enum CodingKeys: String, CodingKey {
        case id,
             created = "created_at",
             updated = "updated_at",
             width,
             height,
             description,
             likes,
             user,
             urls
    }
}
