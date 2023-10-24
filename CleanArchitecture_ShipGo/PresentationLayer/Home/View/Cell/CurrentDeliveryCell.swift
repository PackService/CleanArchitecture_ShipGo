//
//  CurrentDeliveryCell.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 10/3/23.
//

import UIKit
import SnapKit
import Then

final class CurrentDeliveryCell: BaseCollectionViewCell<Int> {
    static let reuseIdentifier = "CurrentDeliveryCell"
    
    private lazy var containerView = UIView().then({
        $0.backgroundColor = .white
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(red: 243/255, green: 243/255, blue: 243/255, alpha: 1).cgColor
    })
    
    private lazy var deliveryCompanyImageView = UIImageView().then({
        $0.image = UIImage(systemName: "circle.fill")
    })
    
    private lazy var nameLabel = UILabel().then({
        $0.text = "토리든 고분자 뭐시기"
    })
    
    private lazy var numberLabel = UILabel().then({
        $0.text = "00001111000"
    })
    
    private lazy var stateLabel = UILabel().then({
        $0.text = "간선상차"
    })
    
    private lazy var progressView = CustomProgressView()
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        makeConstraints()
    }
    
    override func bind(_ model: Int) {
        super.bind(model)
        
    }
}

extension CurrentDeliveryCell {
    private func addViews() {
        self.contentView.addSubview(containerView)
        containerView.addSubViews([deliveryCompanyImageView,
                                  nameLabel,
                                  numberLabel,
                                  stateLabel,
                                  progressView])
    }
    
    private func makeConstraints() {
        containerView.snp.makeConstraints { constraints in
            constraints.top.bottom.leading.trailing.equalToSuperview()
        }
        deliveryCompanyImageView.snp.makeConstraints { constraints in
            constraints.top.equalToSuperview().offset(moderateScale(number: 24))
            constraints.leading.equalToSuperview().offset(moderateScale(number: 16))
            constraints.width.height.equalTo(moderateScale(number: 44))
        }
        nameLabel.snp.makeConstraints { constraints in
            constraints.top.equalTo(deliveryCompanyImageView.snp.top)
            constraints.leading.equalTo(deliveryCompanyImageView.snp.trailing).offset(moderateScale(number: 12))
            constraints.trailing.equalToSuperview().offset(moderateScale(number: -46))
        }
        numberLabel.snp.makeConstraints { constraints in
            constraints.top.equalTo(deliveryCompanyImageView.snp.centerY)
            constraints.leading.equalTo(deliveryCompanyImageView.snp.trailing).offset(moderateScale(number: 12))
            constraints.trailing.equalToSuperview().offset(moderateScale(number: -16))
        }
        stateLabel.snp.makeConstraints { constraints in
            constraints.top.equalTo(nameLabel.snp.bottom)
            constraints.trailing.equalToSuperview().offset(moderateScale(number: -16))
        }
        progressView.snp.makeConstraints { constraints in
            constraints.top.equalTo(numberLabel.snp.bottom)
            constraints.leading.equalToSuperview().offset(moderateScale(number: 16))
            constraints.trailing.equalToSuperview().offset(moderateScale(number: -16))
            constraints.height.equalTo(moderateScale(number: 16))
        }
    }
}
