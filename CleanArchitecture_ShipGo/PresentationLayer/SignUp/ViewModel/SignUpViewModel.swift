//
//  SignUpViewModel.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/08/01.
//

import Foundation
import Combine

// 전체동의가 됐는지
// MARK: - utransfer-cleanArchitecture loginViewModel 참고
class SignUpViewModel: BaseViewModel {
    
    private var cancelBag = Set<AnyCancellable>()
//    private let usecase: SignUpUseCaseable
//    private var allAgree = PassthroughSubject<Bool, Never>()
//    private var firstAgree = PassthroughSubject<Bool, Never>()
//    private var secondAgree = PassthroughSubject<Bool, Never>()
//    private var thirdAgree = PassthroughSubject<Bool, Never>()
    
    private var allAgree = CurrentValueSubject<Bool, Never>(false)
    private var firstAgree = CurrentValueSubject<Bool, Never>(false)
    private var secondAgree = CurrentValueSubject<Bool, Never>(false)
    private var thirdAgree = CurrentValueSubject<Bool, Never>(false)

    override init() {
        super.init()
        bind()
    }
    
    private func bind() {
        // 3개가 다 클릭 되면 allAgree == true or allAgree눌리면 3개가 다 클릭 되서 allagree == true
//        firstAgr
    }
    
    func allAgreePublisher() -> AnyPublisher<Bool, Never> {
        return allAgree.eraseToAnyPublisher()
    }
    
    func firstAgreePublisher() -> AnyPublisher<Bool, Never> {
        return firstAgree.eraseToAnyPublisher()
    }
    
    func secondAgreePublisher() -> AnyPublisher<Bool, Never> {
        return secondAgree.eraseToAnyPublisher()
    }
    
    func thirdAgreePublisher() -> AnyPublisher<Bool, Never> {
        return thirdAgree.eraseToAnyPublisher()
    }
}

extension SignUpViewModel {
    
    func sendAgreePublisher(agreementButtonType: AgreementButtonType) {
        switch agreementButtonType {
        case .allAgree:
//            allAgree.send(!allAgree.value)
            firstAgree.send(!firstAgree.value)
            secondAgree.send(!secondAgree.value)
            thirdAgree.send(!thirdAgree.value)
        case .firstAgree:
            firstAgree.send(!firstAgree.value)
        case .secondAgree:
            secondAgree.send(!secondAgree.value)
        case .thirdAgree:
            thirdAgree.send(!thirdAgree.value)
        }
    }
}

enum AgreementButtonType {
    case allAgree
    case firstAgree
    case secondAgree
    case thirdAgree
}
