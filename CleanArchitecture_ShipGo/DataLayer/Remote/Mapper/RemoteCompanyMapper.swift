//
//  RemoteCompanyItem.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/10/27.
//

import Foundation

struct RemoteCompanyMapper {
    func remoteItemToEntity(remoteItem: RemoteCompanyItem) -> [CompanyEntity.Company] {
        var entity: [CompanyEntity.Company] = []
        remoteItem.company.forEach {
            entity.append(CompanyEntity.Company(id: $0.id ?? "", international: $0.international ?? "", name: $0.name ?? ""))
        }
        return entity
    }
    
    func remoteItemToBasicEntity<T>(remoteItem: T) -> T {
        return remoteItem
    }
}
