//
//  RemoteDataSourceImpl.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/07/12.
//

import Foundation
import Combine
import Alamofire

class RemoteDataSourceImpl: RemoteDataSourceable {
    func signUp(email: String, password: String) -> AnyPublisher<Result<Void, Error>, Never> {
        Future<Result<Void, Error>,Never> { [weak self] promise in
            
        }.eraseToAnyPublisher()
    }
    
    
}
