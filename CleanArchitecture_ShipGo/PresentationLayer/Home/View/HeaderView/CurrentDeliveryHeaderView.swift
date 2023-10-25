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
    static let reuseIdentifier = "CurrentDeliveryHeaderView"
    static let supplementaryViewOfKind = "CurrentDeliveryHeaderViewKind"

    private lazy var containerView = UIView().then({
        $0.backgroundColor = ColorManager.background
    })
    
    private lazy var titleLabel = UILabel().then({
        $0.text = "지금 배송중"
        $0.font = UIFont.setFont(size: moderateScale(number: 26), family: .Bold)
    })
    
    private lazy var addButton = UIButton().then({
        $0.setImage(UIImage(systemName: "circle.fill"), for: .normal)
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
        containerView.addSubViews([titleLabel,
                                  addButton])
    }
    
    private func makeConstraints() {
        containerView.snp.makeConstraints { constraints in
            constraints.top.bottom.leading.trailing.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { constraints in
            constraints.leading.equalToSuperview()
            constraints.centerY.equalToSuperview()
        }
        addButton.snp.makeConstraints { constraints in
            constraints.trailing.equalToSuperview()
            constraints.centerY.equalToSuperview()
        }
    }
    
//    @objc func registerTrackNumberTapped(_ button: UIButton) { // 탭 바 화면으로 이동하는 것, 해당 로직 로그인 성공 시 되도록 수정
//        let vc = RegisterTrackViewController()
//    }
}