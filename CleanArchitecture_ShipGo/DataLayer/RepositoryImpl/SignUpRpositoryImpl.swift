//
//  SignUpRpositoryImpl.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/08/04.
//

import Foundation
import Combine

class SignUpRepositoryImpl: SignUpRepositoriable {
    private var cancelBag = Set<AnyCancellable>()
    private let remoteDataSource: RemoteDataSourceable = RemoteDataSourceImpl() as! RemoteDataSourceable
    
    func signUp(email: String, password: String) -> AnyPublisher<Result<Void, Error>, Never> {
        remoteDataSource.signUp(email: email, password: password)
    }
}
