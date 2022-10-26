//
//  HomeView.swift
//  composable-architecture-coordinator
//
//  Created by Mateusz Uszyński on 26/10/2022.
//

import SwiftUI

struct HomeView: View {
    private let items = (1...100).map { Product(name: "Item \($0)") }
    
    var body: some View {
        List(items) { item in
            ProductView(product: item)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
