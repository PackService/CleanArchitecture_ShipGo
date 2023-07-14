//
//  OnBoardingViewController.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/07/14.
//

import UIKit
import SnapKit
import Then

class OnBoardingViewController: UIViewController {
    
//    private lazy var loginButton = UIButton().then({
//        $0.setTitle("login", for: .normal)
//    })
    
    private lazy var titleLabel = UILabel().then({
        $0.text = "내 택배 위치를\n손쉽게 추적하기"
        $0.font = UIFont.systemFont(ofSize: moderateScale(number: 16), weight: .medium)
    })
    
    private lazy var titleImage = UIImageView().then({
        $0.image = UIImage(systemName: "circle")
    })
    
    // MARK: - custombutton 만들어서 수정하기
    private lazy var appleLoginButton = UIButton().then({
        $0.setTitle("apple", for: .normal)
    })
    
    private lazy var kakaoLoginButton = UIButton().then({
        $0.setTitle("kakao", for: .normal)
    })
    
    private lazy var emailLoginButton = UIButton().then({
        $0.setTitle("email", for: .normal)
    })
    
    private lazy var loginLabel = UILabel().then({
        $0.text = "이미 계정이 있나요?"
    })
    
    private lazy var loginButton = UIButton().then({
        $0.setTitle("로그인", for: .normal)
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
