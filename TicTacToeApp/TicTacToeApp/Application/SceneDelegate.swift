//
//  SceneDelegate.swift
//  TicTacToeApp
//
//  Created by Надежда Капацина on 29.09.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let rootController = OnboardingVC()
        let navController = CustomNavigationController(rootViewController: rootController)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
}
