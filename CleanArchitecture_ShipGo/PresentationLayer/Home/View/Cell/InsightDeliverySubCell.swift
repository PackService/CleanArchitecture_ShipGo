//
//  InsightDeliverySubCell.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/10/23.
//

import UIKit
import SnapKit
import Then

final class InsightDeliverySubCell: BaseCollectionViewCell<Int> {
    
    static let reuseIdentifier = "InsightDeliverySubCell"
    
    private lazy var containerView = UIView().then({
        $0.layer.shadowOffset = CGSize(width: 1, height: 1)
        $0.layer.shadowColor = ColorManager.black?.cgColor
        $0.backgroundColor = ColorManager.background
        $0.layer.cornerRadius = 10
        $0.layer.shadowOpacity = 0.05
        $0.layer.shadowRadius = 20
    })
    
    private lazy var titleLabel = UILabel().then({
        $0.text = "일일 최다 배송 개수"
        $0.font = UIFont.setFont(size: 13)
    })
    
    private lazy var contentLabel = UILabel().then({
        $0.text = "맑은 생수 2L"
        $0.font = UIFont.setFont(size: 20, family: .SemiBold)
    })
    
    private lazy var newImageView = UIImageView().then({
        $0.image = UIImage(systemName: "circle.fill")
    })
    
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

extension InsightDeliverySubCell {
    private func addViews() {
        self.contentView.addSubview(containerView)
        [titleLabel,
         contentLabel,
         newImageView
        ].forEach { containerView.addSubview($0) }
    }
    
    private func makeConstraints() {
        containerView.snp.makeConstraints { constraints in
            constraints.top.bottom.leading.equalToSuperview().offset(moderateScale(number: 2))
            constraints.trailing.equalToSuperview().offset(moderateScale(number: -2))
        }
        titleLabel.snp.makeConstraints { constraints in
            constraints.top.equalToSuperview().offset(moderateScale(number: 16))
            constraints.leading.equalToSuperview().offset(moderateScale(number: 20))
        }
        contentLabel.snp.makeConstraints { constraints in
            constraints.top.equalTo(titleLabel.snp.bottom).offset(moderateScale(number: 8))
            constraints.leading.equalTo(titleLabel.snp.leading)
        }
        newImageView.snp.makeConstraints { constraints in
            constraints.centerY.equalTo(titleLabel.snp.centerY)
            constraints.leading.equalTo(titleLabel.snp.trailing).offset(moderateScale(number: 4))
        }
    }
}

