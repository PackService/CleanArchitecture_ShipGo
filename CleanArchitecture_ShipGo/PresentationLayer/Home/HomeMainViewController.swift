//
//  homeViewController.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/08/01.
//

import UIKit
import SnapKit
import Then

class HomeMainViewController: UIViewController {
    
    weak var coordinator: Coordinator?
    
    private lazy var containerView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.title = "Home"
        
        print("api 테스트")
        addViews()
        makeConstraints()
    }

    private func addViews() {
    }
    
    private func makeConstraints() {
    }
}
