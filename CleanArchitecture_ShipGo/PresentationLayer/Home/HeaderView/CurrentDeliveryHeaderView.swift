//
//  CurrentDeliveryHeaderView.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 10/3/23.
//

import UIKit
import SnapKit
import Then

final class CurrentDeliveryHeaderView: UICollectionReusableView {
    static let reuseIdentifier = "AccountHeaderView"
    static let supplementaryViewOfKind = "AccountHeaderViewKind"

    private lazy var containerView = UIView().then({
        $0.backgroundColor = .white
    })
    
    private lazy var logoImageView = UILabel().then({
        $0.text = "ConaPay"
    })
    
    private lazy var QRCodeButton = UIButton().then({
        $0.setImage(UIImage(systemName: "qrcode.viewfinder"), for: .normal)
        $0.tintColor = UIColor(red: 60/255, green: 64/255, blue: 82/255, alpha: 1)
    })
    
    private lazy var menuButton = UIButton().then({
        $0.setImage(UIImage(systemName: "line.3.horizontal"), for: .normal)
        $0.tintColor = UIColor(red: 60/255, green: 64/255, blue: 82/255, alpha: 1)
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

extension CurrentDeliveryHeaderView {
    private func addViews() {
        addSubview(containerView)
        containerView.addSubview(logoImageView)
        containerView.addSubview(QRCodeButton)
        containerView.addSubview(menuButton)
    }
    
    private func makeConstraints() {
        containerView.snp.makeConstraints { constraints in
            constraints.edges.equalToSuperview()
        }
        logoImageView.snp.makeConstraints { constraints in
            constraints.leading.equalToSuperview().offset(moderateScale(number: 20))
            constraints.centerY.equalToSuperview()
        }
        QRCodeButton.snp.makeConstraints { constraints in
            constraints.trailing.equalTo(menuButton.snp.leading).offset(moderateScale(number: -20))
            constraints.centerY.equalToSuperview()
        }
        menuButton.snp.makeConstraints { constraints in
            constraints.trailing.equalToSuperview().offset(moderateScale(number: -23))
            constraints.centerY.equalToSuperview()
        }
    }
}
