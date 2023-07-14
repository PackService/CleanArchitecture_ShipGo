//
//  MainCoordinator.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/07/14.
//

import UIKit

class BuyCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    weak var parentCoordinator: AppCoordinator?
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        print("start 함수 호출")
        let vc = BuyViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    
    
}
