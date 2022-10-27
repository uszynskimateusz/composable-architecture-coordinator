//
//  AppFeature.swift
//  composable-architecture-coordinator
//
//  Created by Mateusz Uszyński on 27/10/2022.
//

import ComposableArchitecture

struct AppState {
    var loginState = LoginState()
}

enum AppAction {
    case loginAction(LoginAction)
}

struct AppEnvironment { }

let rootReducer = Reducer<
    AppState,
    AppAction,
    SystemEnvironment<AppEnvironment>
>.combine(
    loginReducer.pullback(state: \.loginState,
                          action: /AppAction.loginAction,
                          environment: { _ in .live(environment: LoginEnvironment(userRequest: userEffext))})
)

