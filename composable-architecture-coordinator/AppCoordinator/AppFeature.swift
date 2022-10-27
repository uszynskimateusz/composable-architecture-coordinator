//
//  AppFeature.swift
//  composable-architecture-coordinator
//
//  Created by Mateusz Uszyński on 27/10/2022.
//

import ComposableArchitecture

struct AppState {
    var homeState = HomeState()
    var accountState = AccountState()
    var coordinatorState = CoordinatorState()
}

enum AppAction {
    case homeAction(HomeAction)
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
    accountReducer.pullback(state: \.accountState,
                            action: /AppAction.accountAction,
                            environment: {_ in .live(environment: AccountEnvironment(userRequest: userEffext)) }),
    coordinatorReducer.pullback(state: \.coordinatorState,
                                action: /AppAction.coordinatorAction,
                                environment: {_ in .live(environment: CoordinatorEnvironment()) })
)
