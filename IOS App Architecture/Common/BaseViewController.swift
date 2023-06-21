//
//  BaseViewController.swift
//  IOS App Architecture
//
//  Created by Mansoor Ali on 16/06/2023.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppStyle.background
        navigationController?.navigationBar.tintColor = AppStyle.primary
    }
    
    func showMinimalBackItem() {
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }
}
