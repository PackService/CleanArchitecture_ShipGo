//
//  SceneDelegate.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/07/11.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var coordinator: Coordinator?
//    let status = UserDefaults.standard.string(forKey: "status") // status에 사용자 이메일 저장. 이메일 없으면 온보딩 화면 있으면 바로 메인화면으로 가도록
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
//        guard let windowScene = (scene as? UIWindowScene) else { return }
//
//        let appWindow = UIWindow(frame: windowScene.coordinateSpace.bounds)
//        appWindow.windowScene = windowScene
//
//        let navigationController = UINavigationController()
//
//        if UserDefaultsUtil.shared.getIsLogin() {
//            coordinator = MainTabBarCoordinator(navigationController: navigationController)
//        } else {
//            coordinator = AppCoordinator(navigationController: navigationController)
//        }
//        coordinator?.start()
//        appWindow.rootViewController = navigationController
//        appWindow.makeKeyAndVisible()
//
//        window = appWindow
        
        // MARK: -화면 확인용
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = RegisterTrackViewController()
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

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

