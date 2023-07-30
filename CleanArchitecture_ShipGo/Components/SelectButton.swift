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
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func changeSelectButton() {
        tintColor = UIColor(red: 27/255, green: 31/255, blue: 47/255, alpha: 1)
    }
    
    private func changeUnselectButton() {
        setImage(UIImage(systemName: "arrowtriangle.down.fill"), for: .normal)
        tintColor = UIColor(red: 150/255, green: 156/255, blue: 184/255, alpha: 1)
    }
}
