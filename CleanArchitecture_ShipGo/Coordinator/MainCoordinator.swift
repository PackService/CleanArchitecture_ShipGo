//
//  MainCoordinator.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/07/14.
//

import UIKit

protocol MainCoordinatorDelegate {
    func didLoggedOut(_ coordinator: MainCoordinator)
}

// MARK: - MainCoordinator TabBarCoordinator로 변경 필요
class MainCoordinator: Coordinator, MainViewControllerDelegate {
    
    var childCoordinator: [Coordinator] = []
    var delegate: MainCoordinatorDelegate?
    
    private var navigationController: UINavigationController!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = MainViewController()
        viewController.view.backgroundColor = .cyan
        viewController.delegate = self
        self.navigationController.viewControllers = [viewController]
    }
    
    func logout() {
        self.delegate?.didLoggedOut(self)
    }
}


// MARK: - 파일 분리
protocol MainViewControllerDelegate {
    func logout()
}

class MainViewController: UIViewController {

    var delegate: MainViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let item = UIBarButtonItem(title: "로그아웃", style: .plain, target: self, action: #selector(logoutButtonDidTap))
        self.navigationItem.rightBarButtonItem = item
        // Do any additional setup after loading the view.
    }
    
    deinit {
        print("- \(type(of: self)) deinit")
    }
    
    @objc
    func logoutButtonDidTap() {
        self.delegate?.logout()
    }
}
