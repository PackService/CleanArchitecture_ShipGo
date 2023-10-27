//
//  CompanyRequestModel.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/10/27.
//

import Foundation

struct CompanyRequestModel {
    var invoice: String = ""
    
    init(invoice: String = ""){
        self.invoice = invoice
    }
}
