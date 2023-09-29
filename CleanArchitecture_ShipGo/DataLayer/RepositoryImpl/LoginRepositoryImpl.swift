//
//  LoginRepositoryImpl.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/07/12.
//

import Foundation
import Combine

class LoginRepositoryImpl: LoginRepositoriable {
    private var cancelBag = Set<AnyCancellable>()
    private let remoteDataSource: RemoteDataSourceable = RemoteDataSourceImpl() as! RemoteDataSourceable
    
    func login(email: String, password: String) -> AnyPublisher<Result<Void, Error>, Never> {
        remoteDataSource.login(email: email, password: password)
    }
}
