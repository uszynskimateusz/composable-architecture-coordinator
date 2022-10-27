//
//  SteadyViewController.swift
//  composable-architecture-coordinator
//
//  Created by Mateusz Uszyński on 25/10/2022.
//

import SwiftUI
import ComposableArchitecture

class AccountViewController: UIViewController {
    private lazy var accountView = UIHostingController(rootView: AccountView(store: store.scope(state: \.accountState,
                                                                                                action: AppAction.accountAction)))
    
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
    }
    
    private func setupAccountView() {
        addChild(accountView)
        view.addSubview(accountView.view)
        accountView.didMove(toParent: self)
        
        accountView.view.frame = self.view.frame
    }
}


