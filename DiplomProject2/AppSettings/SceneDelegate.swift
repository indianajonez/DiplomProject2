//
//  SceneDelegate.swift
//  DiplomProject2
//
//  Created by Ekaterina Saveleva on 19.11.2023.
//

import UIKit

//TODO: Сессия не сохраняется при перезаходе в приложение…Надо в SceneDelegate проверять, есть ли сохраненная пользовательская сессия, и если есть, то не показывать экран логина, а сразу отображать таб бар

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow (windowScene: scene)
        self.window = window
        window.makeKeyAndVisible()
        let navigation = UINavigationController(rootViewController: LoginViewController(checkerService: CheckerService()))
        window.rootViewController = navigation
    }

    func sceneDidDisconnect(_ scene: UIScene) {

    }

    func sceneDidBecomeActive(_ scene: UIScene) {

    }

    func sceneWillResignActive(_ scene: UIScene) {

    }

    func sceneWillEnterForeground(_ scene: UIScene) {

    }

    func sceneDidEnterBackground(_ scene: UIScene) {

    }
}



