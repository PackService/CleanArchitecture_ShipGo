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
    
    weak var coordinator: Coordinator?
    
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
    
    private lazy var allAgreementCheck = UIImageView().then({
        $0.image = UIImage(systemName: "circle.fill")?.withRenderingMode(.alwaysTemplate)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(allAgreeButtonTapped(_:))) // UIImageView 클릭 제스쳐
        $0.addGestureRecognizer(tapGesture)
        $0.isUserInteractionEnabled = true
    })
    
    private lazy var allAgreementLabel = UILabel().then({
        $0.text = "전체 동의하기"
        $0.font = UIFont.setFont(size: moderateScale(number: 20), family: .SemiBold)
    })
    
    private lazy var firstAgreementCheck = UIImageView().then({
        $0.image = UIImage(systemName: "circle.fill")?.withRenderingMode(.alwaysTemplate)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(firstAgreeButtonTapped(_:))) // UIImageView 클릭 제스쳐
        $0.addGestureRecognizer(tapGesture)
        $0.isUserInteractionEnabled = true
    })
    
    private lazy var firstAgreementLabel = UILabel().then({
        $0.text = "만 14세 이상입니다"
        $0.font = UIFont.setFont(size: moderateScale(number: 17), family: .Medium)
    })

    private lazy var secondAgreementCheck = UIImageView().then({
        $0.image = UIImage(systemName: "circle.fill")
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(secondAgreeButtonTapped(_:))) // UIImageView 클릭 제스쳐
        $0.addGestureRecognizer(tapGesture)
        $0.isUserInteractionEnabled = true
    })
    
    private lazy var secondAgreementLabel = UILabel().then({
        $0.text = "서비스 이용 약관"
        $0.font = UIFont.setFont(size: moderateScale(number: 17), family: .Medium)
    })
    
    private lazy var thirdAgreementCheck = UIImageView().then({
        $0.image = UIImage(systemName: "circle.fill")
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(thirdAgreeButtonTapped(_:))) // UIImageView 클릭 제스쳐
        $0.addGestureRecognizer(tapGesture)
        $0.isUserInteractionEnabled = true
    })
    
    private lazy var thirdAgreementLabel = UILabel().then({
        $0.text = "개인정보 수집 및 이용 동의"
        $0.font = UIFont.setFont(size: moderateScale(number: 17), family: .Medium)
    })
    
    private lazy var createAccountButton = CompleteButton().then({
        $0.setTitle("계정 만들기", for: .normal)
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
                                   firstAgreementCheck,
                                   firstAgreementLabel,
                                   secondAgreementCheck,
                                   secondAgreementLabel,
                                   thirdAgreementCheck,
                                   thirdAgreementLabel,
                                   createAccountButton
                                  ])
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
        firstAgreementCheck.snp.makeConstraints { constraints in
            constraints.height.equalTo(moderateScale(number: 24))
            constraints.width.equalTo(moderateScale(number: 24))
            constraints.top.equalTo(allAgreementCheck.snp.bottom).offset(verticalScale(number: 16))
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
        createAccountButton.snp.makeConstraints { constraints in
            constraints.bottom.equalTo(containerView.snp.bottom).offset(moderateScale(number: -47))
            constraints.height.equalTo(moderateScale(number: 58))
            constraints.leading.trailing.equalToSuperview()                                                 
        }
    }
    
    private func bind() {
//        viewModel.getAllAgreePublisher()
//            .sink { [weak self] state in
//                state ? (self?.createAccountButton.backgroundColor = .red) : (self?.createAccountButton.backgroundColor = .green)
//            }
//
        viewModel.firstAgreePublisher()
            .sink { [weak self] state in
                self?.setAgreeButtonColor(self!.firstAgreementCheck, state)
            }
            .store(in: &cancelBag)
        
        viewModel.secondAgreePublisher()
            .sink { [weak self] state in
                self?.setAgreeButtonColor(self!.secondAgreementCheck, state)
            }
            .store(in: &cancelBag)
    }
}

extension SignUpViewController {
    @objc private func allAgreeButtonTapped(_ gesture: UITapGestureRecognizer) {
        print("모든 동의 버튼 클릭!")
        self.viewModel.sendAgreePublisher(agreementButtonType: .allAgree)
    }
    @objc private func firstAgreeButtonTapped(_ gesture: UITapGestureRecognizer) {
        print("첫번째 동의 버튼 클릭!")
        self.viewModel.sendAgreePublisher(agreementButtonType: .firstAgree)
    }
    @objc private func secondAgreeButtonTapped(_ gesture: UITapGestureRecognizer) {
        print("두번째 동의 버튼 클릭!")
        self.viewModel.sendAgreePublisher(agreementButtonType: .secondAgree)
    }
    @objc private func thirdAgreeButtonTapped(_ gesture: UITapGestureRecognizer) {
        print("세번째 동의 버튼 클릭!")
        self.viewModel.sendAgreePublisher(agreementButtonType: .thirdAgree)
    }
    
    private func setAgreeButtonColor(_ agreeButton: UIImageView, _ state: Bool) {
        if state {
            agreeButton.image = UIImage(systemName: "checkmark.circle.fill")
            agreeButton.tintColor = ColorManager.secondaryColor
        } else {
            agreeButton.image = UIImage(systemName: "checkmark.circle.fill")
            agreeButton.tintColor = ColorManager.primaryColor
        }
    }
}

class agreeImageButton: UIImageView {
    
}


