//
//  LoginViewController.swift
//  composable-architecture-coordinator
//
//  Created by Mateusz Uszyński on 26/10/2022.
//

import SwiftUI
import ComposableArchitecture

class LoginViewController: UIViewController {
    private lazy var loginView = UIHostingController(rootView: LoginView(store: store.scope(state: \.loginState,
                                                                                            action: AppAction.loginAction)))
    
    private let store: Store<AppState, AppAction>
    
    init(store: Store<AppState, AppAction>) {
        self.store = store
        
        super.init(nibName: nil,
                   bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
