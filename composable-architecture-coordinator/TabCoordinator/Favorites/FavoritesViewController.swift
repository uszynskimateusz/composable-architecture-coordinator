//
//  FavoritesViewController.swift
//  composable-architecture-coordinator
//
//  Created by Mateusz Uszyński on 27/10/2022.
//

import SwiftUI
import ComposableArchitecture

class FavoritesViewController: UIViewController {
    private lazy var favoritesView = UIHostingController(rootView: FavoritesView(store: store.scope(state: \.homeState,
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
        addChild(favoritesView)
        view.addSubview(favoritesView.view)
        favoritesView.didMove(toParent: self)
        
        favoritesView.view.frame = self.view.frame
    }
}

