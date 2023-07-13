//
//  Errors.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/07/13.
//

import Foundation

enum HTTPError: LocalizedError {
    case networkFailureError
    case typeMismatchError
    case noTokenError
    case tokenExpiredError
}

struct NetworkError: Error, Decodable {
    var code: Int? = 0
    var msg: String? = ""
}

struct NetworkCommonErrors {
    private init() {}
    
    static let commonErrorMessage = "something_wrong"
    static let typeMismatchError = NetworkError(code: 200, msg: "Something went wrong")
}
