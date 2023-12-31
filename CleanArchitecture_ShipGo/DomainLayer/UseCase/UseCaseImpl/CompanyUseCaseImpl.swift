//
//  CompanyUseCaseImpl.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/10/27.
//

import Foundation
import Combine

final class CompanyUseCaseImpl: CompanyUseCaseable {
    
    private let repository: CompanyRepositoriable = CompanyRepositoryImpl()
    private let mapper = CompanyMapper()
    private let errorSubject = CurrentValueSubject<Error, Never>(NetworkError())
    
    func getErrorSubject() -> AnyPublisher<Error, Never> {
        return errorSubject.eraseToAnyPublisher()
    }
    
    // MARK: -get은 responsemodel 가져오기
//    func getRecommendCompanyList(invoice: String) -> AnyPublisher<CompanyResponseModel, Never> {
//        repository.getRecommendComapny(invoice: invoice)
//    }
    
    func getAllCompany() -> AnyPublisher<[CompanyResponseModel], Never> {
        repository.getAllCompany()
            .compactMap { [weak self] result -> [CompanyResponseModel]? in
                switch result {
                case .success(let responseModel):
                    return self?.mapper.entityToResponseModel(entity: responseModel)
                case .failure(let error):
                    self?.errorSubject.send(error)
                    return .init()
                }
            }
            .eraseToAnyPublisher()
    }
}
