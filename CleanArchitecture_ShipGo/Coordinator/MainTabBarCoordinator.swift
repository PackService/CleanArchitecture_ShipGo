//
//  MainTabBarCoordinator.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/08/01.
//

import UIKit

enum CoordinatorType {
    case home, list, setting
    case tab
}

// MARK: - 종료 되면 화면 참조 카운트 줄어드는지 확인
class MainTabBarCoordinator: Coordinator {
    
    weak var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    var type: CoordinatorType
    var tabBarController: UITabBarController

    init(navigationController: UINavigationController) {
        self.type = CoordinatorType.tab
        self.navigationController = navigationController
        self.tabBarController = UITabBarController()
    }

    func start() {
        // 1. 탭바 아이템 리스트 생성
        let pages: [TabBarItemType] = TabBarItemType.allCases
        // 2. 탭바 아이템 생성
        let tabBarItems: [UITabBarItem] = pages.map { self.createTabBarItem(of: $0) }
        // 3. 탭바별 navigation controller 생성
        let controllers: [UINavigationController] = tabBarItems.map {
            self.createTabNavigationController(tabBarItem: $0)
        }
        // 4. 탭바별로 코디네이터 생성하기
        let _ = controllers.map{ self.startTabCoordinator($0) }
        // 5. 탭바 스타일 지정 및 VC 연결
        self.configureTabBarController(tabNavigationControllers: controllers)
        // 6. 탭바 화면에 붙이기
        self.addTabBarController()
    }
    
    // MARK: - TabBarController 설정 메소드
    
    private func configureTabBarController(tabNavigationControllers: [UIViewController]){
        self.tabBarController.setViewControllers(tabNavigationControllers, animated: false)
        // home의 index로 TabBar Index 세팅
        self.tabBarController.selectedIndex = TabBarItemType.home.toInt()
        // TabBar 스타일 지정
        self.tabBarController.view.backgroundColor = .systemBackground
        self.tabBarController.tabBar.backgroundColor = .systemBackground
        self.tabBarController.tabBar.tintColor = UIColor.black
    }
    
    private func addTabBarController(){
        self.navigationController.pushViewController(self.tabBarController, animated: true)
    }
    
    private func createTabBarItem(of page: TabBarItemType) -> UITabBarItem {
        return UITabBarItem(
            title: "",
            image: UIImage(systemName: page.toIconName()),
            tag: page.toInt()
        )
    }
    
    private func createTabNavigationController(tabBarItem: UITabBarItem) -> UINavigationController {
        let tabNavigationController = UINavigationController()
        
        tabNavigationController.setNavigationBarHidden(false, animated: false)
        tabNavigationController.navigationBar.topItem?.title = "아아"
        tabNavigationController.tabBarItem = tabBarItem
        
        return tabNavigationController
    }
    
    private func startTabCoordinator(_ tabNavigationController: UINavigationController) {
        let tabBarItemTag: Int = tabNavigationController.tabBarItem.tag
        guard let tabBarItemType: TabBarItemType = TabBarItemType(index: tabBarItemTag) else { return }
        
        // 코디네이터 생성 및 실행
        switch tabBarItemType {
        case .home:
            let homeCoordinator = TabBarHomeCoordinator(navigationController: tabNavigationController)
            self.childCoordinators.append(homeCoordinator)
            homeCoordinator.start()
        case .list:
            let listCoordinator = TabBarListCoordinator(navigationController: tabNavigationController)
            self.childCoordinators.append(listCoordinator)
            listCoordinator.start()
        case .setting:
            let settingCoordinator = TabBarSettingCoordinator(navigationController: tabNavigationController)
            self.childCoordinators.append(settingCoordinator)
            settingCoordinator.start()
        }
    }
}
