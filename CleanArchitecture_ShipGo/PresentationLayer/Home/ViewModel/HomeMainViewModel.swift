//
//  HomeMainViewModel.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/10/04.
//

import Foundation
import Combine

class HomeMainViewModel: BaseViewModel {
    
    private var cancelBag = Set<AnyCancellable>()
    
    override init() {
        super.init()
        bind()
    }
    
    private func bind() {
        
    }
}

extension HomeMainViewModel {
    
}
