//
//  Error+Extension.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/08/04.
//

import Foundation

extension Error {
    func getErrorCode() -> Int? {
        if let networkError = self as? NetworkError, let statusCode = networkError.statusCode {
            return statusCode
        }
        return nil
    }
}
