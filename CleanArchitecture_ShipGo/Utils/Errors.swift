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
    var statusCode: Int? = 0
    var error: String? = ""
    var message: String? = ""
    var forbiddenWords: [String]?
    
    struct Message: Decodable {
        let error: String?
        let message: String?
    }
}

struct NetworkCommonErrors {
    private init() {}
    
    static let commonErrorMessage = "something_wrong"
    static let typeMismatchError = NetworkError(statusCode: 200, message: "Something went wrong")
}

enum UserError: String, Error, CaseIterable {
    case success = ""
    case emailRegexError = "이메일 형식이 올바르지 않습니다"
    case passwordRegexError = "비밀번호를 8자 이상 입력하세요"
    case notEqualPassword = "비밀번호와 비밀번호 확인이 일치하지 않습니다"
    case existEmail = "이미 사용중인 이메일입니다"
}

