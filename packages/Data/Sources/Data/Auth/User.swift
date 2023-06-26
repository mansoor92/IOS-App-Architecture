//
//  User.swift
//  
//
//  Created by Mansoor Ali on 16/06/2023.
//

import Foundation

public class User: Codable {
    public let firstName: String
    public let lastName: String
    public var token: String?
    
    init(firstName: String, lastName: String, token: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.token = token
    }
}
