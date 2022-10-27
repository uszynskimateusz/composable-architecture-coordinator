//
//  FavoritesView.swift
//  composable-architecture-coordinator
//
//  Created by Mateusz Uszyński on 27/10/2022.
//

import SwiftUI
import ComposableArchitecture

struct FavoritesView: View {
    let store: Store<HomeState, HomeAction>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            ScrollView {
                LazyVStack {
                    ForEach(viewStore.favoriteRepositories) { repository in
                        RepositoryView(store: store, repository: repository)
                            .padding([.leading, .trailing, .bottom])
                    }
                }
            }
            .background(Color.black
                .edgesIgnoringSafeArea([.top, .leading, .trailing]))
        }
    }
}
