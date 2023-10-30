//
//  CompanyMapper.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/10/27.
//

import Foundation

struct CompanyMapper {
    func entityToResponseModel(entity: [CompanyEntity.Company]) -> [CompanyResponseModel] {
        var responseModel: [CompanyResponseModel] = [CompanyResponseModel]()
        entity.forEach {
            responseModel.append(CompanyResponseModel(id: $0.id, international: $0.international, name: $0.name))
        }
        return responseModel
    }
    
    func entityToBasicResponseModel<T>(entity: T) -> T {
        return entity
    }
}
