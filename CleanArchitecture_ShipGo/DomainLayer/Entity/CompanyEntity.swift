//
//  CompanyEntity.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/10/27.
//

import Foundation

//struct CompanyEntity: Entity {
//    let company: [Company]
//}

struct CompanyEntity: Entity { // MARK: - 이걸 [CompanyEntity] 이런식으로 디코딩
    let id: String
    let international: String
    let name: String
}
