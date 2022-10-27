//
//  LoginViewController.swift
//  composable-architecture-coordinator
//
//  Created by Mateusz Uszyński on 26/10/2022.
//

import SwiftUI
import ComposableArchitecture
import Combine

class LoginViewController: UIViewController {
    private lazy var loginView = UIHostingController(rootView: LoginView(store: store.scope(state: \.loginState,
                                                                                            action: AppAction.loginAction)))
    var cancellables: Set<AnyCancellable> = []
    
    private let store: Store<AppState, AppAction>
    
    init(store: Store<AppState, AppAction>) {
        self.store = store
        
        super.init(nibName: nil,
                   bundle: nil)
        
        bindToStore()
    }
    
    func bindToStore() {
        let viewStore = ViewStore(store.scope(state: \.loginState,
                                              action: AppAction.loginAction))
        
        viewStore
            .publisher
            .user
            .sink { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            }
            .store(in: &self.cancellables)
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
