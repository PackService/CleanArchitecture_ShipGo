//
//  SignUpUseCaseable.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/08/03.
//

import Foundation
import Combine

protocol SignUpUseCaseable {
//    func snsSignUp(requestModel: SNSSignUpRequestModel) -> AnyPublisher<Void, Never>
    func signUp(requestModel: EmailSignUpRequestModel) -> AnyPublisher<Void, Never>
    func getErrorSubject() -> AnyPublisher<Error, Never>
}
