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
    func shake(count : Float = 4,for duration : TimeInterval = 0.5,withTranslation translation : Float = 5) {
        
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.repeatCount = count
        animation.duration = duration/TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.values = [translation, -translation]
        layer.add(animation, forKey: "shake")
    }

}
