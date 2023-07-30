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
    
    private lazy var containerView = UIView()
    
    private lazy var titleLabel1 = UILabel().then({
        $0.text = "내 택배 위치를"
        $0.font = UIFont.setFont(size: 26, family: .Bold)
    })
    
    private lazy var titleLabel2 = UILabel().then({
        $0.text = "손쉽게 추적하기"
        $0.font = UIFont.setFont(size: 26, family: .Bold)
    })
    
    private lazy var titleImage = UIImageView().then({
        $0.image = UIImage(named: "onboarding_illust")
    })
    
    private lazy var signUpButtonStackView = UIStackView().then({
        $0.axis = .vertical
        $0.alignment = .center
        $0.distribution = .equalSpacing
    })
    // MARK: - custombutton 만들어서 수정하기
    private lazy var appleSignUpButton = UIButton().then({
        $0.setTitle("apple", for: .normal)
    })
    
    private lazy var kakaoSignUpButton = UIButton().then({
        $0.setTitle("kakao", for: .normal)
    })
    
    private lazy var emailSignUpButton = UIButton().then({
        $0.setTitle("email", for: .normal)
    })
    
    private lazy var loginStackView = UIStackView().then({
        $0.axis = .horizontal
        $0.alignment = .firstBaseline
    })
    
    private lazy var loginLabel = UILabel().then({
        $0.text = "이미 계정이 있나요?"
        $0.font = UIFont.setFont(size: 16, family: .Medium)
    })
    
    private lazy var loginButton = UIButton().then({
        $0.setTitle("로그인", for: .normal)
    })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        addViews()
        makeConstraints()
    }

    private func addViews() {
        view.addSubview(containerView)
        containerView.addSubViews([titleLabel1,
                                  titleLabel2,
                                  titleImage,
                                  signUpButtonStackView,
                                  loginStackView])
        signUpButtonStackView.addArrangedSubviews([appleSignUpButton,
                                                   kakaoSignUpButton,
                                                   emailSignUpButton])
        loginStackView.addArrangedSubviews([loginLabel,
                                           loginButton])
    }
    
    private func makeConstraints() {
        containerView.snp.makeConstraints { constraints in
            constraints.top.bottom.trailing.leading.equalToSuperview()
        }
        titleLabel1.snp.makeConstraints { constraints in
            constraints.top.equalToSuperview().offset(moderateScale(number: 88))
            constraints.centerX.equalToSuperview()
        }
        titleLabel2.snp.makeConstraints { constraints in
            constraints.top.equalTo(titleLabel1.snp.bottom)
            constraints.centerX.equalToSuperview()
        }
        titleImage.snp.makeConstraints { constraints in
            constraints.top.equalTo(titleLabel2.snp.bottom)
            constraints.height.equalTo(moderateScale(number: 100))
            constraints.leading.trailing.equalToSuperview()
        }
        signUpButtonStackView.snp.makeConstraints { constraints in
            constraints.top.equalTo(titleImage.snp.bottom).offset(moderateScale(number: 100)) // 수정 필요, 버튼 간 간격도 수정 필요
            constraints.height.equalTo(moderateScale(number: 200))
            constraints.leading.equalToSuperview().offset(moderateScale(number: 20))
            constraints.trailing.equalToSuperview().offset(moderateScale(number: -20))
        }
        loginStackView.snp.makeConstraints({ constraints in
            constraints.top.equalTo(signUpButtonStackView.snp.bottom).offset(moderateScale(number: 16))
            constraints.bottom.equalToSuperview().offset(moderateScale(number: -77))
            constraints.centerX.equalToSuperview()
        })
        
    }
}
