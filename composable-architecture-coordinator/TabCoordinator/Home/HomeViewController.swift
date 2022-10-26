//
//  ReadyViewController.swift
//  composable-architecture-coordinator
//
//  Created by Mateusz Uszyński on 25/10/2022.
//

import SwiftUI

class HomeViewController: UIViewController {
    private let homeView = UIHostingController(rootView: HomeView())
    
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
