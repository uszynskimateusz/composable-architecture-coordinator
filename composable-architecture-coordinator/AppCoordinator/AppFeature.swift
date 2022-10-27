//
//  AppFeature.swift
//  composable-architecture-coordinator
//
//  Created by Mateusz Uszyński on 27/10/2022.
//

import ComposableArchitecture

struct AppState {
    var homeState = HomeState()
    var loginState = LoginState()
    var accountState = AccountState()
    var coordinatorState = CoordinatorState()
}

enum AppAction {
    case homeAction(HomeAction)
    case loginAction(LoginAction)
    case accountAction(AccountAction)
    case coordinatorAction(CoordinatorAction)
}

struct AppEnvironment { }

let rootReducer = AnyReducer<
    AppState,
    AppAction,
    SystemEnvironment<AppEnvironment>
>.combine(
    homeReducer.pullback(state: \.homeState,
                         action: /AppAction.homeAction,
                         environment: { _ in .live(environment: HomeEnvironment(repositoryRequest: repositoryEffect)) }),
    loginReducer.pullback(state: \.loginState,
                          action: /AppAction.loginAction,
                          environment: { _ in .live(environment: LoginEnvironment(userRequest: userEffext)) }),
    accountReducer.pullback(state: \.accountState,
                            action: /AppAction.accountAction,
                            environment: {_ in .live(environment: AccountEnvironment()) }),
    coordinatorReducer.pullback(state: \.coordinatorState,
                                action: /AppAction.coordinatorAction,
                                environment: {_ in .live(environment: CoordinatorEnvironment()) })
)
