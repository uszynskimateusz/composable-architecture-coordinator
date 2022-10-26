//
//  Coordinator.swift
//  composable-architecture-coordinator
//
//  Created by Mateusz Uszyński on 24/10/2022.
//

import UIKit

// MARK: - Coordinator
protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    var childCoordinators: [Coordinator] { get set }
    
    func start()
    func finish()
    
    init(_ navigationController: UINavigationController)
}

extension Coordinator {
    func finish() {
        childCoordinators.removeAll()
    }
}
