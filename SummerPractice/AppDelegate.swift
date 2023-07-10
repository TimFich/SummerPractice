//
//  AppDelegate.swift
//  SummerPractice
//
//  Created by Тимур Миргалиев on 29.06.2023.
//

import UIKit

@UIApplicationMain
class AppDelegate : UIResponder, UIApplicationDelegate {
    
    var window : UIWindow?
    
    private var rootFlowCoordinator: MainFlowCoordinator!
    private let rootNavigationController: UINavigationController = UINavigationController()
    
    func startMainFlowCoordinator(rootViewController: UINavigationController) {
        rootFlowCoordinator = MainFlowCoordinator(parentViewController: rootViewController)
        rootFlowCoordinator.start(animated: true)
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
        if #available(iOS 13, *) {

        } else {
            self.window = UIWindow()
            rootNavigationController.view.backgroundColor = .white
            window!.rootViewController = rootNavigationController
            window!.makeKeyAndVisible()
            startMainFlowCoordinator(rootViewController: rootNavigationController)
        }
        return true
    }
    
    // MARK: - UISceneSession Lifecycle
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
