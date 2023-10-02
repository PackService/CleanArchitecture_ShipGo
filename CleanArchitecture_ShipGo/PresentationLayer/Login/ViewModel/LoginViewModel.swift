//
//  LoginViewModel.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/07/12.
//

import Foundation
import Combine

// MARK: - 이메일 패스워드가 db에 존재하는지 안하는지 체크만 해주면 되네
class LoginViewModel: BaseViewModel {
    
    private var cancelBag = Set<AnyCancellable>()
    private let useCase: LoginUseCaseable = LoginUseCaseImpl() // 나중에 의존성 주입으로 변경 필요
    private let shouldLogin = PassthroughSubject<(String, String), Never>()
    private var loginValidation = PassthroughSubject<UserError, Never>()
    
    override init() {
        super.init()
        bind()
    }
    
    private func bind() {
        useCase.getErrorSubject()
            .sink(receiveValue: { [weak self] error in
                print("loginviewmodel error: \(error)")
                self?.loginValidation.send(.wrongEmailAndPassword)
            })
            .store(in: &cancelBag)
        
        shouldLogin
            .compactMap { [weak self] email, password -> LoginRequestModel? in
                return .init(email: email,
                             password: password)
            }
            .flatMap(useCase.login(requestModel:))
            .sink { [weak self] _ in
                self?.loginValidation.send(.success)
            }
            .store(in: &cancelBag)
    }
}

extension LoginViewModel {
    func sendShouldLogin(email: String, password: String) {
        shouldLogin.send((email, password))
    }
    
    func loginPublisher() -> AnyPublisher<UserError, Never> {
        return loginValidation.eraseToAnyPublisher()
    }
}
