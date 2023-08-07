//
//  SignUpUseCaseable.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/08/03.
//

import Foundation
import Combine

protocol SignUpUseCaseable {
    func signUp(requestModel: SignUpRequestModel) -> AnyPublisher<Void, Never>
    func getErrorSubject() -> AnyPublisher<Error, Never>
}
