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
    
    weak var coordinator: AppCoordinator?
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
    private lazy var appleSignUpButton = CompleteButton().then({
        $0.setTitle("apple", for: .normal)
    })
    private lazy var kakaoSignUpButton = CompleteButton().then({
        $0.setTitle("kakao", for: .normal)
        // MARK: - popup test
        $0.addTarget(self, action: #selector(popUpButtonTapped(_:)), for: .touchUpInside)
    })
    private lazy var emailSignUpButton = CompleteButton().then({
        $0.setTitle("email", for: .normal)
        $0.addTarget(self, action: #selector(emailSignUpButtonTapped(_:)), for: .touchUpInside)
    })
    
    private lazy var loginStackView = UIStackView().then({  // MARK: - 여기부터 다시
        $0.axis = .horizontal
        $0.alignment = .firstBaseline
    })
    
    private lazy var loginLabel = UILabel().then({
        $0.text = "이미 계정이 있나요?"
        $0.font = UIFont.setFont(size: 16, family: .Medium)
    })
    private lazy var loginButton = UIButton().then({
        $0.setTitle("로그인", for: .normal)
        $0.setTitleColor(ColorManager.primaryColor, for: .normal)
        $0.addTarget(self, action: #selector(loginButtonTapped(_:)), for: .touchUpInside)
    })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addViews()
        makeConstraints()
    }

    private func addViews() {
        view.addSubview(containerView)
        containerView.addSubViews([titleLabel1,
                                   titleLabel2,
                                   titleImage,
                                   appleSignUpButton,
                                   kakaoSignUpButton,
                                   emailSignUpButton,
                                   loginStackView])
        loginStackView.addArrangedSubviews([loginLabel,
                                           loginButton])
    }
    
    private func makeConstraints() {
        containerView.snp.makeConstraints { constraints in
            constraints.top.bottom.equalToSuperview()
            constraints.leading.equalToSuperview().offset(moderateScale(number: 20))
            constraints.trailing.equalToSuperview().offset(moderateScale(number: -20))
        }
        titleLabel1.snp.makeConstraints { constraints in
            constraints.top.equalToSuperview().offset(verticalScale(number: 60)) // 전체적으로 화면 위와 간격 수정 필요
            constraints.centerX.equalToSuperview()
        }
        titleLabel2.snp.makeConstraints { constraints in
            constraints.top.equalTo(titleLabel1.snp.bottom)
            constraints.centerX.equalToSuperview()
        }
        titleImage.snp.makeConstraints { constraints in
            constraints.top.equalTo(titleLabel2.snp.bottom).offset(verticalScale(number: 20)) //임시로 넣어놓음
            constraints.height.equalTo(moderateScale(number: 200))
            constraints.width.equalTo(moderateScale(number: 100))
            constraints.leading.trailing.equalToSuperview()
        }
    
        appleSignUpButton.snp.makeConstraints { constraints in
            constraints.top.equalTo(titleImage.snp.bottom).offset(verticalScale(number: 50)) // 임시로 넣어줌
            constraints.width.equalToSuperview()
            constraints.height.equalTo(moderateScale(number: 52))
        }
        kakaoSignUpButton.snp.makeConstraints { constraints in
            constraints.top.equalTo(appleSignUpButton.snp.bottom).offset(verticalScale(number: 16))
            constraints.width.equalToSuperview()
            constraints.height.equalTo(moderateScale(number: 52))
        }
        emailSignUpButton.snp.makeConstraints { constraints in
            constraints.top.equalTo(kakaoSignUpButton.snp.bottom).offset(verticalScale(number: 16))
            constraints.width.equalToSuperview()
            constraints.height.equalTo(moderateScale(number: 52))
        }

        loginStackView.snp.makeConstraints({ constraints in
            constraints.top.equalTo(emailSignUpButton.snp.bottom).offset(verticalScale(number: 16))
            constraints.centerX.equalToSuperview()
        })
        
    }
}

extension OnBoardingViewController {
    @objc func loginButtonTapped(_ button: UIButton) {
        coordinator?.login()
    }
    
    @objc func emailSignUpButtonTapped(_ button: UIButton) {
        coordinator?.signUp()
    }
    // MARK: - popup test
    @objc func popUpButtonTapped(_ button: UIButton) {
        showPopUp(title: "타이틀", message: "메세지")
    }
}
