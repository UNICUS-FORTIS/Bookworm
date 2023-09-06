//
//  SceneDelegate.swift
//  CollectionViewPractice
//
//  Created by LOUIE MAC on 2023/07/31.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
//        let appearance = UINavigationBarAppearance()
//        UIBarButtonItem.appearance().tintColor = UIColor.gray
//        appearance.titleTextAttributes = [.foregroundColor: UIColor.gray]
//        UINavigationBar.appearance().standardAppearance = appearance
        
        
        let tabBarVC = UITabBarController()
        tabBarVC.tabBar.tintColor = .black
        let vc1 = UINavigationController(rootViewController: MainViewController())
        let vc2 = LikeViewController()
        let vc3 = MemoViewController()
        
        vc1.title = "BookSearch"
        vc2.title = "Like"
        vc3.title = "Memo"
        
        tabBarVC.setViewControllers([vc1, vc2, vc3], animated: false)
        tabBarVC.modalPresentationStyle = .fullScreen
        tabBarVC.tabBar.backgroundColor = .white
        
        guard let items = tabBarVC.tabBar.items else { return }
        items[0].image = UIImage(systemName: "book")
        items[1].image = UIImage(systemName: "folder")
        items[2].image = UIImage(systemName: "pencil")
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = tabBarVC
        window?.makeKeyAndVisible()
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
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
}

