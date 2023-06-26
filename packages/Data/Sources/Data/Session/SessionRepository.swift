//
//  SessoinService.swift
//
//
//  Created by Mansoor Ali on 16/06/2023.
//

import Foundation
import ApiClient

// Generic protocol that represents blue print for Service
public protocol SessionRepository {
    func getSessionToken() -> String?
    func save(user: User)
    func getUser() async throws -> User
    func deleteUser()
}

// factory creates instance of class that conforms to `SessoinService` hence information about concrete type is not leaked into other modules
public final class SessionRepositoryFactory {
    static public func make(requestModel: RequestModel, defaults: UserDefaults) -> SessionRepository {
        // here we use compostion to return store which uses remote and local repositories to manage data
        return SessionStore(remote: SessionRemoteRepository(requestModel: requestModel), local: SessionLocalRepository(defaults: defaults))
    }
}


enum UserError: Error, LocalizedError {
    case userNotFound
    var errorDescription: String? { "Session Expired" }
}

// store is a componsition class which uses both local and remote repository for managing data. It may provide local and remote data depending on network state
class SessionStore: SessionRepository {

    let remote: SessionRemoteRepository
    let local: SessionLocalRepository

    init (remote: SessionRemoteRepository, local: SessionLocalRepository) {
        self.remote = remote
        self.local = local
    }

    func getSessionToken() -> String? {
        return try? local.getUser().token
    }
    
    func save(user: User) {
        local.save(user: user)
    }
    
    func getUser() async throws -> User {
        
        let user = try local.getUser()
        do {
            let newUser = try await remote.getUser()
            newUser.token = user.token
            save(user: newUser)
            return newUser
        } catch {
            return user
        }
    }
    
    func deleteUser() {
        local.deleteUser()
    }
}

// remote implementation of repository which fetch data from server
final class SessionRemoteRepository: RemoteRepository {
    
    func getUser() async throws -> User {
        return try await requestModel.run(endpoint: EndPoint(method: .get, path: "api/users/me", contentType: .json))
    }
}

// local implementaion of repository which manages local data
final class SessionLocalRepository: LocalRepository {

    private let userKey = "user"
    
    func save(user: User) {
        guard let data = try? JSONEncoder().encode(user) else { return }
        defaults.set(data, forKey: userKey)
    }
    
    func getUser() throws -> User {
        guard let data = defaults.data(forKey: userKey) else {
            throw UserError.userNotFound
        }
        return try JSONDecoder().decode(User.self, from: data)
    }
    
    func deleteUser() {
        defaults.removeObject(forKey: userKey)
    }
}

