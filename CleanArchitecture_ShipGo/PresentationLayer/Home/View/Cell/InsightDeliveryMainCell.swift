//
//  InsightDeliveryMainCell.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/10/23.
//

import UIKit
import SnapKit
import Then

final class InsightDeliveryMainCell: BaseCollectionViewCell<Int> {
    
    static let reuseIdentifier = "InsightDeliveryMainCell"
    
    private lazy var containerView = UIView().then({
        $0.backgroundColor = ColorManager.secondaryColor
        $0.layer.cornerRadius = 10
    })
    
    private lazy var titleLabel = UILabel().then({
        $0.text = "최근 조회한 상품"
        $0.font = UIFont.setFont(size: 13, family: .Medium)
    })
    
    private lazy var contentLabel = UILabel().then({
        $0.text = "맑은 생수 2L"
        $0.font = UIFont.setFont(size: 20, family: .SemiBold)
    })
    
    private lazy var detailButton = UIButton().then({
        $0.setImage(UIImage(systemName: "arrowshape.right.fill"), for: .normal)
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

extension InsightDeliveryMainCell {
    private func addViews() {
        self.contentView.addSubview(containerView)
        [titleLabel,
         contentLabel,
         detailButton
        ].forEach { containerView.addSubview($0) }
    }
    
    private func makeConstraints() {
        containerView.snp.makeConstraints { constraints in
            constraints.top.bottom.equalToSuperview()
            constraints.leading.trailing.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { constraints in
            constraints.top.equalToSuperview().offset(moderateScale(number: 16))
            constraints.leading.equalToSuperview().offset(moderateScale(number: 20))
        }
        contentLabel.snp.makeConstraints { constraints in
            constraints.top.equalTo(titleLabel.snp.bottom).offset(moderateScale(number: 8))
            constraints.leading.equalTo(titleLabel.snp.leading)
        }
        detailButton.snp.makeConstraints { constraints in
            constraints.centerY.equalTo(titleLabel.snp.centerY)
            constraints.width.height.equalTo(moderateScale(number: 10))
            constraints.trailing.equalToSuperview().offset(moderateScale(number: -16))
        }
    }
}

