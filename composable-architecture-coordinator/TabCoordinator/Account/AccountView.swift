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
            .buttonStyle(GrowingButton())
            
            Spacer().frame(height: 20)
            
            Button("Sign out") {
                viewStore.send(.onSignOutButtonTapped)
            }
            .buttonStyle(GrowingButton())
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView(store: Store(initialState: AccountState(),
                                 reducer: accountReducer,
                                 environment: .dev(environment: AccountEnvironment())))
    }
}
