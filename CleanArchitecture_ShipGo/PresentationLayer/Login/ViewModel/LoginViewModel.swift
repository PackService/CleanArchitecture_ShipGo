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
    private let useCase: SignUpUseCaseable = SignUpUseCaseImpl() // 나중에 의존성 주입으로 변경 필요
    
}
