//
//  RemoteDataSourceImpl.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/07/12.
//

import Foundation
import Combine
import Alamofire
import FirebaseAuth

class RemoteDataSourceImpl: RemoteDataSourceable {
    
//    private let remoteSignUpMapper = remoteSignUpMapper()
    
    func signUp(email: String, password: String) -> AnyPublisher<Result<Void, Error>, Never> {
        Future<Result<Void, Error>, Never> { [weak self] promise in
            guard let selfRef = self else { return }
            print(email)
            print(password)
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if let error = error {
                    promise(.success(.failure(error)))
                    print(error)
                } else {
//                    promise(.success(.success(selfRef.remoteSignUpMapper.remoteItemToBasicEntity(remoteItem: ()))))
                    UserDefaultsUtil.shared.setIsLogin(email: email)
                    promise(.success(.success(print("성공"))))
                    
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func login(email: String, password: String) -> AnyPublisher<Result<Void, Error>, Never> {
        Future<Result<Void, Error>, Never> { [weak self] promise in
            print("login Email: \(email)")
            print("login Password: \(password)")
            
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                if let error = error {
                    promise(.success(.failure(error)))
                    print("remoteImpl login error :\(error)")
                } else {
                    promise(.success(.success(print("성공"))))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
