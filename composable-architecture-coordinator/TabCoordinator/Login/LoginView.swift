//
//  LoginView.swift
//  composable-architecture-coordinator
//
//  Created by Mateusz Uszyński on 26/10/2022.
//

import SwiftUI

struct LoginView: View {
    @State var loginFieldText: String = ""
    @State var passwordFieldText: String = ""
    
    var body: some View {
        NavigationView {
            TextField("Email...", text: $loginFieldText)
                .textFieldStyle(.roundedBorder)
            
            Spacer().frame(height: 20)
            
            TextField("Password...", text: $passwordFieldText)
                .textFieldStyle(.roundedBorder)
            
            Spacer().frame(height: 20)
            
            Button("Sign out") {
                print("Button tapped!")
            }
            .buttonStyle(GrowingButton())
            .disabled(!textIsAppropriate())
        }
        .padding()
        .navigationTitle("Log in")
    }
    
    func textIsAppropriate() -> Bool {
        loginFieldText.isEmpty && passwordFieldText.isEmpty
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
