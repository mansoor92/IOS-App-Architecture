//
//  LoginViewController.swift
//  IOS App Architecture
//
//  Created by Mansoor Ali on 16/06/2023.
//

import UIKit
import Data
import Reusable

class LoginViewComposer {
    
    static func compose(repository: AuthRepository) -> LoginViewController {
        let view = LoginViewController.instantiate()
        let interactor = LoginViewModel(repository: repository, presenter: view)
        view.interactor = interactor
        return view
    }
}

protocol LoginViewControllerDelegate: AnyObject {
    func loginCompleted(user: User)
}

class LoginViewController: BaseViewController, StoryboardSceneBased {
    
    static var sceneStoryboard = UIStoryboard.auth()
    
    // MARK: Outlets
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    // MARK: - Properties
    var interactor: LoginViewModelInput!
    weak var delegate: LoginViewControllerDelegate?
    override var preferredStatusBarStyle: UIStatusBarStyle { .darkContent }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    // MARK: - UI
    private func configureView() {
        card.layer.addShadow(opacity: 0.2)
        email.keyboardType = .emailAddress
        email.returnKeyType = .next
        configure(field: email, placeholder: "Email")
        
        password.returnKeyType = .done
        configure(field: password, placeholder: "Password")
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTap)))
    }
    
    private func configure(field: UITextField, placeholder: String) {
        field.textColor = AppStyle.textColor
        field.font = AppStyle.normal.font(20)
        field.attributedPlaceholder = AppStyle.getAttributedString(placeholder, font: AppStyle.normal.font(20), color: .gray)
        field.delegate = self
    }
    
    private func showSpinner() {
        login.isEnabled = false
        spinner.startAnimating()
    }
    
    private func hideSpinner() {
        login.isEnabled = true
        spinner.stopAnimating()
    }
    
    // MARK: - Actions
    @IBAction private func onLogin() {
        showSpinner()
        let credentials = try! UserCredential(email: email.text!, password: password.text!)
        interactor.login(with: credentials!)
    }
    
    @objc private func onTap() {
        view.endEditing(true)
    }
    
    @IBAction func editingChanged(_ sender: UITextField) {
        do {
            _ = try UserCredential(email: email.text!, password: password.text!)
            login.isEnabled = true
        } catch {
            login.isEnabled = false
        }
    }
}

// MARK: - LoginViewModelOutput
extension LoginViewController: LoginViewModelOutput {
   
    func loginCompleted(user: User) {
        hideSpinner()
        delegate?.loginCompleted(user: user)
    }
    
    func loginFailed(error: Error) {
        hideSpinner()
        view.show(message: error.localizedDescription)
    }
}

// MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == email {
            password.becomeFirstResponder()
        } else  {
            textField.resignFirstResponder()
        }
        return true
    }
}
