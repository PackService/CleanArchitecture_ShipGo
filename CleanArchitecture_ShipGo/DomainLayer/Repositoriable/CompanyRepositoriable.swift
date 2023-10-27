//
//  RemoteCompanyRepositoriable.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/10/27.
//

import Foundation
import Combine

protocol CompanyRepositoriable {
    func getCompany(invoice: String) -> AnyPublisher<Result<Void, Error>, Never>
}
