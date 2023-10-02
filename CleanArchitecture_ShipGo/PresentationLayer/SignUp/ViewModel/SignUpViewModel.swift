//
//  SignUpViewModel.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/08/01.
//

import Foundation
import Combine

enum AgreementButtonType {
    case allAgree
    case firstAgree
    case secondAgree
    case thirdAgree
}

class SignUpViewModel: BaseViewModel {
    
    private var cancelBag = Set<AnyCancellable>()
    private let useCase: SignUpUseCaseable = SignUpUseCaseImpl() // 나중에 의존성 주입으로 변경 필요
    private var allAgree = CurrentValueSubject<Bool, Never>(false)
    private var firstAgree = CurrentValueSubject<Bool, Never>(false)
    private var secondAgree = CurrentValueSubject<Bool, Never>(false)
    private var thirdAgree = CurrentValueSubject<Bool, Never>(false)
    private var signUpValidation = PassthroughSubject<UserError, Never>()

    private let shouldSignUp = PassthroughSubject<(String, String), Never>()
    
    override init() {
        super.init()
        bind()
    }
    
    private func bind() {
        firstAgree
            .combineLatest(secondAgree, thirdAgree)
            .sink { [weak self] first, second, third in
                if first && second && third {
                    self?.allAgree.send(true)
                } else {
                    self?.allAgree.send(false)
                }
            }
            .store(in: &cancelBag)
        
        useCase.getErrorSubject()
            .sink(receiveValue: { [weak self] error in
                print("signupviewmodel error: \(error)")
                self?.signUpValidation.send(.existEmail)
            })
            .store(in: &cancelBag)
 
        shouldSignUp
            .compactMap { [weak self] email, password -> SignUpRequestModel? in
                return .init(email: email,
                             password: password)
            }
            .flatMap(useCase.signUp(requestModel:))
            .sink { [weak self] _ in
                self?.signUpValidation.send(.success)
            }
            .store(in: &cancelBag)
    }
    
    func allAgreePublisher() -> AnyPublisher<Bool, Never> {
        return allAgree.eraseToAnyPublisher()
    }
    
    func signUpPublisher() -> AnyPublisher<UserError, Never> {
        return signUpValidation.eraseToAnyPublisher()
    }
}

extension SignUpViewModel {
    
    func sendAgreePublisher(agreementButtonType: AgreementButtonType, buttonState: Bool) {
        switch agreementButtonType {
        case .allAgree:
            allAgree.send(buttonState)
        case .firstAgree:
            firstAgree.send(buttonState)
        case .secondAgree:
            secondAgree.send(buttonState)
        case .thirdAgree:
            thirdAgree.send(buttonState)
        }
    }
    
    func sendUserInfoPublisher(email: String, password: String, passwordCheck: String) {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,50}"
        if !NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email) {
            signUpValidation.send(.emailRegexError)
        } else if !NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password) {
            signUpValidation.send(.passwordRegexError)
        } else if password != passwordCheck {
            signUpValidation.send(.notEqualPassword)
        } else {
            print("viewmodelemail: \(email)")
            sendShouldSignUp(email: email, password: password)
        }
    }
    
    func sendShouldSignUp(email: String, password: String) {
        shouldSignUp.send((email, password))
    }
}
