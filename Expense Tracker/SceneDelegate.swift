//
//  SceneDelegate.swift
//  Expense Tracker
//
//  Created by Apple on 08/04/26.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if AuthManager.shared.isLoggedIn() {
            // ✅ Go to Home (TabBar)
            let tabBarVC = storyboard.instantiateViewController(withIdentifier: "TabBarController")
            window.rootViewController = tabBarVC
            
//            let authVC = storyboard.instantiateViewController(withIdentifier: "AuthViewController")
//            window.rootViewController = authVC
        } else {
            // ✅ Go to Auth Screen
            let authVC = storyboard.instantiateViewController(withIdentifier: "AuthViewController")
            window.rootViewController = authVC
        }
        
        self.window = window
        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

//    func sceneWillEnterForeground(_ scene: UIScene) {
//        // Called as the scene transitions from the background to the foreground.
//        // Use this method to undo the changes made on entering the background.
//    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        
        guard let window = self.window else { return }
        
        if !AuthManager.shared.isLoggedIn() {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let authVC = storyboard.instantiateViewController(withIdentifier: "AuthViewController")
            
            window.rootViewController = authVC
            
            // 🔥 Show toast after slight delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.showToast(message: "Session expired. Please login again.")
            }
        }
    }

    
    func showToast(message: String) {
        
        guard let window = self.window else { return }
        
        let toastLabel = UILabel()
        toastLabel.text = message
        toastLabel.textColor = .white
        toastLabel.textAlignment = .center
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        toastLabel.font = UIFont.systemFont(ofSize: 14)
        toastLabel.numberOfLines = 0
        
        toastLabel.alpha = 0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        
        let padding: CGFloat = 16
        
        window.addSubview(toastLabel)
        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            toastLabel.leadingAnchor.constraint(equalTo: window.leadingAnchor, constant: 20),
            toastLabel.trailingAnchor.constraint(equalTo: window.trailingAnchor, constant: -20),
            toastLabel.bottomAnchor.constraint(equalTo: window.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
        // Animate
        UIView.animate(withDuration: 0.3, animations: {
            toastLabel.alpha = 1
        }) { _ in
            UIView.animate(withDuration: 0.3, delay: 2, options: [], animations: {
                toastLabel.alpha = 0
            }) { _ in
                toastLabel.removeFromSuperview()
            }
        }
    }
}

