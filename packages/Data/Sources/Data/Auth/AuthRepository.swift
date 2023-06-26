//
//  AuthService.swift
//  
//
//  Created by Mansoor Ali on 16/06/2023.
//

import Foundation
import ApiClient

// Generic protocol that represents blue print for Service
public protocol AuthRepository {
    func login(with credential: UserCredential) async throws  -> User
}

// factory creates instance of class that conforms to `AuthService` hence information about concrete type is not leaked into other modules
public final class AuthRepositoryFactory {
    static public func make(requestModel: RequestModel) -> AuthRepository {
        // here we can use compostion or return instance of a class
        return AuthRemoteRepository(requestModel: requestModel)
    }
}

// concrete implementation of repository
class AuthRemoteRepository: RemoteRepository, AuthRepository {

    func login(with credential: UserCredential) async throws  -> User {
        // Fake login
        return User(firstName: "Fake", lastName: "User", token: UUID().uuidString)
    }
}
