//
//  LoginViewController.swift
//  composable-architecture-coordinator
//
//  Created by Mateusz Uszyński on 26/10/2022.
//

import UIKit
import SwiftUI

class LoginViewController: UIViewController {
    private let loginView = UIHostingController(rootView: LoginView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLoginView()
    }
    
    private func setupLoginView() {
        addChild(loginView)
        view.addSubview(loginView.view)
        loginView.didMove(toParent: self)
        
        loginView.view.frame = self.view.frame
    }
}
