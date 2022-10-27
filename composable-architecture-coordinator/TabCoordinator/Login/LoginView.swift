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
    
    let store: Store<LoginState, LoginAction>
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            TextField("Email...", text: $loginFieldText)
                .textFieldStyle(.roundedBorder)
            
            TextField("Password...", text: $passwordFieldText)
                .textFieldStyle(.roundedBorder)
            
            Button("Sign out") {
                viewStore.send(.onButtonTap(email: loginFieldText,
                                            password: passwordFieldText))
            }
            .buttonStyle(GrowingButton())
            .disabled(textIsAppropriate())
        }
    }
    
    func textIsAppropriate() -> Bool {
        loginFieldText.isEmpty && passwordFieldText.isEmpty
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(store: Store(initialState: LoginState(),
                               reducer: loginReducer,
                               environment: .dev(environment: LoginEnvironment(userRequest: dummyUserEffext))))
    }
}
