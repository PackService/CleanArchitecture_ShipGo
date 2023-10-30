//
//  CompanyUseCaseable.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/10/27.
//

import Foundation
import Combine

protocol CompanyUseCaseable {
//    func getRecommendComapny(invoice: String) -> AnyPublisher<Result<CompanyEntity.company, Error>, Never>
    func getAllCompany() -> AnyPublisher<[CompanyResponseModel], Never> 
    func getErrorSubject() -> AnyPublisher<Error, Never>
}
