//
//  WebPageDelegate.swift
//  IOS App Architecture
//
//  Created by Mansoor Ali on 21/06/2023.
//

import UIKit

protocol WebPageDelegate: AnyObject {
    func show(_ sender: UIViewController, url: URL)
}
