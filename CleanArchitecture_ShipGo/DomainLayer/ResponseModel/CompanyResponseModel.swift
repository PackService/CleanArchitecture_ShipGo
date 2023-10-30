//
//  CompanyResponseModel.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/10/27.
//

import Foundation

struct CompanyResponseModel: Hashable {
    let id: String
    let international: String
    let name: String
    
    init() {
        self.id = ""
        self.international = ""
        self.name = ""
    }
    
    init(id: String, international: String, name: String) {
        self.id = id
        self.international = international
        self.name = name
    }
}
