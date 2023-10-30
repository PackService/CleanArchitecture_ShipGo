//
//  CompanyRepositoryImpl.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/10/30.
//

import Foundation
import Combine

class CompanyRepositoryImpl: CompanyRepositoriable {
    
    private var cancelBag = Set<AnyCancellable>()
    private let remoteDataSource: RemoteDataSourceable = RemoteDataSourceImpl() as! RemoteDataSourceable
    
    func getRecommendCompany(invoice: String) -> AnyPublisher<Result<[CompanyEntity.Company], Error>, Never> {
        remoteDataSource.getRecommendCompany(invoice: invoice)
    }
    

    func getAllCompany()  -> AnyPublisher<Result<[CompanyEntity.Company], Error>, Never> {
        remoteDataSource.getAllCompany()
    }
}
