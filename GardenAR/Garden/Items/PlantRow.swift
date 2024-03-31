//
//  PlantRow.swift
//  GardenAR
//
//  Created by Aashish Kapoor on 11/14/23.
//

import SwiftUI

struct PlantRow: View {
    @State var icon = "https://cdn.shopify.com/s/files/1/0150/6262/products/the_sill-variant-white_gloss-money_tree.jpg?v=1699404852"
    @State var name = "Plant Type"
    var compendiumId: Int?
    
    init(compendiumId: Int) {
        self.compendiumId = compendiumId
    }
    
    func fetch() async {
        do {
            guard let compendiumId = self.compendiumId else {
                return
            }
            
            let (compendium, _) = try await CompendiumNetwork.getCompendium(compendiumId: compendiumId)
            guard let compendium = compendium else {
                return
            }
            
            self.icon = compendium._icon!
            self.name = compendium._name!
        } catch {
            
        }
    }
    
    var body: some View {
        HStack(spacing: 16.0) {
            AsyncImage(url: URL(string: self.icon)) { image in
                image.resizable().frame(width: 75.0, height: 75.0).clipShape(.rect(cornerRadius: 16.0))
            } placeholder: {
                ProgressView()
            }
            
            Text(self.name)
            Spacer()
        }.task {
            await self.fetch()
        }
    }
}

#Preview {
    PlantRow(compendiumId: -401)
}
