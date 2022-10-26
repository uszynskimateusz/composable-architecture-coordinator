//
//  AppCoordinator.swift
//  composable-architecture-coordinator
//
//  Created by Mateusz Uszyński on 24/10/2022.
//

import UIKit

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(true,
                                                    animated: true)
    }
    
    func start() {
        showMainFlow()
    }
    
    private func showMainFlow() {
        let tabCoordinator = TabCoordinator.init(navigationController)
        tabCoordinator.start()
        childCoordinators.append(tabCoordinator)
    }
}
