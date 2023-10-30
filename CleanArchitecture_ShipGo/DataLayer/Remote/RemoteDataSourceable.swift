//
//  RemoteDataSourceable.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/07/12.
//

import Foundation
import Combine

protocol RemoteDataSourceable {
    // MARK: - SignUp & Login
    func signUp(email: String, password: String) -> AnyPublisher<Result<Void, Error>, Never>
    func login(email: String, password: String) -> AnyPublisher<Result<Void, Error>, Never>
    
    // MARK: - get Company List
    func getRecommendCompany(invoice: String) -> AnyPublisher<Result<[CompanyEntity.Company], Error>, Never>
    func getAllCompany() -> AnyPublisher<Result<[CompanyEntity.Company], Error>, Never>
}
