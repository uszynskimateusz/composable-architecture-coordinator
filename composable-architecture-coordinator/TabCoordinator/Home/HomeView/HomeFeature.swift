//
//  HomeFeature.swift
//  composable-architecture-coordinator
//
//  Created by Mateusz Uszyński on 27/10/2022.
//

import Combine
import ComposableArchitecture
import Foundation

struct HomeState: Equatable {
    var repositories: [RepositoryModel] = []
    var favoriteRepositories: [RepositoryModel] = []
}

enum HomeAction: Equatable {
    case onAppear
    case dataLoaded(Result<[RepositoryModel], APIError>)
    case favoriteButtonTapped(RepositoryModel)
}

struct HomeEnvironment {
    var repositoryRequest: (JSONDecoder) -> Effect<[RepositoryModel], APIError>
}

let homeReducer = Reducer<
    HomeState,
    HomeAction,
    SystemEnvironment<HomeEnvironment>
> { state, action, environment in
    switch action {
    case .onAppear:
        return environment.repositoryRequest(environment.decoder())
            .receive(on: environment.mainQueue())
            .catchToEffect()
            .map(HomeAction.dataLoaded)
    case .dataLoaded(let result):
        switch result {
        case .success(let repositories):
            state.repositories = repositories
        case .failure(let error):
            break
        }
        return .none
    case .favoriteButtonTapped(let repository):
        if state.favoriteRepositories.contains(repository) {
            state.favoriteRepositories.removeAll { $0 == repository }
        } else {
            state.favoriteRepositories.append(repository)
        }
        return .none
    }
}.debug()
