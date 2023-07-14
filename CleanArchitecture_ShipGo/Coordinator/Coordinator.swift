//
//  Coordinator.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/07/14.
//

import Foundation

protocol Coordinator: AnyObject {
    var childCoordinator: [Coordinator] { get set }
    
    func start()
}
