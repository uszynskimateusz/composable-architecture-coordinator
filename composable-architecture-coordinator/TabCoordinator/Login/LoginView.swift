//
//  LoginView.swift
//  composable-architecture-coordinator
//
//  Created by Mateusz Uszyński on 26/10/2022.
//

import SwiftUI
import ComposableArchitecture

struct LoginView: View {
    @State var loginFieldText: String = ""
    @State var passwordFieldText: String = ""
    
    let store: Store<AccountState, AccountAction>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            TextField("Email...", text: $loginFieldText)
                .textFieldStyle(.roundedBorder)
            
            TextField("Password...", text: $passwordFieldText)
                .textFieldStyle(.roundedBorder)
            
            Button("Sign in") {
                viewStore.send(.onButtonTap(email: loginFieldText,
                                            password: passwordFieldText))
            }
            .buttonStyle(GrowingButton())
            .disabled(textIsAppropriate())
        }.padding()
    }
    
    func textIsAppropriate() -> Bool {
        loginFieldText.isEmpty && passwordFieldText.isEmpty
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(store: Store(initialState: AccountState(),
                               reducer: accountReducer,
                               environment: .dev(environment: AccountEnvironment(userRequest: dummyUserEffext))))
    }
}
