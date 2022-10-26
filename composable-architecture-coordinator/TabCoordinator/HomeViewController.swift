//
//  ReadyViewController.swift
//  composable-architecture-coordinator
//
//  Created by Mateusz Uszyński on 25/10/2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    var didSendEventClosure: ((HomeViewController.Event) -> Void)?
    
    private let readyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Home", for: .normal)
        button.backgroundColor = .systemRed
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8.0
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        view.addSubview(readyButton)
        
        readyButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            readyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            readyButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            readyButton.widthAnchor.constraint(equalToConstant: 200),
            readyButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        readyButton.addTarget(self, action: #selector(didTapReadyButton(_:)), for: .touchUpInside)
    }
    
    deinit {
        print("ReadyViewController deinit")
    }
    
    @objc private func didTapReadyButton(_ sender: Any) {
        didSendEventClosure?(.ready)
    }
}

extension HomeViewController {
    enum Event {
        case ready
    }
}
