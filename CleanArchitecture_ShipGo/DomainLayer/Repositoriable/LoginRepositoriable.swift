//
//  LoginRepositoriable.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/07/12.
//

import Foundation
import Combine

protocol LoginRepositoriable {
    func login(email: String, password: String) -> AnyPublisher<Result<Void, Error>, Never>
}
