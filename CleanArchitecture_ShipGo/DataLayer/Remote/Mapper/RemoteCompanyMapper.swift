//
//  RemoteCompanyItem.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/10/27.
//

import Foundation

struct RemoteCompanyMapper {
//    func remoteItemToEntity(remoteItem: RemoteCompanyItem) -> CompanyEntity {
//        return .init(errorCode: remoteItem.errorCode ?? 0,
//                     errorMessage: remoteItem.errorMessage ?? "")
//    }
    
    func remoteItemToBasicEntity<T>(remoteItem: T) -> T {
        return remoteItem
    }
}
