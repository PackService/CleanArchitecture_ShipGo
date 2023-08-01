//
//  TabBarHomeCoordinator.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/08/01.
//

import UIKit

class TabBarHomeCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    weak var parentCoordinator: MainTabBarCoordinator?
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = HomeMainViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
