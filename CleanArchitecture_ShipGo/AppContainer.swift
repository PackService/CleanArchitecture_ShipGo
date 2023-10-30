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
        
        // MARK: -ViewModel Register
        container.register(LoginViewModel.self) { r in LoginViewModel() }
        container.register(SignUpViewModel.self) { r in SignUpViewModel() }
        container.register(HomeMainViewModel.self) { r in HomeMainViewModel() }
        
        // MARK: -ViewController Register
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
        
        container.register(HomeMainViewController.self) { r in
            let vc = HomeMainViewController()
            vc.viewModel = r.resolve(HomeMainViewModel.self)
            return vc
        }
        
        container.register(RegisterTrackViewController.self) { r in
            let vc = RegisterTrackViewController()
            vc.viewModel = r.resolve(HomeMainViewModel.self)
            return vc
        }
        
        container.register(SelectTrackCompanyViewController.self) { r in
            let vc = SelectTrackCompanyViewController()
            return vc
        }
        
        return container
    }()
}
