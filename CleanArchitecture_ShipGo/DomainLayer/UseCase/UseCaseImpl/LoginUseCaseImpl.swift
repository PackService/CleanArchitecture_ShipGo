//
//  LoginUseCaseImpl.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/07/12.
//

import Foundation
import Combine

final class LoginUseCaseImpl: LoginUseCaseable {
    
    private let repository: SignUpRepositoriable = SignUpRepositoryImpl()
    private let mapper = SignUpMapper()
    private let errorSubject = CurrentValueSubject<Error, Never>(NetworkError())
    
    func signUp(requestModel: SignUpRequestModel) -> AnyPublisher<Void, Never> {
        repository.signUp(email: requestModel.email,
                          password: requestModel.password)
        .compactMap { [weak self] result -> Void? in
            guard let selfRef = self else { return nil }
            switch result {
            case .success(let entity):
                return selfRef.mapper.entityToBasicResponseModel(entity: entity)
            case .failure(let error):
                print("usecaseimpl error :\(error)")
                selfRef.errorSubject.send(error)
                return nil
            }
        }
        .eraseToAnyPublisher()
    }
    
    func getErrorSubject() -> AnyPublisher<Error, Never> {
        return errorSubject.eraseToAnyPublisher()
    }
}

// 팝업창부터 ㄱ
