//
//  ProductView.swift
//  composable-architecture-coordinator
//
//  Created by Mateusz Uszyński on 26/10/2022.
//

import SwiftUI

struct ProductView: View {
    var product: Product
    
    var body: some View {
        HStack {
            Text(product.name)
            Spacer()
            Button {
                print("Edit button was tapped")
            } label: {
                Image(systemName: product.isFav ? "heart.fill" : "heart")
            }
        }
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        let product = Product(name: "John")
        
        ProductView(product: product)
    }
}
