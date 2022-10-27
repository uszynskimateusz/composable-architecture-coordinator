//
//  AccountFeature.swift
//  composable-architecture-coordinator
//
//  Created by Mateusz Uszyński on 27/10/2022.
//

import Foundation
import ComposableArchitecture

struct AccountState: Equatable {}

enum AccountAction: Equatable {
    case onSignInButtonTapped
    case onSignOutButtonTapped
}

struct AccountEnvironment {}

let accountReducer = AnyReducer<
    AccountState,
    AccountAction,
    SystemEnvironment<AccountEnvironment>
> { state, action, environment in
    switch action {
    case .onSignInButtonTapped:
        return .none
    case .onSignOutButtonTapped:
        return .none
    }
}.debug()
