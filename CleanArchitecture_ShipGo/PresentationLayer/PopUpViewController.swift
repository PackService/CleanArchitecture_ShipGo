//
//  PopUpViewController.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/08/07.
//

import UIKit
import SnapKit
import Then

final class PopUpViewController: UIViewController {
    private var titleText: String?
    private var messageText: String?
    private var contentView: UIView?
    
    private let containerView = UIView().then({
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
    })
    private lazy var titleLabel = UILabel().then({
        $0.text = titleText
        $0.font = UIFont.setFont(size: 20, family: .Bold)
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.textColor = .black
    })
    
    private lazy var messageLabel = UILabel().then({
        $0.text = messageText
        $0.font = UIFont.setFont(size: 17, family: .Regular)
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.textColor = .black
    })
    
    private lazy var confirmButton = UIButton().then({
        $0.setTitle("확인", for: .normal)
        $0.layer.cornerRadius = 10
        $0.backgroundColor = ColorManager.primaryColor
        $0.addTarget(self, action: #selector(confirmButtonTapped(_:)), for: .touchUpInside)
    })
    
    convenience init(titleText: String? = nil,
                     messageText: String? = nil) {
        self.init()
        
        self.titleText = titleText
        self.messageText = messageText
        modalPresentationStyle = .overFullScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        makeConstraints()
    }
    
    private func addViews() {
        view.addSubview(containerView)
        view.backgroundColor = .black.withAlphaComponent(0.3)
        containerView.addSubViews([titleLabel,
                                   messageLabel,
                                   confirmButton])
    }
    
    private func makeConstraints() {
        containerView.snp.makeConstraints { constraints in
            constraints.centerX.equalToSuperview()
            constraints.centerY.equalToSuperview()
            constraints.height.equalTo(moderateScale(number: 150))
            constraints.trailing.equalToSuperview().offset(moderateScale(number: -20))
            constraints.leading.equalToSuperview().offset(moderateScale(number: 20))
        }
        titleLabel.snp.makeConstraints { constraints in
            constraints.top.equalToSuperview().offset(moderateScale(number: 10))
            constraints.centerX.equalToSuperview()
        }
        messageLabel.snp.makeConstraints { constraints in
            constraints.top.equalTo(titleLabel.snp.bottom).offset(moderateScale(number: 10))
            constraints.centerX.equalToSuperview()
        }
        confirmButton.snp.makeConstraints { constraints in
            constraints.height.equalTo(moderateScale(number: 52))
            constraints.centerX.equalToSuperview()
            constraints.width.equalTo(moderateScale(number: 150))
            constraints.bottom.equalToSuperview().offset(moderateScale(number: -10))
        }
    }
}

extension PopUpViewController {
    @objc func confirmButtonTapped(_ button: UIButton) {
        self.dismiss(animated: false)
    }
}
