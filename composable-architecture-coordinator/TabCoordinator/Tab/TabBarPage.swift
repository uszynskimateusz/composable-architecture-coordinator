//
//  TabBarPage.swift
//  composable-architecture-coordinator
//
//  Created by Mateusz Uszyński on 27/10/2022.
//

import UIKit

enum TabBarPage {
    case home
    case account
    case favorites
    
    init?(index: Int) {
        switch index {
        case 0:
            self = .home
        case 1:
            self = .account
        case 2:
            self = .favorites
        default:
            return nil
        }
    }
    
    func pageTitleValue() -> String {
        switch self {
        case .home:
            return "Home"
        case .account:
            return "Account"
        case .favorites:
            return "Favorites"
        }
    }
    
    func pageOrderNumber() -> Int {
        switch self {
        case .home:
            return 0
        case .account:
            return 1
        case .favorites:
            return 2
        }
    }
    
    func icon() -> UIImage {
        switch self {
        case .home:
            return UIImage(systemName: "house.fill")!
        case .account:
            return UIImage(systemName: "person.fill")!
        case .favorites:
            return UIImage(systemName: "heart.fill")!
        }
    }
}
