//
//  UIView+Extension.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/07/19.
//

import UIKit

extension UIView {
    func addSubViews(_ views: [UIView]) {
        for view in views {
            addSubview(view)
        }
    }
}
