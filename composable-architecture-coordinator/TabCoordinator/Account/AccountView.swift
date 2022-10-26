//
//  AccountView.swift
//  composable-architecture-coordinator
//
//  Created by Mateusz Uszyński on 26/10/2022.
//

import SwiftUI

struct AccountView: View {
    var body: some View {
        Button("Sign in") {
            print("Button tapped!")
        }
        .buttonStyle(GrowingButton())
        
        Spacer().frame(height: 20)
        
        Button("Sign out") {
            print("Button tapped!")
        }
        .buttonStyle(GrowingButton())
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}

struct GrowingButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 100)
            .padding()
            .background(.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2),
                       value: configuration.isPressed)
    }
}
