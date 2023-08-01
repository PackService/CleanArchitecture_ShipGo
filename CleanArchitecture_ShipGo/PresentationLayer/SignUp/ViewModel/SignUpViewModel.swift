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
    private var didTapSignUp = PassthroughSubject<Bool, Never>()
    
    override init() {
        super.init()
        bind()
    }
    
    private func bind() {
        
    }
}
