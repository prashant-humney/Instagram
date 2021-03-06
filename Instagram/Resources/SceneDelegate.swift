//
//  SceneDelegate.swift
//  Instagram
//
//  Created by Prashant Humney on 06/03/21.
//  Copyright © 2021 Prashant Humney. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?


  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    guard let windowScene = (scene as? UIWindowScene) else { return }
    window = UIWindow(windowScene: windowScene)
    window?.makeKeyAndVisible()
    
    setupRootView()
//    let navigationController = UINavigationController(rootViewController: HomeViewController())
//
//    navigationController.navigationBar.barTintColor = UIColor(red: 51/255, green: 90/255, blue: 149/255, alpha: 1.0)
//    navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
//    // this seems so weird. Setting it to black sets the bar style to white 🤣
//    //FYI: Use CMD + CTRL + SPACE to bring up emojis option.
//    navigationController.navigationBar.barStyle = .black
//
//    window?.rootViewController = navigationController
    
  }

  func sceneDidDisconnect(_ scene: UIScene) {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
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
  
  private func setupRootView() {
    let tabBarViewController = UITabBarController.init()
    
    let firstNavigationController = UINavigationController.init(rootViewController: HomeViewController())
    let secondNavigationController = UINavigationController.init(rootViewController: ExploreViewController())
    let thirdNavigationController = UINavigationController.init(rootViewController: CameraViewController())
    let fourthNavigationController = UINavigationController.init(rootViewController: NotificationsViewController())
    let fifthNavigationController = UINavigationController.init(rootViewController: ProfileViewController())
    
    firstNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 0)
    secondNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
    thirdNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 2)
    fourthNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 3)
    fifthNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .mostViewed, tag: 4)
    
    tabBarViewController.setViewControllers([firstNavigationController, secondNavigationController, thirdNavigationController, fourthNavigationController, fifthNavigationController], animated: true)
    
    window?.rootViewController = tabBarViewController
  }


}

