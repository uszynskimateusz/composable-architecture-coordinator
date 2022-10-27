//
//  TabCoordinator.swift
//  composable-architecture-coordinator
//
//  Created by Mateusz Uszyński on 25/10/2022.
//

import UIKit
import ComposableArchitecture

protocol TabCoordinatorProtocol: Coordinator {
    var tabBarController: UITabBarController { get set }
    
    func selectPage(_ page: TabBarPage)
    
    func setSelectedIndex(_ index: Int)
    
    func currentPage() -> TabBarPage?
}

class TabCoordinator: NSObject, Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    private let tabBarController = UITabBarController()
    private let store = Store(initialState: AppState(),
                              reducer: rootReducer,
                              environment: .live(environment: AppEnvironment()))
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let pages: [TabBarPage] = [.home, .favorites, .account]
        let controllers: [UINavigationController] = pages.map({ getTabController($0) })
        
        prepareTabBarController(withTabControllers: controllers)
    }
    
    private func prepareTabBarController(withTabControllers tabControllers: [UIViewController]) {
        tabBarController.delegate = self
        tabBarController.setViewControllers(tabControllers, animated: true)
        tabBarController.selectedIndex = TabBarPage.home.pageOrderNumber()
        tabBarController.tabBar.isTranslucent = true
        
        navigationController.viewControllers = [tabBarController]
    }
    
    private func getTabController(_ page: TabBarPage) -> UINavigationController {
        let navController = UINavigationController()
        navController.setNavigationBarHidden(false, animated: false)
        
        navController.tabBarItem = UITabBarItem.init(title: page.pageTitleValue(),
                                                     image: page.icon(),
                                                     tag: page.pageOrderNumber())
        
        switch page {
        case .home:
            let homeVC = HomeViewController(store: store)
            navController.pushViewController(homeVC,
                                             animated: true)
        case .account:
            let accountVC = AccountViewController(store: store)
            navController.pushViewController(accountVC,
                                             animated: true)
        case .favorites:
            let favoritesVC = FavoritesViewController(store: store)
            navController.pushViewController(favoritesVC,
                                             animated: true)
        }
        
        return navController
    }
    
    func currentPage() -> TabBarPage? {
        TabBarPage.init(index: tabBarController.selectedIndex)
    }
    
    func selectPage(_ page: TabBarPage) {
        tabBarController.selectedIndex = page.pageOrderNumber()
    }
    
    func setSelectedIndex(_ index: Int) {
        guard let page = TabBarPage.init(index: index) else { return }
        
        tabBarController.selectedIndex = page.pageOrderNumber()
    }
}

extension TabCoordinator: UITabBarControllerDelegate {
    func tabBarController(
        _ tabBarController: UITabBarController,
        didSelect viewController: UIViewController
    ) { }
}
