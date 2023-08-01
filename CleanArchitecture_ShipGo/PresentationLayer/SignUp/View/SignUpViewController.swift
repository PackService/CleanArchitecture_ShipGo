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
    
    private lazy var titleLabel1 = UILabel().then({
        $0.text = "계정을"
        $0.font = UIFont.setFont(size: moderateScale(number: 26), family: .Bold)
    })

    private lazy var titleLabel2 = UILabel().then({
        $0.text = "만들어주세요"
        $0.font = UIFont.setFont(size: moderateScale(number: 26), family: .Bold)
    })
    
    private lazy var zeroAgreementView = UIView()
    
    private lazy var allAgreementCheck = UIImageView().then({
        $0.image = UIImage(systemName: "circle.fill")
    })
    
    private lazy var allAgreementLabel = UILabel().then({
        $0.text = "전체 동의하기"
        $0.font = UIFont.setFont(size: moderateScale(number: 20), family: .SemiBold)
    })
    
    private lazy var firstAgreementView = UIView()
    
    private lazy var firstAgreementCheck = UIImageView().then({
        $0.image = UIImage(systemName: "circle.fill")
    })
    
    private lazy var firstAgreementLabel = UILabel().then({
        $0.text = "만 14세 이상입니다"
        $0.font = UIFont.setFont(size: moderateScale(number: 17), family: .Medium)
    })
    
    private lazy var secondAgreementView = UIView()

    private lazy var secondAgreementCheck = UIImageView().then({
        $0.image = UIImage(systemName: "circle.fill")
    })
    
    private lazy var secondAgreementLabel = UILabel().then({
        $0.text = "서비스 이용 약관"
        $0.font = UIFont.setFont(size: moderateScale(number: 17), family: .Medium)
    })
    
    private lazy var thirdAgreementView = UIView()
    
    private lazy var thirdAgreementCheck = UIImageView().then({
        $0.image = UIImage(systemName: "circle.fill")
    })
    
    private lazy var thirdAgreementLabel = UILabel().then({
        $0.text = "개인정보 수집 및 이용 동의"
        $0.font = UIFont.setFont(size: moderateScale(number: 17), family: .Medium)
    })
    
    private lazy var createAccountButton = UIButton().then({
        $0.setTitle("계정 만들기", for: .normal)
    })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        addViews()
        makeConstraints()
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
                                   thirdAgreementLabel
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
    }
}
