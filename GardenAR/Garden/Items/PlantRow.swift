//
//  PlantRow.swift
//  GardenAR
//
//  Created by Aashish Kapoor on 11/14/23.
//

import SwiftUI

struct PlantRow: View {
    var body: some View {
        HStack(spacing: 16.0) {
            AsyncImage(url: URL(string: "https://cdn.shopify.com/s/files/1/0150/6262/products/the_sill-variant-white_gloss-money_tree.jpg?v=1699404852")) { image in
                image
                    .resizable()
                    .frame(width: 75.0, height: 75.0)
                    .clipShape(.rect(cornerRadius: 16.0))
            } placeholder: {
                ProgressView()
            }
            Text("Plant Type")
            Spacer()
        }
    }
}

#Preview {
    PlantRow()
}
