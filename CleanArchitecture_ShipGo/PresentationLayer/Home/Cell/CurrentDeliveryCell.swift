//
//  CurrentDeliveryCell.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 10/3/23.
//

import UIKit
import SnapKit
import Then

final class CurrentDeliveryCell: BaseCollectionViewCell<AccountResponseModel.ItemModel> {
    static let reuseIdentifier = "TransactionCell"
    
    private lazy var containerView = UIView().then({
        $0.backgroundColor = .white
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(red: 243/255, green: 243/255, blue: 243/255, alpha: 1).cgColor
    })
    
    private lazy var summaryLabel = UILabel().then({
        $0.text = "International Transfer"
        $0.textColor = .black
        $0.font = UIFont(name: "Pretendard-Medium", size: 14)
    })
    
    private lazy var dateLabel = UILabel().then({
        $0.text = "07.03"
        $0.textColor = .black
        $0.font = UIFont(name: "Pretendard-Medium", size: 12)
    })
    
    private lazy var typeLabel = UILabel().then({
        $0.text = "Deposit"
        $0.textColor = .black
        $0.font = UIFont(name: "Pretendard-Medium", size: 12)
    })
    
    private lazy var moneyLabel = UILabel().then({
        $0.text = "$123.23"
        $0.textColor = .black
        $0.font = UIFont(name: "Pretendard-Bold", size: 16)
    })
    
    private lazy var stateLabel = UILabel().then({
        $0.text = "Approved"
        $0.textColor = .black
        $0.font = UIFont(name: "Pretendard-Regular", size: 12)
    })
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        makeConstraints()
    }
    
    override func bind(_ model: AccountResponseModel.ItemModel) {
        super.bind(model)
        summaryLabel.text = model.history.description
        dateLabel.text = model.history.date
        typeLabel.text = model.history.type
        moneyLabel.text = model.history.amount
        stateLabel.text = model.history.status
    }
}

extension CurrentDeliveryCell {
    private func addViews() {
        self.contentView.addSubview(containerView)
        [summaryLabel,
         dateLabel,
         typeLabel,
         moneyLabel,
         stateLabel
        ].forEach { containerView.addSubview($0) }
    }
    
    private func makeConstraints() {
        containerView.snp.makeConstraints { constraints in
            constraints.top.bottom.leading.trailing.equalToSuperview()
        }
        summaryLabel.snp.makeConstraints { constraints in
            constraints.top.equalToSuperview().offset(moderateScale(number: 18))
            constraints.leading.equalToSuperview().offset(moderateScale(number: 20))
        }
        dateLabel.snp.makeConstraints { constraints in
            constraints.top.equalTo(summaryLabel.snp.bottom).offset(moderateScale(number: 6))
            constraints.leading.equalTo(summaryLabel.snp.leading)
        }
        typeLabel.snp.makeConstraints { constraints in
            constraints.top.equalTo(dateLabel.snp.top)
            constraints.leading.equalTo(dateLabel.snp.trailing).offset(moderateScale(number: 10))
        }
        moneyLabel.snp.makeConstraints { constraints in
            constraints.top.equalToSuperview().offset(moderateScale(number: 19))
            constraints.trailing.equalToSuperview().offset(moderateScale(number: -20))
        }
        stateLabel.snp.makeConstraints { constraints in
            constraints.top.equalTo(moneyLabel.snp.bottom).offset(moderateScale(number: 6))
            constraints.trailing.equalTo(moneyLabel.snp.trailing)
        }
    }
}
