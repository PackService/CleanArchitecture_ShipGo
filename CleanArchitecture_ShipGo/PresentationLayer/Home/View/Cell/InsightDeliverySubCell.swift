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
        $0.backgroundColor = .white
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(red: 243/255, green: 243/255, blue: 243/255, alpha: 1).cgColor
    })
    
    private lazy var titleLabel = UILabel().then({
        $0.text = "일일 최다 배송 개수"
    })
    
    private lazy var contentLabel = UILabel().then({
        $0.text = "맑은 생수 2L"
    })
    
    private lazy var detailButton = UIButton().then({
        $0.setImage(UIImage(systemName: "circle.fill"), for: .normal)
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
         detailButton
        ].forEach { containerView.addSubview($0) }
    }
    
    private func makeConstraints() {
        containerView.snp.makeConstraints { constraints in
            constraints.top.bottom.leading.trailing.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { constraints in
            constraints.top.equalToSuperview().offset(moderateScale(number: 18))
            constraints.leading.equalToSuperview().offset(moderateScale(number: 20))
        }
        contentLabel.snp.makeConstraints { constraints in
            constraints.top.equalTo(titleLabel.snp.bottom).offset(moderateScale(number: 16))
            constraints.leading.equalTo(titleLabel.snp.leading)
        }
        detailButton.snp.makeConstraints { constraints in
            constraints.centerY.equalTo(titleLabel.snp.centerY)
            constraints.trailing.equalToSuperview().offset(moderateScale(number: 16))
        }
    }
}

