//
//  TabCoordinator.swift
//  composable-architecture-coordinator
//
//  Created by Mateusz Uszyński on 25/10/2022.
//

import UIKit

enum TabBarPage {
    case home
    case account
    
    init?(index: Int) {
        switch index {
        case 0:
            self = .home
        case 1:
            self = .account
        default:
            return nil
        }
    }
    
    func pageTitleValue() -> String {
        switch self {
        case .home:
            return "Home"
        case .account:
            return "Account"
        }
    }
    
    func pageOrderNumber() -> Int {
        switch self {
        case .home:
            return 0
        case .account:
            return 1
        }
    }

    func icon() -> UIImage {
        switch self {
        case .home:
            return UIImage(systemName: "house.fill")!
        case .account:
            return UIImage(systemName: "person.fill")!
        }
    }
}


protocol TabCoordinatorProtocol: Coordinator {
    var tabBarController: UITabBarController { get set }
    
    func selectPage(_ page: TabBarPage)
    
    func setSelectedIndex(_ index: Int)
    
    func currentPage() -> TabBarPage?
}

class TabCoordinator: NSObject, Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    var tabBarController: UITabBarController
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = .init()
    }
    
    func start() {
        let pages: [TabBarPage] = [.home, .account]
        let controllers: [UINavigationController] = pages.map({ getTabController($0) })
        
        prepareTabBarController(withTabControllers: controllers)
    }
    
    deinit {
        print("TabCoordinator deinit")
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
            let homeVC = HomeViewController()
            homeVC.didSendEventClosure = { [weak self] event in
                switch event {
                case .ready:
                    self?.selectPage(.account)
                }
            }
            
            navController.pushViewController(homeVC, animated: true)
        case .account:
            let accountVC = AccountViewController()
            accountVC.didSendEventClosure = { [weak self] event in
                switch event {
                case .steady:
                    self?.selectPage(.home)
                }
            }
            
            navController.pushViewController(accountVC, animated: true)
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
