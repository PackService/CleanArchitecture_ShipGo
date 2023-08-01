//
//  ScreenUtil.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/07/13.
//

import UIKit

let baseGuideWidth: CGFloat = 375.0
let baseGuideHeight: CGFloat = 667.0

@inline(__always)
func horizontalScale(number: CGFloat) -> CGFloat {
    UIScreen.main.bounds.width / baseGuideWidth * number
}

@inline(__always)
func verticalScale(number: CGFloat) -> CGFloat {
    let number = UIScreen.main.bounds.height / baseGuideHeight * number
    if UIScreen.main.bounds.width / UIScreen.main.bounds.height <= 0.75 {
        return number * 1.2
    }
    return UIScreen.main.bounds.height / baseGuideHeight * number
}

@inline(__always)
func moderateScale(number: CGFloat, factor: CGFloat = 0.5) -> CGFloat {
    number + (horizontalScale(number: number ) - number) * factor
}
