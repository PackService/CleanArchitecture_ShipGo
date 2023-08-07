//
//  SignUpRepositoriable.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/08/03.
//

import Foundation
import Combine

protocol SignUpRepositoriable {
    func signUp(email: String, password: String) -> AnyPublisher<Result<Void, Error>, Never>
}
