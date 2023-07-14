//
//  AppCoordinator.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/07/14.
//

import UIKit

// MARK: - 메모리 누수 check
// https://zeddios.medium.com/coordinator-pattern-bf4a1bc46930
class AppCoordinator: Coordinator, LoginCoordinatorDelegate, MainCoordinatorDelegate {

    var childCoordinator: [Coordinator] = []
    private var navigationController: UINavigationController!
    
    var isLoggedIn: Bool = false
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        if self.isLoggedIn {
            self.showMainViewController()
        } else {
            self.showLoginViewController()
        }
    }
    
    private func showMainViewController() {
        let coordinator = MainCoordinator(navigationController: self.navigationController)
        coordinator.delegate = self
        coordinator.start()
        self.childCoordinator.append(coordinator)
    }
    
    private func showLoginViewController() {
        let coordinator = LoginCoordinator(navigationController: self.navigationController)
        coordinator.delegate = self
        coordinator.start()
        self.childCoordinator.append(coordinator)
    }
    
    func didLoggedIn(_ coordinator: LoginCoordinator) {
        self.childCoordinator = self.childCoordinator.filter { $0 !== coordinator }
        self.showMainViewController()
    }
    
    func didLoggedOut(_ coordinator: MainCoordinator) {
        self.childCoordinator = self.childCoordinator.filter { $0 !== coordinator }
        self.showLoginViewController()
    }
}
