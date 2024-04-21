//
//  PlantInfo.swift
//  GardenAR
//
//  Created by KOBOLD! on 4/4/24.
//

import Foundation
import SwiftUI

struct PlantInfo: View {
    @State var name = "Plant Type"
    @State var description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    @State var icon = "https://cdn.shopify.com/s/files/1/0150/6262/products/the_sill-variant-white_gloss-money_tree.jpg?v=1699404852"
    @State var lighting = 6
    @State var depth = 0.25
    @State var spacing = 24.0
    @State var germination = 14
    @State var maturity = 70
    @State var timestamp = "2025-03-01 01:02:03"
    var plantId: Int
    
    func fetch() async {
        do {
            let (plant, _) = try await PlantNetwork.getPlant(plantId: self.plantId)
            guard let plant = plant else {
                return
            }
            
            let (compendium, _) = try await CompendiumNetwork.getCompendium(compendiumId: plant._compendium_id!)
            if let compendium = compendium {
                self.icon = compendium._icon!
                self.name = compendium._name!
                self.description = compendium._description!
                self.lighting = compendium._lighting!
                self.depth = Double(compendium._depth!)!
                self.spacing = Double(compendium._spacing!)!
                self.germination = compendium._germination!
                self.maturity = compendium._maturity!
                self.timestamp = plant._timestamp!
            }
        } catch {}
    }
    
    var body: some View {
        ScrollView {
            AsyncImage(url: URL(string: self.icon)) { image in
                image
                    .image?
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 192.0, height: 192.0)
                    .clipShape(.rect(cornerRadius: 6.0))
            }
            
            Text(self.name)
                .font(.title2)
                .fontWeight(.bold)
            
            Text(self.description)
        }
        .scrollIndicators(.hidden)
        .padding(.horizontal, 24.0)
        .task {
            await self.fetch()
        }
    }
}

#Preview {
    PlantInfo(plantId: -601)
}
