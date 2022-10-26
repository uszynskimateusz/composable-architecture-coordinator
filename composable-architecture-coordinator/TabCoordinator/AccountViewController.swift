//
//  SteadyViewController.swift
//  composable-architecture-coordinator
//
//  Created by Mateusz Uszyński on 25/10/2022.
//

import UIKit

class AccountViewController: UIViewController {
    
    var didSendEventClosure: ((AccountViewController.Event) -> Void)?
    
    private let steadyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Account", for: .normal)
        button.backgroundColor = .systemYellow
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8.0
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        view.addSubview(steadyButton)
        
        steadyButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            steadyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            steadyButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            steadyButton.widthAnchor.constraint(equalToConstant: 200),
            steadyButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        steadyButton.addTarget(self, action: #selector(didTapSteadyButton(_:)), for: .touchUpInside)
    }
    
    deinit {
        print("SteadyViewController deinit")
    }
    
    @objc private func didTapSteadyButton(_ sender: Any) {
        didSendEventClosure?(.steady)
    }
}

extension AccountViewController {
    enum Event {
        case steady
    }
}
