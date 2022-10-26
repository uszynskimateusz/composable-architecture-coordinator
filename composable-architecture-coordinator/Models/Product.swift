//
//  Product.swift
//  composable-architecture-coordinator
//
//  Created by Mateusz Uszyński on 26/10/2022.
//

import Foundation

struct Product: Identifiable {
    let id = UUID()
    let name: String
    var isFav = false
}
