//
//  SignUpStep1ViewController.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 7/30/23.
//

import UIKit
import SnapKit
import Then

class SignUpViewController: UIViewController {
    
    weak var coordinator: Coordinator?
    
    private lazy var containerView = UIView()
    
//    private lazy var titleLabel1 = UILabel().then({
//        $0.text = "계정을"
//        $0.font = UIFont.setFont(size: 26, family: .Bold)
//    })
//
//    private lazy var titleLabel2 = UILabel().then({
//        $0.text = "만들어주세요"
//        $0.font = UIFont.setFont(size: 26, family: .Bold)
//    })
//
//    private lazy var
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.title = "signup"
        addViews()
        makeConstraints()
    }

    private func addViews() {
    }
    
    private func makeConstraints() {
    }
}
