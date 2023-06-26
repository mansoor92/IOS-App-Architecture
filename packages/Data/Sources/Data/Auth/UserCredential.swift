//
//  UserCredential.swift
//
//
//  Created by Mansoor Ali on 16/06/2023.
//

import Foundation

public enum UserCredentialError: Error {
    case invalidEmail
    case invalidPassword
}

public struct UserCredential: Encodable {
    
    let email: String
    let password: String
    
    public init?(email: String, password: String) throws {
        
        let isValidEmail = !email.isEmpty && EmailValidator().isValid(email: email)
        
        if !isValidEmail {
            throw(UserCredentialError.invalidEmail)
        }else if password.isEmpty {
            throw(UserCredentialError.invalidPassword)
        }
        
        self.email = email
        self.password = password
    }
}


public class EmailValidator {
    func isValid(email: String) -> Bool {
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: email, options: [], range: NSRange(location: 0, length: email.count)) != nil
    }
}
