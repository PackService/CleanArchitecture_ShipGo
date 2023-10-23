//
//  CustomProgressView.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/10/23.
//

import UIKit
import SnapKit
import Then

class CustomProgressView: UIView {
    
    private lazy var containerView = UIView().then({
        $0.backgroundColor = .blue
    })
    
    private lazy var progressView = UIProgressView().then({
        $0.progressViewStyle = .default
        $0.progressTintColor = .green
        $0.trackTintColor = .lightGray
        $0.progress = 0.2
    })
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension CustomProgressView {
    
    func addViews() {
        addSubview(containerView)
        containerView.addSubview(progressView)
    }
    
    func makeConstraints() {
        containerView.snp.makeConstraints { constraints in
            constraints.top.bottom.leading.trailing.equalToSuperview()
        }
        progressView.snp.makeConstraints { constraints in
            constraints.top.bottom.leading.trailing.equalToSuperview()
        }
    }
}

//private func addViews() {
//    addSubview(containerView)
//    containerView.addSubViews([titleLabel,
//                              addButton])
//}
//
//private func makeConstraints() {
//    containerView.snp.makeConstraints { constraints in
//        constraints.top.bottom.leading.trailing.equalToSuperview()
//    }
//    titleLabel.snp.makeConstraints { constraints in
//        constraints.leading.equalToSuperview().offset(moderateScale(number: 20))
//        constraints.centerY.equalToSuperview()
//    }
//    addButton.snp.makeConstraints { constraints in
//        constraints.trailing.equalToSuperview().offset(moderateScale(number: -20))
//        constraints.centerY.equalToSuperview()
//    }
//}
