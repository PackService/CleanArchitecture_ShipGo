//
//  TabBarItemType.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/08/01.
//

import Foundation

enum TabBarItemType: String, CaseIterable {
    
    case home, list, setting
    
    init?(index: Int) {
        switch index {
        case 0: self = .home
        case 1: self = .list
        case 2: self = .setting
        default: return nil
        }
    }
    
    /// TabBarPage 형을 매칭되는 Int형으로 반환
    func toInt() -> Int {
        switch self {
        case .home: return 0
        case .list: return 1
        case .setting: return 2
        }
    }
 
    /// TabBarPage 형을 매칭되는 아이콘명으로 변환
    func toIconName() -> String {
        switch self {
        case .home: return "circle"
        case .list: return "circle"
        case .setting: return "circle"
        }
    }
}
