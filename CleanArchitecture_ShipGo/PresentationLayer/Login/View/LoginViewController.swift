//
//  LoginViewController.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/08/01.
//

import UIKit
import Combine
import SnapKit
import Then
import FirebaseAuth
import Swinject

class LoginViewController: UIViewController {

    weak var coordinator: LoginCoordinator?
    private var cancelBag = Set<AnyCancellable>()
    var viewModel: LoginViewModel!
    
    private lazy var containerView = UIView()
    
    private lazy var titleStackView = UIStackView().then({
        $0.axis = .horizontal
        $0.alignment = .center
        $0.spacing = 10
    })
    private lazy var titleImageView = UIImageView().then({
        $0.image = UIImage(named: "easytrack")
    })
    private lazy var titleLabel = UILabel().then({
        $0.text = "쉽고"
//        $0.font = UIFont.setFont(size: <#T##CGFloat#>)
    })
    private lazy var emailTextField = InputTextField().then({
        $0.placeholder = "email"
    })
    private lazy var passwordTextField = InputTextField().then({
        $0.placeholder = "password"
        $0.isSecureTextEntry = true
    })
    private lazy var loginButton = CompleteButton().then({ // 로그인 버튼 누르면 탭바되도록 나중에 수정
        $0.setTitle("로그인", for: .normal)
        $0.addTarget(self, action: #selector(loginButtonTapped(_:)), for: .touchUpInside)
    })
    private lazy var signUpStackView = UIStackView().then({
        $0.axis = .horizontal
        $0.alignment = .firstBaseline
    })
    private lazy var signUpLabel = UILabel().then({
        $0.text = "계정이 없으신가요? "
    })
    private lazy var signUpButton = UIButton().then({
        $0.setTitle("회원가입", for: .normal)
        $0.setTitleColor(ColorManager.primaryColor, for: .normal)
    })
    private lazy var separatorView = UIView().then({
        $0.backgroundColor = .black
    })
    private lazy var appleLoginButton = CompleteButton().then({
        $0.setTitle("apple", for: .normal)
    })
    private lazy var kakaoLoginButton = CompleteButton().then({
        $0.setTitle("kakao", for: .normal)
    })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        print(Bundle.main.object(forInfoDictionaryKey: "DELIVERY_API_KEY") as? String)
        addViews()
        makeConstraints()
        bind()
    }

    private func addViews() {
        view.addSubview(containerView)
        containerView.addSubViews([titleStackView,
                                  emailTextField,
                                  passwordTextField,
                                  loginButton,
                                  signUpStackView,
                                  separatorView,
                                  appleLoginButton,
                                  kakaoLoginButton])
        titleStackView.addArrangedSubviews([titleImageView,
                                           titleLabel])
        signUpStackView.addArrangedSubviews([signUpLabel,
                                            signUpButton])
    }
    
    private func makeConstraints() {
        containerView.snp.makeConstraints { constraints in
            constraints.top.bottom.equalToSuperview()
            constraints.leading.equalToSuperview().offset(moderateScale(number: 20))
            constraints.trailing.equalToSuperview().offset(moderateScale(number: -20))
        }
        titleStackView.snp.makeConstraints { constraints in
            constraints.top.equalToSuperview().offset(verticalScale(number: 60))
            constraints.centerX.equalToSuperview()
        }
        titleImageView.snp.makeConstraints { constraints in
            constraints.width.equalTo(moderateScale(number: 62))
            constraints.height.equalTo(moderateScale(number: 62))
        }
        emailTextField.snp.makeConstraints { constraints in
            constraints.top.equalTo(titleStackView.snp.bottom).offset(verticalScale(number: 40)) //임시
            constraints.leading.trailing.equalToSuperview()
            constraints.height.equalTo(moderateScale(number: 62))
        }
        passwordTextField.snp.makeConstraints { constraints in
            constraints.top.equalTo(emailTextField.snp.bottom).offset(verticalScale(number: 16)) //임시
            constraints.leading.trailing.equalToSuperview()
            constraints.height.equalTo(moderateScale(number: 62))
        }
        loginButton.snp.makeConstraints { constraints in
            constraints.top.equalTo(passwordTextField.snp.bottom).offset(verticalScale(number: 50)) //임시
            constraints.leading.trailing.equalToSuperview()
            constraints.height.equalTo(moderateScale(number: 52))
        }
        signUpStackView.snp.makeConstraints { constraints in
            constraints.top.equalTo(loginButton.snp.bottom).offset(verticalScale(number: 16))
            constraints.centerX.equalToSuperview()
        }
        separatorView.snp.makeConstraints { constraints in
            constraints.top.equalTo(signUpStackView.snp.bottom).offset(verticalScale(number: 16)) // 임시
            constraints.height.equalTo(1)
            constraints.leading.trailing.equalToSuperview()
        }
        appleLoginButton.snp.makeConstraints { constraints in
            constraints.top.equalTo(separatorView.snp.bottom).offset(verticalScale(number: 16))
            constraints.leading.trailing.equalToSuperview()
            constraints.height.equalTo(moderateScale(number: 52))
        }
        kakaoLoginButton.snp.makeConstraints { constraints in
            constraints.top.equalTo(appleLoginButton.snp.bottom).offset(verticalScale(number: 16))
            constraints.leading.trailing.equalToSuperview()
            constraints.height.equalTo(moderateScale(number: 52))
        }
    }
    
    private func bind() {
        viewModel.loginPublisher()
            .sink { [weak self] result in
                if result == .success {
                    print("로그인 성공해서 탭 바 화면으로 이동")
                    self?.coordinator?.tabBar()
                } else {
                    self?.showPopUp(title: "에러",
                              message: result.rawValue)
                }
            }
            .store(in: &cancelBag)
    }
}

extension LoginViewController {
    @objc func tabBarButtonTapped(_ button: UIButton) { // 탭 바 화면으로 이동하는 것, 해당 로직 로그인 성공 시 되도록 수정
        coordinator?.tabBar()
    }
    
    @objc private func loginButtonTapped(_ button: UIButton) {
        self.viewModel.sendShouldLogin(email: self.emailTextField.text ?? "",
                                       password: self.passwordTextField.text ?? "")
    }
}
