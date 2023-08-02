//
//  RemoteShowModelItem.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/08/02.
//

import Foundation

struct ShowModel: Identifiable {
    let id = UUID().uuidString
    let isComplete: Bool
    let company: String
    let invoice: String
    let name: String
    let currentStep: Double
    let itemWhere: String
    let time: String
}

enum TrackingStatus: Int {
    case start = 0
    case move
    case deliver
    case arrived
    
    var status: String {
        switch self {
        case .start:
            return "입고"
        case .move:
            return "이동중"
        case .deliver:
            return "배송중"
        case .arrived:
            return "배송완료"
        }
    }
}
