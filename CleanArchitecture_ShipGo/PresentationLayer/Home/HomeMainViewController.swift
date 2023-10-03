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
    
    private lazy var containerView = UIView().then({
        $0.backgroundColor = .yellow
    })
    
    private lazy var headerView = CurrentDeliveryHeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        
        addViews()
        makeConstraints()
    }

    private func addViews() {
        view.addSubview(containerView)
//        containerView.addSubview(headerView)
    }
    
    private func makeConstraints() {
        containerView.snp.makeConstraints { constraints in
            constraints.edges.equalToSuperview()
        }
//        headerView.snp.makeConstraints { constraints in
//            constraints.centerX.equalToSuperview()
//            constraints.centerY.equalToSuperview()
//        }
    }
}
