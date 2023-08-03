//
//  SignUpStep1ViewController.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 7/30/23.
//

import UIKit
import Combine
import SnapKit
import Then

final class SignUpViewController: UIViewController {
    
    weak var coordinator: SignUpCoordinator?
    
    private var cancelBag = Set<AnyCancellable>()
    var viewModel: SignUpViewModel = SignUpViewModel()
    
    private lazy var containerView = UIView()
    private lazy var titleLabel1 = UILabel().then({
        $0.text = "계정을"
        $0.font = UIFont.setFont(size: moderateScale(number: 26), family: .Bold)
    })

    private lazy var titleLabel2 = UILabel().then({
        $0.text = "만들어주세요"
        $0.font = UIFont.setFont(size: moderateScale(number: 26), family: .Bold)
    })
    
    private lazy var allAgreementCheck = SelectButton().then({
        $0.addTarget(self, action: #selector(allAgreeButtonTapped(_:)), for: .touchUpInside)
    })
    
    private lazy var allAgreementLabel = UILabel().then({
        $0.text = "전체 동의하기"
        $0.font = UIFont.setFont(size: moderateScale(number: 20), family: .SemiBold)
    })
    
    private lazy var firstAgreementCheck = SelectButton().then({
        $0.addTarget(self, action: #selector(firstAgreeButtonTapped(_:)), for: .touchUpInside)
    })
    
    private lazy var step1SignUpView = UIView()
    
    private lazy var firstAgreementLabel = UILabel().then({
        $0.text = "만 14세 이상입니다"
        $0.font = UIFont.setFont(size: moderateScale(number: 17), family: .Medium)
    })

    private lazy var secondAgreementCheck = SelectButton().then({
        $0.addTarget(self, action: #selector(secondAgreeButtonTapped(_:)), for: .touchUpInside)
    })
    
    private lazy var secondAgreementLabel = UILabel().then({
        $0.text = "서비스 이용 약관"
        $0.font = UIFont.setFont(size: moderateScale(number: 17), family: .Medium)
    })
    
    private lazy var thirdAgreementCheck = SelectButton().then({
        $0.addTarget(self, action: #selector(thirdAgreeButtonTapped(_:)), for: .touchUpInside)
    })
    
    private lazy var thirdAgreementLabel = UILabel().then({
        $0.text = "개인정보 수집 및 이용 동의"
        $0.font = UIFont.setFont(size: moderateScale(number: 17), family: .Medium)
    })
    
    private lazy var createAccountButton = CompleteButton().then({
        $0.setTitle("계정 만들기", for: .normal)
        $0.addTarget(self, action: #selector(createAccountButtonTapped(_:)), for: .touchUpInside)
    })
    
    private lazy var step2SignUpView = UIView()
    
    private lazy var emailTextField = InputTextField().then({
        $0.placeholder = "이메일을 입력하세요"
        $0.font = UIFont.setFont(size: 20, family: .SemiBold)
    })
    private lazy var passwordTextField = InputTextField().then({
        $0.placeholder = "비밀번호"
        $0.font = UIFont.setFont(size: 20, family: .SemiBold)
    })
    private lazy var passwordCheckTextField = InputTextField().then({
        $0.placeholder = "비밀번호를 한번 더 입력하세요"
        $0.font = UIFont.setFont(size: 20, family: .SemiBold)
    })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        addViews()
        makeConstraints()
        bind()
    }

    private func addViews() {
        view.addSubview(containerView)
        containerView.addSubViews([titleLabel1,
                                   titleLabel2,
                                   allAgreementCheck,
                                   allAgreementLabel,
                                   step1SignUpView,
                                   step2SignUpView,
                                   createAccountButton])
        step1SignUpView.addSubViews([firstAgreementCheck,
                                     firstAgreementLabel,
                                     secondAgreementCheck,
                                     secondAgreementLabel,
                                     thirdAgreementCheck,
                                     thirdAgreementLabel])
        step2SignUpView.addSubViews([emailTextField,
                                    passwordTextField,
                                    passwordCheckTextField])
        
    }
    
    private func makeConstraints() {
        containerView.snp.makeConstraints { constraints in
            constraints.top.bottom.equalToSuperview()
            constraints.leading.equalToSuperview().offset(moderateScale(number: 20))
            constraints.trailing.equalToSuperview().offset(moderateScale(number: -20))
        }
        titleLabel1.snp.makeConstraints { constraints in
            constraints.top.equalToSuperview().offset(verticalScale(number: 60))
        }
        titleLabel2.snp.makeConstraints { constraints in
            constraints.top.equalTo(titleLabel1.snp.bottom)
        }
        allAgreementCheck.snp.makeConstraints { constraints in
            constraints.height.equalTo(moderateScale(number: 24))
            constraints.width.equalTo(moderateScale(number: 24))
            constraints.top.equalTo(titleLabel2.snp.bottom).offset(verticalScale(number: 25))
            constraints.leading.equalToSuperview()
        }
        allAgreementLabel.snp.makeConstraints { constraints in
            constraints.centerY.equalTo(allAgreementCheck)
            constraints.leading.equalTo(allAgreementCheck.snp.trailing).offset(moderateScale(number:16))
        }
        step1SignUpView.snp.makeConstraints { constraints in
            constraints.top.equalTo(allAgreementCheck.snp.bottom).offset(verticalScale(number: 16))
            constraints.bottom.equalTo(createAccountButton.snp.top)
            constraints.leading.trailing.equalToSuperview()
        }
        firstAgreementCheck.snp.makeConstraints { constraints in
            constraints.height.equalTo(moderateScale(number: 24))
            constraints.width.equalTo(moderateScale(number: 24))
            constraints.top.equalToSuperview()
            constraints.leading.equalToSuperview()
        }
        firstAgreementLabel.snp.makeConstraints { constraints in
            constraints.centerY.equalTo(firstAgreementCheck)
            constraints.leading.equalTo(firstAgreementCheck.snp.trailing).offset(moderateScale(number:16))
        }
        secondAgreementCheck.snp.makeConstraints { constraints in
            constraints.height.equalTo(moderateScale(number: 24))
            constraints.width.equalTo(moderateScale(number: 24))
            constraints.top.equalTo(firstAgreementCheck.snp.bottom).offset(verticalScale(number: 16))
            constraints.leading.equalToSuperview()
        }
        secondAgreementLabel.snp.makeConstraints { constraints in
            constraints.centerY.equalTo(secondAgreementCheck)
            constraints.leading.equalTo(secondAgreementCheck.snp.trailing).offset(moderateScale(number:16))
        }

        thirdAgreementCheck.snp.makeConstraints { constraints in
            constraints.height.equalTo(moderateScale(number: 24))
            constraints.width.equalTo(moderateScale(number: 24))
            constraints.top.equalTo(secondAgreementCheck.snp.bottom).offset(verticalScale(number: 16))
            constraints.leading.equalToSuperview()
        }
        thirdAgreementLabel.snp.makeConstraints { constraints in
            constraints.centerY.equalTo(thirdAgreementCheck)
            constraints.leading.equalTo(thirdAgreementCheck.snp.trailing).offset(moderateScale(number:16))
        }
        step2SignUpView.snp.makeConstraints { constraints in
            constraints.top.equalTo(allAgreementCheck.snp.bottom).offset(verticalScale(number: 25))
            constraints.bottom.equalTo(createAccountButton.snp.top)
            constraints.leading.trailing.equalToSuperview()
        }
        emailTextField.snp.makeConstraints{ constraints in
            constraints.top.leading.trailing.equalToSuperview()
            constraints.height.equalTo(moderateScale(number: 62))
        }
        passwordTextField.snp.makeConstraints{ constraints in
            constraints.top.equalTo(emailTextField.snp.bottom).offset(verticalScale(number: 16))
            constraints.leading.trailing.equalToSuperview()
            constraints.height.equalTo(moderateScale(number: 62))
        }
        passwordCheckTextField.snp.makeConstraints{ constraints in
            constraints.top.equalTo(passwordTextField.snp.bottom).offset(verticalScale(number: 16))
            constraints.leading.trailing.equalToSuperview()
            constraints.height.equalTo(moderateScale(number: 62))
        }
        createAccountButton.snp.makeConstraints { constraints in
            constraints.bottom.equalTo(containerView.snp.bottom).offset(moderateScale(number: -47))
            constraints.height.equalTo(moderateScale(number: 58))
            constraints.leading.trailing.equalToSuperview()
        }
    }
    
    private func bind() {
        viewModel.allAgreePublisher()
            .sink { [weak self] state in
                self?.allAgreementCheck.isSelected = state
                self?.step1SignUpView.isHidden = state
                self?.step2SignUpView.isHidden = !state
                self?.createAccountButton.isEnabled = state
            }
            .store(in: &cancelBag)
        
        viewModel.signUpPublisher()
            .sink { [weak self] result in
                if result == .emailRegexError {
                    self?.emailTextField.setupInvalidStatus(error: result.rawValue)
                } else if result == .passwordRegexError {
                    self?.passwordTextField.setupInvalidStatus(error: result.rawValue)
                } else if result == .notEqualPassword {
                    self?.passwordCheckTextField.setupInvalidStatus(error: result.rawValue)
                } else {
                    self?.coordinator?.login()
                }
            }
            .store(in: &cancelBag)
    }
}

extension SignUpViewController {
    @objc private func allAgreeButtonTapped(_ button: UIButton) {
        button.isSelected.toggle()
        self.firstAgreementCheck.isSelected = button.isSelected
        self.secondAgreementCheck.isSelected = button.isSelected
        self.thirdAgreementCheck.isSelected = button.isSelected
        self.viewModel.sendAgreePublisher(agreementButtonType: .allAgree, buttonState: button.isSelected)
    }
    @objc private func firstAgreeButtonTapped(_ button: UIButton) {
        button.isSelected.toggle()
        self.secondAgreementCheck.shake(count: 4, for: 1.5, withTranslation: 10)
        self.viewModel.sendAgreePublisher(agreementButtonType: .firstAgree, buttonState: button.isSelected)
    }
    @objc private func secondAgreeButtonTapped(_ button: UIButton) {
        button.isSelected.toggle()
        self.viewModel.sendAgreePublisher(agreementButtonType: .secondAgree, buttonState: button.isSelected)
    }
    @objc private func thirdAgreeButtonTapped(_ button: UIButton) {
        button.isSelected.toggle()
        self.viewModel.sendAgreePublisher(agreementButtonType: .thirdAgree, buttonState: button.isSelected)
    }
    @objc private func createAccountButtonTapped(_ button: UIButton) {
        self.viewModel.sendUserInfoPublisher(email: self.emailTextField.text ?? "", password: self.passwordTextField.text ?? "", passwordCheck: self.passwordCheckTextField.text ?? "")
//        coordinator?.login()
    }

}
