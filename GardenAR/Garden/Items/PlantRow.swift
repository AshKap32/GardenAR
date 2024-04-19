//
//  PlantRow.swift
//  GardenAR
//
//  Created by Aashish Kapoor on 11/14/23.
//

import Foundation
import SwiftUI

struct PlantRow: View {
    @State var name = "Plant Type"
    @State var icon = "https://cdn.shopify.com/s/files/1/0150/6262/products/the_sill-variant-white_gloss-money_tree.jpg?v=1699404852"
    var plantId: Int
    
    func fetch() async {
        do {
            let (plant, _) = try await PlantNetwork.getPlant(plantId: plantId)
            guard let plant = plant else {
                return
            }
            
            let (compendium, _) = try await CompendiumNetwork.getCompendium(compendiumId: plant._compendium_id!)
            if let compendium = compendium {
                self.icon = compendium._icon!
                self.name = compendium._name!
            }
        } catch {}
    }
    
    var body: some View {
        NavigationLink(destination: PlantInfo(plantId: self.plantId)) {
            HStack(spacing: 12.0) {
                AsyncImage(url: URL(string: self.icon)) { image in
                    image
                        .image?
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 96.0, height: 96.0)
                        .clipShape(.rect(cornerRadius: 6.0))
                }
                
                Text(self.name)
                Spacer()
            }
        }
        .buttonStyle(.plain)
        .task {
            await self.fetch()
        }
    }
}

#Preview {
    NavigationStack {
        PlantRow(plantId: -501)
    }
}
