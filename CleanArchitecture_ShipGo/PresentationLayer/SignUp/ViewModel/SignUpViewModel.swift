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
    private var allAgree = PassthroughSubject<Bool, Never>()
//    private var firstAgreeTap = PassthroughSubject<Bool, Never>()
//    private var secondAgreeTap =

    
    override init() {
        super.init()
        bind()
    }
    
    private func bind() {
        
    }
    
    func getAllAgreePublisher() -> AnyPublisher<Bool, Never> {
        return allAgree.eraseToAnyPublisher()
    }
}

extension SignUpViewModel {
    func sendAllAgreePublisher(state: Bool) {
        allAgree.send(state)
    }
    func sendFirstAgreePublisher(state: Bool) {
        firstAgree.send(state)
    }
    func sendSecondAgreePublisher(state: Bool) {
        secondAgree.send(state)
    }
    func sendThirdAgreePublisher(state: Bool) {
        thirdAgree.send(state)
    }
}
