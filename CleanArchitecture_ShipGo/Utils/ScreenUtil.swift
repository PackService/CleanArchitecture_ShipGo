//
//  ScreenUtil.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/07/13.
//

import UIKit

let baseGuideWidth: CGFloat = 375.0

@inline(__always)
func moderateScale(number: CGFloat, factor: CGFloat = 0.5) -> CGFloat {
    number + (horizontalScale(number: number ) - number) * factor
}

@inline(__always)
func horizontalScale(number: CGFloat) -> CGFloat {
    UIScreen.main.bounds.width / baseGuideWidth * number
}
