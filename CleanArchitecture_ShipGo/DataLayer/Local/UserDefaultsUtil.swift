//
//  UserDefaultUtil.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/08/07.
//

import UIKit

struct UserDefaultsUtil {
    static let shared = UserDefaultsUtil()
    
    private init() {}
    
    private let defaults = UserDefaults.standard
    
    enum KeysForUserDefaults: String {
        case isLogin
    }
    
    func setIsLogin(email: String) {
        defaults.set(email, forKey: KeysForUserDefaults.isLogin.rawValue)
    }
    
    func getIsLogin() -> Bool {
        if defaults.value(forKey: KeysForUserDefaults.isLogin.rawValue) as? String ?? "" == "" {
            return false
        } else {
            return true
        }
    }
}
