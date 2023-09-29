//
//  LoginRequestModel.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/07/12.
//

import Foundation

struct LoginRequestModel {
    var email: String = ""
    var password: String = ""
    
    init(email: String = "", password: String = ""){
        self.email = email
        self.password = password
    }
}
