//
//  CurrentDeliveryFooterView.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/10/04.
//

import UIKit
import Combine
import SnapKit
import Then

final class CurrentDeliveryFooterView: UICollectionReusableView {
    
    static let reuseIdentifier = "CurrentDeliveryFooterView"
    static let supplementaryViewOfKind = "CurrentDeliveryFooterViewKind"
   
    private lazy var bannerPageControl = UIPageControl().then({
        $0.currentPage = 0
        $0.numberOfPages = 2
        $0.currentPageIndicatorTintColor = .purple
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

extension CurrentDeliveryFooterView {
    
    private func addViews() {
        self.addSubview(bannerPageControl)
    }
    
    private func makeConstraints() {
        bannerPageControl.snp.makeConstraints { constraints in
            constraints.top.bottom.leading.trailing.equalToSuperview()
        }
    }
}
