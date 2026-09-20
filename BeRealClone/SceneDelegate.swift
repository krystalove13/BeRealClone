//
//  SceneDelegate.swift
//  BeRealClone
//
//  Created by Krystal Lewin on 9/18/26.
//

import UIKit
import ParseSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    enum Constants {
        static let loginNotification: Notification.Name = Notification.Name("login")
        static let logoutNotification: Notification.Name = Notification.Name("logout")
        static let feedNavigationControllerIdentifier = "FeedNavigationController"
        static let loginNavigationControllerIdentifier = "LoginNavigationController"
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }

        // Observe login and logout notifications
        NotificationCenter.default.addObserver(forName: Constants.loginNotification, object: nil, queue: OperationQueue.main) { [weak self] _ in
            self?.login()
        }

        NotificationCenter.default.addObserver(forName: Constants.logoutNotification, object: nil, queue: OperationQueue.main) { [weak self] _ in
            self?.logout()
        }

        // Check for cached user session
        if User.current != nil {
            login()
        }
    }

    private func login() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.window?.rootViewController = storyboard.instantiateViewController(withIdentifier: Constants.feedNavigationControllerIdentifier)
    }

    private func logout() {
        // Asynchronously log out with ParseSwift
        User.logout { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    print("Successfully logged out user.")
                case .failure(let error):
                    print("Logout error: \(error.localizedDescription)")
                }

                // Transition back to the login screen regardless of network result
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                self?.window?.rootViewController = storyboard.instantiateViewController(withIdentifier: Constants.loginNavigationControllerIdentifier)
            }
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {}
    func sceneDidBecomeActive(_ scene: UIScene) {}
    func sceneWillResignActive(_ scene: UIScene) {}
    func sceneWillEnterForeground(_ scene: UIScene) {}
    func sceneDidEnterBackground(_ scene: UIScene) {}
}
