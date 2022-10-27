//
//  LoginFeature.swift
//  composable-architecture-coordinator
//
//  Created by Mateusz Uszyński on 26/10/2022.
//

import Foundation
import ComposableArchitecture

struct LoginState: Equatable {
    var user: User?
}

enum LoginAction: Equatable {
    case onButtonTap(email: String, password: String)
    case dataLoaded(Result<UserResponse, APIError>)
}

struct LoginEnvironment {
    var userRequest: (JSONDecoder) -> Effect<UserResponse, APIError>
}

let loginReducer = AnyReducer<
    LoginState,
    LoginAction,
    SystemEnvironment<LoginEnvironment>
> { state, action, environment in
    switch action {
    case .onButtonTap(let email,
                      let passowrd):
        return environment.userRequest(environment.decoder())
            .receive(on: environment.mainQueue())
            .catchToEffect()
            .map(LoginAction.dataLoaded)
    case .dataLoaded(let result):
        switch result {
        case .success(let response):
            guard let userName = response.results.first else { return .none }
            
            state.user = User(name: userName.first)
        case .failure:
            break
        }
        return .none
    }
}
