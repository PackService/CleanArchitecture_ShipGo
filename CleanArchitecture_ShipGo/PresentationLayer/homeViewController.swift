//
//  homeViewController.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/08/01.
//

import UIKit
import SnapKit
import Then

class HomeViewController: UIViewController {
    
    // MARK: - 이거 체크 Coordinaotr 프로토콜 채택해도 가능한건지
    weak var coordinator: Coordinator?
    
    private lazy var containerView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.title = "Home"
        addViews()
        makeConstraints()
    }

    private func addViews() {
    }
    
    private func makeConstraints() {
    }
}
