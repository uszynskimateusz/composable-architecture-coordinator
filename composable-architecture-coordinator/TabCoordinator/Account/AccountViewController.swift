//
//  SteadyViewController.swift
//  composable-architecture-coordinator
//
//  Created by Mateusz Uszyński on 25/10/2022.
//

import SwiftUI
import ComposableArchitecture
import Combine

class AccountViewController: UIViewController {
    private lazy var accountView = UIHostingController(rootView: AccountView(store: store.scope(state: \.accountState,
                                                                                                action: AppAction.accountAction)))
    var cancellables: Set<AnyCancellable> = []
    
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
        
        setupAccountView()
        bindToStore()
    }
    
    func bindToStore() {
        let viewStore = ViewStore(store.scope(state: \.accountState,
                                              action: AppAction.accountAction))
        
        viewStore
            .publisher
            .currentScreen
            .sink { [weak self] screen in
                guard let screen = screen,
                      let self = self
                else { return }
                
                switch screen {
                case .login:
                    let loginVC = LoginViewController(store: self.store)
                    self.navigationController?.pushViewController(loginVC,
                                                                  animated: true)
                    break
                }
            }
            .store(in: &self.cancellables)
    }
    
    private func setupAccountView() {
        addChild(accountView)
        view.addSubview(accountView.view)
        accountView.didMove(toParent: self)
        
        accountView.view.frame = self.view.frame
    }
}


