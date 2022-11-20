//
//  SceneDelegate.swift
//  Stargazers
//
//  Created by Alessio Quattrocchi on 20/11/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let module = StargazerModule()
        let controller = module.createStargazerViewController()
        let nvc: UINavigationController = UINavigationController(rootViewController: controller)
        window?.rootViewController = nvc
        window?.makeKeyAndVisible()
    }
}

