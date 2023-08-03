//
//  AppContainer.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/07/14.
//

import Foundation
import Swinject

struct AppContainer {
    private init() {}
    
    static let shared: Container = {
        let container = Container()
        
        return container
    }()
}
