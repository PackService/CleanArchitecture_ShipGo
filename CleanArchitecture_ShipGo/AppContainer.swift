//
//  AppContainer.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/07/14.
//

import Foundation
import Swinject

// 하나의 컨테이너를 만든다
struct AppContainer {
    private init() {}
    
    static let shared: Container = {
        let container = Container()
        
        // MARK: -register는 등록
        container.register(LoginViewModel.self) { r in LoginViewModel() }
        container.register(SignUpViewModel.self) { r in SignUpViewModel() }
        
        // MARK: -resolve는 사용
        container.register(LoginViewController.self) { r in
            let vc = LoginViewController()
            vc.viewModel = r.resolve(LoginViewModel.self)
            return vc
        }
        
        container.register(SignUpViewController.self) { r in
            let vc = SignUpViewController()
            vc.viewModel = r.resolve(SignUpViewModel.self)
            return vc
        }
        
        return container
    }()
}
