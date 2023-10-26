//
//  TrackCompanyViewModel.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/10/26.
//

//import Foundation
//import Combine
//
//class TrackCompanyViewModel: BaseViewModel {
//    
//    private var cancelBag = Set<AnyCancellable>()
//    private let useCase: TrackCompanyUseCaseable = TrackCompanyUseCaseImpl() // 나중에 의존성 주입으로 변경 필요
//    private let shouldLogin = PassthroughSubject<(String, String), Never>()
//    private let loginValidation = PassthroughSubject<UserError, Never>()
//    
//    override init() {
//        super.init()
//        bind()
//    }
//    
//    private func bind() {
////        useCase.getErrorSubject()
////            .sink(receiveValue: { [weak self] error in
////                print("loginviewmodel error: \(error)")
////                self?.loginValidation.send(.wrongEmailAndPassword)
////            })
////            .store(in: &cancelBag)
//    }
//}
//
//extension TrackCompanyViewModel {
//    func sendShouldLogin(email: String, password: String) {
//        
//    }
//    
//    func loginPublisher() -> AnyPublisher<UserError, Never> {
//        
//    }
//}
