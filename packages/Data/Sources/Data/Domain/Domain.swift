//
//  File.swift
//  
//
//  Created by Mansoor Ali on 21/06/2023.
//

import Foundation

public struct DomainList: Decodable {
    let count: Int
    let entries: [Domain]
}

public struct Domain: Decodable {
    public let api, description, auth: String
    public let https: Bool
    public let cors: String
    public let link: String
    public let category: String

    enum CodingKeys: String, CodingKey {
        case api = "API"
        case description = "Description"
        case auth = "Auth"
        case https = "HTTPS"
        case cors = "Cors"
        case link = "Link"
        case category = "Category"
    }
}
