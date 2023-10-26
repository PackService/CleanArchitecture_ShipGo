//
//  CompanyLogoCell.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/10/25.
//

import UIKit
import SnapKit
import Then

final class CompanyLogoCell: BaseCollectionViewCell<Int> {
    
    static let reuseIdentifier = "CompanyLogoCell"
    
    private lazy var containerView = UIView().then({
        $0.backgroundColor = ColorManager.background
    })
    
    private lazy var logoImageView = UIImageView().then({
        $0.image = UIImage(systemName: "circle.fill")
    })
    
    private lazy var nameLabel = UILabel().then({
        $0.text = "CJ대한통운"
        $0.font = UIFont.setFont(size: 13)
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

extension CompanyLogoCell {
    private func addViews() {
        self.contentView.addSubview(containerView)
        containerView.addSubViews([logoImageView,
                                  nameLabel])
    }
    
    private func makeConstraints() {
        containerView.snp.makeConstraints { constraints in
            constraints.top.bottom.leading.equalToSuperview().offset(moderateScale(number: 2))
            constraints.trailing.equalToSuperview().offset(moderateScale(number: -2))
        }
        logoImageView.snp.makeConstraints { constraints in
            constraints.centerX.equalToSuperview()
            constraints.top.equalToSuperview().offset(moderateScale(number: 10))
        }
        nameLabel.snp.makeConstraints { constraints in
            constraints.centerX.equalToSuperview()
            constraints.top.equalTo(logoImageView.snp.bottom).offset(moderateScale(number: 5))
        }
    }
}

