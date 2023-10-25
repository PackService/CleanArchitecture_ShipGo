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
    
    private lazy var containerView = UIView()
    
    private lazy var progressView = UIProgressView().then({
        $0.progressImage = UIImage(systemName: "circle.fill")
        $0.progressViewStyle = .default
        $0.progressTintColor = ColorManager.primaryColor
        $0.trackTintColor = ColorManager.secondaryColor
    })
    
    private lazy var stageStackView = UIStackView().then({
        $0.axis = .horizontal
        $0.alignment = .center
        $0.distribution = .equalSpacing
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
        containerView.addSubViews([progressView,
                                   stageStackView])
        stageStackView.addArrangedSubviews([firstStageImage,
                                    secondStageImage,
                                    thirdStageImage,
                                    fourthStageImage])
    }
    
    func makeConstraints() {
        containerView.snp.makeConstraints { constraints in
            constraints.top.bottom.leading.trailing.equalToSuperview()
        }
        progressView.snp.makeConstraints { constraints in
            constraints.centerY.equalToSuperview()
            constraints.centerX.equalToSuperview()
            constraints.width.equalToSuperview()
        }
        stageStackView.snp.makeConstraints { constraints in
            constraints.top.bottom.leading.trailing.equalToSuperview()
            constraints.centerY.equalToSuperview()
        }
        firstStageImage.snp.makeConstraints { constraints in
            constraints.width.height.equalTo(moderateScale(number: 32))
        }
        secondStageImage.snp.makeConstraints { constraints in
            constraints.width.height.equalTo(moderateScale(number: 32))
        }
        thirdStageImage.snp.makeConstraints { constraints in
            constraints.width.height.equalTo(moderateScale(number: 32))
        }
        fourthStageImage.snp.makeConstraints { constraints in
            constraints.width.height.equalTo(moderateScale(number: 32))
        }
    }
    
    @objc func setProgress() {
        time += 0.1
        progressView.setProgress(time, animated: true)
        if time > 0.1 {
            firstStageImage.tintColor = ColorManager.primaryColor
        }
        if time > 0.33 {
            secondStageImage.tintColor = ColorManager.primaryColor
        }
        if time > 0.66 {
            thirdStageImage.tintColor = ColorManager.primaryColor
        }
        if time > 0.99 {
            fourthStageImage.tintColor = ColorManager.primaryColor
        }
        if time >= 1 {
            timer!.invalidate()
        }
    }
}
