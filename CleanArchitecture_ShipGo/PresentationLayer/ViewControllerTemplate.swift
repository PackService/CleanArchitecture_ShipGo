//
//  ViewControllerTemplate.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/07/14.
//

import UIKit
import SnapKit
import Then

// MARK: - ViewController 템플릿 용 추후 삭제
class ViewControllerTemplate: UIViewController {
    
    private lazy var loginButton = UIButton().then({
        $0.setTitle("login", for: .normal)
    })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        addViews()
        makeConstraints()
    }

    private func addViews() {
        view.addSubview(loginButton)
    }
    
    private func makeConstraints() {
        loginButton.snp.makeConstraints { [weak self] constraints in
            guard let selfRef = self else { return }
            constraints.centerX.equalToSuperview()
            constraints.centerY.equalToSuperview()
        }
    }
}
