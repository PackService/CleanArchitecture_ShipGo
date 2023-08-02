//
//  RemoteRecommendModel.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/08/02.
//

import Foundation

struct RecommendModel: Codable {
    let recommend: [Recommend]
    
    enum CodingKeys: String, CodingKey {
        case recommend = "Recommend"
    }
}

struct Recommend: Hashable, Identifiable, Codable {
    let id: String
    let international: String?
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id = "Code"
        case international = "International"
        case name = "Name"
    }
}
