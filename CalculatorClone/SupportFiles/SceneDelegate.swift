//
//  SceneDelegate.swift
//  CalculatorClone
//
//  Created by Азиз Рахманов on 05/01/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let window = UIWindow(windowScene: scene as! UIWindowScene)
        window.rootViewController = ViewController(nibName: nil, bundle: nil)
        window.makeKeyAndVisible()
        self.window = window
    }
    
    

    

}

