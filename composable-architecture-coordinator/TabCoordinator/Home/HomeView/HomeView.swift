//
//  HomeView.swift
//  composable-architecture-coordinator
//
//  Created by Mateusz Uszyński on 26/10/2022.
//

import SwiftUI
import ComposableArchitecture

struct HomeView: View {
    let store: Store<HomeState, HomeAction>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            ScrollView {
                LazyVStack {
                    ForEach(viewStore.repositories) { repository in
                        RepositoryView(store: store, repository: repository)
                            .padding([.leading, .trailing, .bottom])
                    }
                }
            }
            .background(Color.black
                .edgesIgnoringSafeArea([.top, .leading, .trailing]))
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(store: Store(initialState: HomeState(),
                              reducer: homeReducer,
                              environment: .dev(environment: HomeEnvironment(repositoryRequest: dummyRepositoryEffect))))
    }
}
