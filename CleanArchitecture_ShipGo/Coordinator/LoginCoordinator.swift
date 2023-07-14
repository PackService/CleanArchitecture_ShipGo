//
//  LoginCoordinator.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/07/14.
//

import UIKit

protocol LoginCoordinatorDelegate {
    func didLoggedIn(_ coordinator: LoginCoordinator)
}

class LoginCoordinator: Coordinator, LoginViewControllerDelegate {

    var childCoordinator: [Coordinator] = []
    var delegate: LoginCoordinatorDelegate?
    
    private var navigationController: UINavigationController!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = LoginViewController()
        viewController.view.backgroundColor = .brown
        viewController.delegate = self
        
        self.navigationController.viewControllers = [viewController]
    }
    
    func login() {
        self.delegate?.didLoggedIn(self)
    }
}





// MARK: - move to loginviewcontroller.swift
protocol LoginViewControllerDelegate {
    func login()
}

class LoginViewController: UIViewController {

    var delegate: LoginViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let item = UIBarButtonItem(title: "로그인", style: .plain, target: self, action: #selector(self.loginButtonDidTap))
        self.navigationItem.rightBarButtonItem = item
    }
    
    deinit {
        print("- \(type(of: self)) deinit")
    }
    
    @objc
    func loginButtonDidTap() {
        self.delegate?.login()
    }
}
