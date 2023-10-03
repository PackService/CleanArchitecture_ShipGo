//
//  BaseCollectionViewCell.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 10/3/23.
//

import UIKit

class BaseCollectionViewCell<M>: UICollectionViewCell {
    var model: M? {
        didSet {
            if let model = model {
                bind(model)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ model: M) {}
}

