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
    
    var time: Float = 0.0
    var timer: Timer?
    
    private lazy var containerView = UIView().then({
        $0.backgroundColor = .blue
    })
    
    private lazy var progressView = UIProgressView().then({
        $0.progressImage = UIImage(systemName: "circle.fill")
        $0.progressViewStyle = .default
        $0.progressTintColor = .green
        $0.trackTintColor = .lightGray
    })
    
    private lazy var firstStageImage = UIImageView().then({
        $0.image = UIImage(systemName: "circle.fill")
    })
    
    private lazy var secondStageImage = UIImageView().then({
        $0.image = UIImage(systemName: "circle.fill")
    })
    
    private lazy var thirdStageImage = UIImageView().then({
        $0.image = UIImage(systemName: "circle.fill")
    })
    
    private lazy var fourthStageImage = UIImageView().then({
        $0.image = UIImage(systemName: "circle.fill")
    })
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(setProgress), userInfo: nil, repeats: true)

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
        progressView.addSubViews([firstStageImage,
                                 secondStageImage,
                                 thirdStageImage,
                                 fourthStageImage])
    }
    
    func makeConstraints() {
        containerView.snp.makeConstraints { constraints in
            constraints.top.bottom.leading.trailing.equalToSuperview()
        }
        progressView.snp.makeConstraints { constraints in
            constraints.top.bottom.leading.trailing.equalToSuperview()
        }
        firstStageImage.snp.makeConstraints { constraints in
            constraints.centerX.equalTo(progressView.snp.leading)
            constraints.centerY.equalToSuperview()
            constraints.width.height.equalTo(moderateScale(number: 40))
        }
        fourthStageImage.snp.makeConstraints { constraints in
            constraints.centerX.equalTo(progressView.snp.trailing)
            constraints.centerY.equalToSuperview()
            constraints.width.height.equalTo(moderateScale(number: 40))
        }
    }
    
    @objc func setProgress() {
        time += 0.1
        progressView.setProgress(time, animated: true)
        if time > 0.1 {
            firstStageImage.tintColor = .green
        }
        if time > 0.33 {
            secondStageImage.tintColor = .green
        }
        if time > 0.66 {
            thirdStageImage.tintColor = .green
        }
        if time > 0.99 {
            fourthStageImage.tintColor = .green
        }
        if time >= 1 {
            timer!.invalidate()
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
