import UIKit
import Data
import SafariServices

class Router: NSObject {
    
    private let window: UIWindow
    private let navigationController = UINavigationController()
    private let tabBarController = UITabBarController()
    private let dependency: DependencyContainer
    
    init(window: UIWindow, dependency: DependencyContainer) {
        self.window = window
        self.dependency = dependency
        super.init()
        navigationController.isNavigationBarHidden = true
    }

    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        if let sessionToken = dependency.getSessionRepository().getSessionToken() {
            dependency.set(sessionToken: sessionToken)
             showHome()
        }else {
            showLogin()
        }
    }

    private func showLogin() {
        let view = LoginViewComposer.compose(repository: dependency.getAuthRepository())
        view.delegate = self
        navigationController.setViewControllers([view], animated: true)
    }
    
    func showHome() {
        
        let domain = DomainViewComposer.compose(repository: dependency.getDomainRepository())
        domain.delegate = self
        domain.tabBarItem = UITabBarItem(title: "Domains", image: UIImage(named: "list"), selectedImage: nil)

        let profile = ProfileViewComposer.compose()
        profile.delegate = self
        profile.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile"), selectedImage: nil)

        let viewControllers = [domain, profile].map{ UINavigationController(rootViewController: $0) }.map{
            $0.isNavigationBarHidden = false
            return $0
        }
        tabBarController.viewControllers = viewControllers
        tabBarController.tabBar.tintColor = AppStyle.primary
        tabBarController.tabBar.barTintColor = .blue
        tabBarController.tabBar.backgroundColor = .white
        tabBarController.tabBar.unselectedItemTintColor = .lightGray
        tabBarController.tabBar.isTranslucent = false
        tabBarController.selectedIndex = 0
        
        navigationController.setViewControllers([tabBarController], animated: true)
    }
    
//    private func getVisibleTab() -> UINavigationController? {
//        return tabBarController.viewControllers?[tabBarController.selectedIndex] as? UINavigationController
//    }
    
//    private func pushOnVisibleTab(view: UIViewController) {
//        getVisibleTab()?.pushViewController(view, animated: true)
//    }
}

extension Router: LoginViewControllerDelegate {
    
    func loginCompleted(user: User) {
        dependency.getSessionRepository().save(user: user)
        dependency.set(sessionToken: user.token!)
        showHome()
    }
}

extension Router: WebPageDelegate {
    func show(_ sender: UIViewController, url: URL) {
        let vc = SFSafariViewController(url: url)
        vc.delegate = self
        sender.present(vc, animated: true)
    }
}

extension Router: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true)
    }
}

extension Router: ProfileViewControllerDelegate {
    func logout() {
        dependency.clearSession()
        showLogin()
    }
}


