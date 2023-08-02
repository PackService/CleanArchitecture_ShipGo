//
//  UIButton+Extension.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 7/30/23.
//

import UIKit
import SnapKit

final class SelectButton: UIButton {
    override var isSelected: Bool {
        willSet { newValue == true ? changeSelectButton() : changeUnselectButton() }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        tintColor = ColorManager.secondaryColor
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func changeSelectButton() {
        tintColor = ColorManager.primaryColor
    }
    
    private func changeUnselectButton() {
        tintColor = ColorManager.secondaryColor
    }
}
