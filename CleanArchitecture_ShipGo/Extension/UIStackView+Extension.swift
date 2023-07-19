//
//  UIStackView+Extension.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/07/19.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        for view in views {
            addArrangedSubview(view)
        }
    }
}
