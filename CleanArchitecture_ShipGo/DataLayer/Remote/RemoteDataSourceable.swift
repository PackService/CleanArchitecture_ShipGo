//
//  RemoteDataSourceable.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/07/12.
//

import Foundation
import Combine

protocol RemoteDataSourceable {
    func signUp(email: String, password: String) -> AnyPublisher<Result<Void, Error>, Never>
    func login(email: String, password: String) -> AnyPublisher<Result<Void, Error>, Never>
    func getRecommendComapny(invoice: String) -> AnyPublisher<Result<[CompanyEntity.Company], Error>, Never>
//    func 
}
