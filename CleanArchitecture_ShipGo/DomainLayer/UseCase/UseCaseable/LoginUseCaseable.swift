//
//  LoginUseCaseable.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/07/12.
//

import Foundation
import Combine

protocol LoginUseCaseable {
    func login(requestModel: LoginRequestModel) -> AnyPublisher<Void, Never>
    func getErrorSubject() -> AnyPublisher<Error, Never>
}
