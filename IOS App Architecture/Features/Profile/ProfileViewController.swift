//
//  ProfileViewController.swift
//  IOS App Architecture
//
//  Created by Mansoor Ali on 21/06/2023.
//

import UIKit
import Reusable

class ProfileViewComposer {
    
    static func compose() -> ProfileViewController {
        let view = ProfileViewController.instantiate()
        return view
    }
}

protocol ProfileViewControllerDelegate: AnyObject {
    func logout()
}

class ProfileViewController: BaseViewController, StoryboardSceneBased {
    
    static var sceneStoryboard = UIStoryboard.profile()
    
    // MARK: - Properties
    weak var delegate: ProfileViewControllerDelegate?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    // MARK: - UI
    private func configureView() {
        navigationItem.title = "Profile"
    }
    
    // MARK: - Actions
    @IBAction func logout() {
        delegate?.logout()
    }
}
