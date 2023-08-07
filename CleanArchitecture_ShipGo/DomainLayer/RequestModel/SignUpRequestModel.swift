//
//  EmailSignUpRequestModel.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/08/03.
//

import Foundation

struct SignUpRequestModel {
    var email: String = ""
    var password: String = ""
    
    init(email: String = "", password: String = ""){
        self.email = email
        self.password = password
    }
}
