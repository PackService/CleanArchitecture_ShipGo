//
//  TrackCompanyViewModel.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/10/26.
//

import Foundation
import Combine

final class TrackCompanyViewModel: BaseViewModel {
    
    private var cancelBag = Set<AnyCancellable>()
    private let useCase: CompanyUseCaseable = CompanyUseCaseImpl() // 나중에 의존성 주입으로 변경 필요
    private var shouldLoadInitData = CurrentValueSubject<[CompanyResponseModel], Never>([.init()]) // MARK: - 맞나..?
    
    override init() {
        super.init()
        bind()
    }
    
    private func bind() {
        
    }
}

extension TrackCompanyViewModel {
   
}
