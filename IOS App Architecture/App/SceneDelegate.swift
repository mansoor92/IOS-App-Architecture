//
//  SceneDelegate.swift
//  IOS App Architecture
//
//  Created by Mansoor Ali on 16/06/2023.
//

import UIKit
import Data

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    private var router: Router!
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        self.window = window
        let requestModel = RequestModel(baseURL: URL(string: "https://api.publicapis.org")!)
        router = Router(window: window, dependency: DependencyContainer(requestModel: requestModel))
        router.start()
    }
}

