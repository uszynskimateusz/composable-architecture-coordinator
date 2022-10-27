//
//  AppCoordinator.swift
//  composable-architecture-coordinator
//
//  Created by Mateusz Uszyński on 24/10/2022.
//

import UIKit
import ComposableArchitecture

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(true,
                                                    animated: true)
    }
    
    private let store = Store(initialState: AppState(),
                              reducer: rootReducer,
                              environment: .live(environment: AppEnvironment()))
    
    func start() {
        showMainFlow()
    }
    
    private func showMainFlow() {
        let tabCoordinator = TabCoordinator(navigationController,
                                            store: store)
        tabCoordinator.start()
        childCoordinators.append(tabCoordinator)
    }
}
