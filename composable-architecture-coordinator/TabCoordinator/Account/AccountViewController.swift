//
//  SteadyViewController.swift
//  composable-architecture-coordinator
//
//  Created by Mateusz Uszyński on 25/10/2022.
//

import SwiftUI

class AccountViewController: UIViewController {
    private let accountView = UIHostingController(rootView: AccountView())
    
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
