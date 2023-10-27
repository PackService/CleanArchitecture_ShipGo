//
//  LoginCoordinator.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/08/01.
//

import UIKit

class LoginCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    weak var parentCoordinator: Coordinator?
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = AppContainer.shared.resolve(LoginViewController.self)! // MARK: -의존성 주입 이런식으로..?
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func tabBar() {
        let child = MainTabBarCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }
}
