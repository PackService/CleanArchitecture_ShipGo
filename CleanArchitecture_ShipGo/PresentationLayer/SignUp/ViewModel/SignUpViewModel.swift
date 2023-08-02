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
}
