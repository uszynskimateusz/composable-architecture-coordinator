//
//  CoordinatorFeature.swift
//  composable-architecture-coordinator
//
//  Created by Mateusz Uszyński on 27/10/2022.
//

import Foundation
import Foundation
import ComposableArchitecture

struct CoordinatorState: Equatable {}

enum CoordinatorAction: Equatable {
    case homeScreen
    case accountScreen
}

struct CoordinatorEnvironment {}

let coordinatorReducer = AnyReducer<
    CoordinatorState,
    CoordinatorAction,
    SystemEnvironment<CoordinatorEnvironment>
> { state, action, environment in
    switch action {
    case .homeScreen:
        return .none
    case .accountScreen:
        return .none
    }
}
