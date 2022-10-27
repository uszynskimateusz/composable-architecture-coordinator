//
//  AccountFeature.swift
//  composable-architecture-coordinator
//
//  Created by Mateusz Uszyński on 27/10/2022.
//

import Foundation
import ComposableArchitecture

struct AccountState: Equatable {
    var currentScreen: AccountScreen?
    var user: User?
}

enum AccountAction: Equatable {
    case onSignInButtonTapped
    case onSignOutButtonTapped
    
    case onButtonTap(email: String,
                     password: String)
    case dataLoaded(Result<UserResponse, APIError>)
}

struct AccountEnvironment {
    var userRequest: (JSONDecoder) -> Effect<UserResponse, APIError>
}

let accountReducer = AnyReducer<
    AccountState,
    AccountAction,
    SystemEnvironment<AccountEnvironment>
> { state, action, environment in
    switch action {
    case .onSignInButtonTapped:
        state.currentScreen = .login
        return .none
    case .onSignOutButtonTapped:
        state.currentScreen = nil
        state.user = nil
        return .none
    case .onButtonTap(let email,
                      let passowrd):
        return environment.userRequest(environment.decoder())
            .receive(on: environment.mainQueue())
            .catchToEffect()
            .map(AccountAction.dataLoaded)
    case .dataLoaded(let result):
        switch result {
        case .success(let response):
            guard let userName = response.results.first?.name else { return .none }
            
            state.user = User(name: userName.first)
        case .failure:
            break
        }
        return .none
    }
}.debug()


enum AccountScreen {
    case login
}
