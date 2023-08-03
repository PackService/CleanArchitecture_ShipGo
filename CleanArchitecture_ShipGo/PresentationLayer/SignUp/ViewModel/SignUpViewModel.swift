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
    private var allAgree = CurrentValueSubject<Bool, Never>(false)
    private var firstAgree = CurrentValueSubject<Bool, Never>(false)
    private var secondAgree = CurrentValueSubject<Bool, Never>(false)
    private var thirdAgree = CurrentValueSubject<Bool, Never>(false)
    private var loginButtonTapped = CurrentValueSubject<Bool, Never>(false)

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
    }
    
    func allAgreePublisher() -> AnyPublisher<Bool, Never> {
        return allAgree.eraseToAnyPublisher()
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
    
    func sendUserInfoPublisher(email: String, password: String, passwordCheck: String) -> Bool {
        
        return false
    }
    
    // 이메일 정규성 체크
    func validateEmail(_ input: String) -> Validation<String, String> {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        let isValid = emailPredicate.evaluate(with: input)

        if isValid {
            return .valid(input)
        } else {
            return .invalid("invalid email")
        }
    }

    // 패스워드 정규성 체크
    func validatePassword(_ input: String) -> Validation<String, String> {
        let regex = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,50}" // 8자리 ~ 50자리 영어+숫자+특수문자

        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        let isValid = predicate.evaluate(with: input)

        if isValid {
            return .valid(input)
        } else {
            return .invalid("invalid password")
        }
    }
}
