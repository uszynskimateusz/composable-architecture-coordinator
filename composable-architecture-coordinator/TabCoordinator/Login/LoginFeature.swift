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
        print("TEST: onButtonTap")
        return environment.userRequest(environment.decoder())
            .receive(on: environment.mainQueue())
            .catchToEffect()
            .map(LoginAction.dataLoaded)
    case .dataLoaded(let result):
        switch result {
        case .success(let response):
            guard let userName = response.results.first?.name else { return .none }
            
            state.user = User(name: userName.first)
            print("TEST: success user \(userName.first)")
        case .failure:
            print("TEST: failure")
            break
        }
        return .none
    }
}.debug()
