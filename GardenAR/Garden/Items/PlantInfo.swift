//
//  PlantInfo.swift
//  GardenAR
//
//  Created by KOBOLD! on 4/4/24.
//

import Foundation
import SwiftUI

struct PlantInfo: View {
    @State var name = ""
    @State var description = ""
    @State var icon = ""
    @State var lighting = 0
    @State var depth = 0.0
    @State var spacing = 0.0
    @State var germination = 0
    @State var maturity = 0
    @State var timestamp = ""
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
            Text(self.description)
            AsyncImage(url: URL(string: self.icon)) { image in
                image
                    .image?
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 192.0, height: 192.0)
                    .clipShape(.rect(cornerRadius: 6.0))
            }
        }
        .navigationTitle(self.name)
        .navigationBarTitleDisplayMode(.inline)
        .scrollIndicators(.hidden)
        .padding(.horizontal, 24.0)
        .task {
            await self.fetch()
        }
    }
}

#Preview {
    NavigationStack {
        PlantInfo(plantId: -601)
    }
}
