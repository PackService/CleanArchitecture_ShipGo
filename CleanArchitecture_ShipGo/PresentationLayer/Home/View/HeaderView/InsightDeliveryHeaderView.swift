//
//  InsightDeliveryHeaderView.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 10/3/23.
//

import UIKit
import SnapKit
import Then

final class InsightDeliveryHeaderView: UICollectionReusableView {
    static let reuseIdentifier = "InsightDeliveryHeaderView"
    static let supplementaryViewOfKind = "InsightDeliveryHeaderViewKind"

    private lazy var containerView = UIView().then({
        $0.backgroundColor = .white
    })
    
    private lazy var titleLabel = UILabel().then({
        $0.text = "인사이트"
        $0.font = UIFont.setFont(size: moderateScale(number: 26), family: .Bold)
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

extension InsightDeliveryHeaderView {
    private func addViews() {
        addSubview(containerView)
        containerView.addSubview(titleLabel)
    }
    
    private func makeConstraints() {
        containerView.snp.makeConstraints { constraints in
            constraints.edges.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { constraints in
            constraints.leading.equalToSuperview().offset(moderateScale(number: 20))
            constraints.centerY.equalToSuperview()
        }
    }
}
