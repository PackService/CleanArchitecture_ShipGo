//
//  LoginViewController.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/08/01.
//

import UIKit

class LoginViewController: UIViewController {

    weak var coordinator: LoginCoordinator?
    
    private lazy var tabBarButton = UIButton().then({
        $0.setTitle("탭바로 이동", for: .normal)
        $0.addTarget(self, action: #selector(tabBarButtonTapped(_:)), for: .touchUpInside)
    })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        self.navigationItem.title = "login"
        addViews()
        makeConstraints()
    }
    

    private func addViews() {
        view.addSubview(tabBarButton)
    }
    
    private func makeConstraints() {
        tabBarButton.snp.makeConstraints { constraints in
            constraints.centerX.equalToSuperview()
            constraints.centerY.equalToSuperview()
        }
    }
}

extension LoginViewController {
    @objc func tabBarButtonTapped(_ button: UIButton) {
        coordinator?.tabBar()
    }
}
