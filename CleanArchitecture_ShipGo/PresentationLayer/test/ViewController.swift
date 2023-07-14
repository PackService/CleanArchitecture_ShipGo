//
//  ViewController.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/07/14.
//

import UIKit
import SnapKit
import Then

// MARK: - 첫 화면
class ViewController: UIViewController {
    
    weak var coordinator: AppCoordinator?
    var isLogged: Bool = false
    
    private lazy var loginButton = UIButton().then({
        $0.setTitle("login", for: .normal)
    })
    
    private lazy var buyButton = UIButton().then({
        $0.setTitle("buy", for: .normal)
    })

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        addViews()
        makeConstraints()
        loginButton.addTarget(self, action: #selector(loginButtonTapped(_:)), for: .touchUpInside)
        buyButton.addTarget(self, action: #selector(buyButtonTapped(_:)), for: .touchUpInside)
    }

    private func addViews() {
        view.addSubview(loginButton)
        view.addSubview(buyButton)
    }
    
    private func makeConstraints() {
        buyButton.snp.makeConstraints { [weak self] constraints in
            guard let selfRef = self else { return }
            constraints.centerX.equalToSuperview()
            constraints.centerY.equalToSuperview()
        }
    }
    
    
    @objc func loginButtonTapped(_ button: UIButton) {
        print("눌림")
        coordinator?.createAccount()
    }
    
    @objc func buyButtonTapped(_ button: UIButton) {
        print("눌림")
        coordinator?.buySubscription()
        print(coordinator)
    }
}

// 화면 구성 해서 테스트
