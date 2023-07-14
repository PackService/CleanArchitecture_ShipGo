//
//  LoginViewController.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/07/12.
//

import UIKit
import SnapKit
import Then

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
