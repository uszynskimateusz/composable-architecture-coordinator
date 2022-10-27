//
//  AccountView.swift
//  composable-architecture-coordinator
//
//  Created by Mateusz Uszyński on 26/10/2022.
//

import SwiftUI
import ComposableArchitecture

struct AccountView: View {
    let store: Store<AccountState, AccountAction>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            Button("Sign in") {
                viewStore.send(.onSignInButtonTapped)
            }
            .opacity(viewStore.user == nil ? 1 : 0)
            .buttonStyle(GrowingButton())
            
            Spacer().frame(height: 20)
            
            Button("Sign out") {
                viewStore.send(.onSignOutButtonTapped)
            }
            .opacity(viewStore.user == nil ? 0 : 1)
            .buttonStyle(GrowingButton())
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView(store: Store(initialState: AccountState(),
                                 reducer: accountReducer,
                                 environment: .dev(environment: AccountEnvironment(userRequest: dummyUserEffext))))
    }
}
