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
            // showHome()
        }else {
            showLogin()
        }
    }

    private func showLogin() {
        let view = LoginViewComposer.compose(repository: dependency.getAuthRepository())
        view.delegate = self
        navigationController.setViewControllers([view], animated: true)
    }
    /*
    func showHome() {
        
        let agendaViewController = AgendaViewController()
        agendaViewController.delegate = self
        agendaViewController.interactor = AgendaInteractor(repo: dependency.appointmentRepo(), presenter: agendaViewController)
        agendaViewController.tabBarItem = UITabBarItem(title: "Agenda", image: UIImage(named: "calendar"), selectedImage: nil)

        let appointmentViewController = AppointmentViewComposer.compose(repo: dependency.appointmentRepo(), delegate: self)
        appointmentViewController.tabBarItem = UITabBarItem(title: "Appuntamenti", image: UIImage(named: "appointment"), selectedImage: nil)

        let profileViewController = ProfileViewComposer.compose(repo: dependency.sessionRepo())
        profileViewController.delegate = self
        profileViewController.tabBarItem = UITabBarItem(title: "Il Mio Salone", image: UIImage(named: "profile"), selectedImage: nil)

        let viewControllers = [agendaViewController, appointmentViewController, profileViewController].map{ BaseNavigationController(rootViewController: $0) }.map{
            $0.isNavigationBarHidden = false
            return $0
        }
        tabBarController.viewControllers = viewControllers
        tabBarController.tabBar.tintColor = AppStyle.primary
        tabBarController.tabBar.barTintColor = .white
        tabBarController.tabBar.backgroundColor = .white
        tabBarController.tabBar.unselectedItemTintColor = AppStyle.lightGrey
        tabBarController.tabBar.isTranslucent = false
        tabBarController.selectedIndex = 0
        
        navigationController.setViewControllers([tabBarController], animated: true)
    }
    
    private func getVisibleTab() -> UINavigationController? {
        return tabBarController.viewControllers?[tabBarController.selectedIndex] as? UINavigationController
    }*/
}

extension Router: LoginViewControllerDelegate {
    
    func loginCompleted(user: User) {
        dependency.getSessionRepository().save(user: user)
        dependency.set(sessionToken: user.token!)
//        showHome()
    }
}
/*
extension Router: ProfileViewControllerDelegate {

    func showUserInfo() {
        let view = UserInfoViewControllerViewComposer.compose(repo: dependency.sessionRepo())
        pushOnVisibleTab(view: view)
    }
    
    func logout() {
        dependency.clearSession()
        showLogin()
    }
    
    private func pushOnVisibleTab(view: UIViewController) {
        getVisibleTab()?.pushViewController(view, animated: true)
    }
}

extension Router: WebpageDelegate {
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
}*/
