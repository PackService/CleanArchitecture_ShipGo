//
//  ListMainViewController.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/08/01.
//

import UIKit
import SnapKit
import Then

class ListMainViewController: UIViewController {
    
    weak var coordinator: Coordinator?
    
    private lazy var containerView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        addViews()
        makeConstraints()
    }

    private func addViews() {
    }
    
    private func makeConstraints() {
    }
}
