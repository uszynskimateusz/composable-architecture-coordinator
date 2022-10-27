//
//  RepositoryView.swift
//  composable-architecture-coordinator
//
//  Created by Mateusz Uszyński on 27/10/2022.
//

import SwiftUI
import ComposableArchitecture

struct RepositoryView: View {
    let store: Store<HomeState, HomeAction>
    let repository: RepositoryModel
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack {
                HStack {
                    Text(repository.name)
                        .font(.title)
                    Spacer()
                    Button(
                        action: { viewStore.send(.favoriteButtonTapped(repository)) },
                        label: {
                            if viewStore.favoriteRepositories.contains(repository) {
                                Image(systemName: "heart.fill")
                            } else {
                                Image(systemName: "heart")
                            }
                        })
                }
                Text(repository.description ?? "No description available")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 4)
                    .padding(.bottom, 4)
                HStack {
                    HStack {
                        Image(systemName: "star.fill")
                        Text("\(repository.stars)")
                    }
                    Spacer()
                    HStack {
                        Image(systemName: "arrow.triangle.branch")
                        Text("\(repository.forks)")
                    }
                    Spacer()
                    if repository.language != nil {
                        Text("\(repository.language ?? "---")")
                            .multilineTextAlignment(.center)
                    }
                }
            }
            .padding()
            .foregroundColor(Color("rw-light"))
            .background(Color("rw-green"))
            .cornerRadius(8.0)
        }
    }
}
