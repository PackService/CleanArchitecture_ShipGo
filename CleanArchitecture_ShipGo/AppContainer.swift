//
//  AppContainer.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/07/14.
//

import Foundation
import Swinject

struct AppContainer {
    private init() {}
    
    static let shared: Container = {
        let container = Container()
        
//        container.register(AccountMainViewController.self) { _ in
//            AccountMainViewController().then({ $0.viewModel = AccountMainViewModel(useCase: container.resolve(AccountUseCaseable.self, name: "AccountUseCaseable")!) })
//        }
//
//        container.register(RemoteDataSourceable.self) { _ in RemoteDataSourceImpl() }
//
//        container.register(AccountRepositoriable.self, name: "AccountRepositoriable") { r in
//            let repositoryImp = AccountRepositoryImpl(remoteDataSource: r.resolve(RemoteDataSourceable.self)!)
//            return repositoryImp
//        }
//
//        container.register(AccountUseCaseable.self, name: "AccountUseCaseable") { r in
//            let usecaseImpl = AccountUseCaseImpl(repository: r.resolve(AccountRepositoriable.self, name: "AccountRepositoriable")!)
//            return usecaseImpl
//        }
        
        return container
    }()
}
