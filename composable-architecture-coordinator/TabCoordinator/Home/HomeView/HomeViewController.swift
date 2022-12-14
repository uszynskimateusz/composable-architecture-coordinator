//
//  ReadyViewController.swift
//  composable-architecture-coordinator
//
//  Created by Mateusz Uszyński on 25/10/2022.
//

import SwiftUI
import ComposableArchitecture

class HomeViewController: UIViewController {
    private lazy var homeView = UIHostingController(rootView: HomeView(store: store.scope(state: \.homeState,
                                                                                          action: AppAction.homeAction)))
    
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
        
        setupHomeView()
    }
    
    private func setupHomeView() {
        addChild(homeView)
        view.addSubview(homeView.view)
        homeView.didMove(toParent: self)
        
        homeView.view.frame = self.view.frame
    }
}
