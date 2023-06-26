//
//  LoginViewController.swift
//  IOS App Architecture
//
//  Created by Mansoor Ali on 16/06/2023.
//

import Foundation
import Data

protocol LoginViewModelInput {
    func login(with credential: UserCredential)
}

protocol LoginViewModelOutput: AnyObject {
    func loginCompleted(user: User)
    func loginFailed(error: Error)
}

class LoginViewModel {
    
    private let repository: AuthRepository
    private weak var presenter: LoginViewModelOutput?
    
    init(repository: AuthRepository, presenter: LoginViewModelOutput) {
        self.repository = repository
        self.presenter = presenter
    }
}

extension LoginViewModel: LoginViewModelInput {
    
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
