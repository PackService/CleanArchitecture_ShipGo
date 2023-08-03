//
//  TempComponent.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/07/12.
//

import UIKit
import SnapKit

class CompleteButton: UIButton {
    override var isEnabled: Bool {
        willSet { newValue == true ? (self.backgroundColor = ColorManager.primaryColor) : (self.backgroundColor = ColorManager.defaultForegroundDisabled) }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = ColorManager.primaryColor
        self.layer.cornerRadius = 30
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
