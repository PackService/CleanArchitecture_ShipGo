//
//  RemoteCompanyRepositoriable.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/10/27.
//

import Foundation
import Combine

protocol CompanyRepositoriable {
    func getRecommendComapny(invoice: String) -> AnyPublisher<Result<[CompanyEntity.Company], Error>, Never>
}
