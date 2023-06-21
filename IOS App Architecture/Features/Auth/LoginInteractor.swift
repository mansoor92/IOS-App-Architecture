//
//  LoginViewController.swift
//  IOS App Architecture
//
//  Created by Mansoor Ali on 16/06/2023.
//

import Foundation
import Data

protocol LoginInteractorInput {
    func login(with credential: UserCredential)
}

protocol LoginInteractorOutput: AnyObject {
    func loginCompleted(user: User)
    func loginFailed(error: Error)
}

class LoginInteractor {
    
    private let repository: AuthRepository
    private weak var presenter: LoginInteractorOutput?
    
    init(repository: AuthRepository, presenter: LoginInteractorOutput) {
        self.repository = repository
        self.presenter = presenter
    }
}

extension LoginInteractor: LoginInteractorInput {
    
    func login(with credential: UserCredential) {
        Task {
            do {
                let user = try await repository.login(with: credential)
                await MainActor.run {
                    presenter?.loginCompleted(user: user)
                }
            } catch {
                print(error)
                await MainActor.run {
                    presenter?.loginFailed(error: error)
                }
            }
        }
    }
}
