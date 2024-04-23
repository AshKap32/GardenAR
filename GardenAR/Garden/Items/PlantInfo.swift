//
//  PlantInfo.swift
//  GardenAR
//
//  Created by KOBOLD! on 4/4/24.
//

import Foundation
import SwiftUI

struct PlantInfo: View {
    @State var compendium: CompendiumModel?
    @State var plant: PlantModel?
    var plantId: Int?
    
    func fetchPlant() async {
        do {
            guard let plantId = self.plantId else {
                return
            }
            
            let (plant, _) = try await PlantNetwork.getPlant(plantId: plantId)
            if let plant = plant {
                self.plant = plant
            }
        } catch {}
    }
    
    func fetchCompendium() async {
        do {
            guard let compendiumId = self.plant?._compendium_id else {
                return
            }
            
            let (compendium, _) = try await CompendiumNetwork.getCompendium(compendiumId: compendiumId)
            if let compendium = compendium {
                self.compendium = compendium
            }
        } catch{}
    }
    
    var body: some View {
        ScrollView {
            Text(self.compendium?._description ?? "")
            AsyncImage(url: URL(string: self.compendium?._icon ?? "")) { image in
                image.image?
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .frame(width: 192.0, height: 192.0)
            .clipShape(.rect(cornerRadius: 6.0))
        }
        .scrollIndicators(.hidden)
        .navigationTitle(self.compendium?._name ?? "")
        .navigationBarTitleDisplayMode(.inline)
        .padding(.horizontal, 24.0)
        .task {
            await self.fetchPlant()
            await self.fetchCompendium()
        }
    }
}

#Preview {
    NavigationStack {
        PlantInfo(plantId: -601)
    }
}
