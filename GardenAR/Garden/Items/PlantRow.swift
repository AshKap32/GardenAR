//
//  PlantRow.swift
//  GardenAR
//
//  Created by Aashish Kapoor on 11/14/23.
//

import Foundation
import SwiftUI

struct PlantRow: View {
    @Binding var updates: Int
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
        } catch {}
    }
    
    func delete() async {
        do {
            guard let token = UserDefaults.standard.string(forKey: "token") else {
                return
            }
            
            guard let plantId = self.plant?._plant_id else {
                return
            }
            
            let e = try await PlantNetwork.deletePlant(plantId: plantId, token: token)
            if e.error == nil {
                self.updates += 1
            }
        } catch {}
    }
    
    var body: some View {
        NavigationLink(destination: PlantInfo(compendium: self.compendium, plant: self.plant)) {
            HStack(spacing: 12.0) {
                AsyncImage(url: URL(string: self.compendium?._icon ?? "")) { image in
                    image.image?
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: 96.0, height: 96.0)
                .clipShape(.rect(cornerRadius: 6.0))
                
                Text(self.compendium?._name ?? "")
                Spacer()
                Button(action: {
                    Task {
                        await self.delete()
                    }
                }) {
                    Image(systemName: "trash")
                }
                .buttonStyle(.plain)
            }
        }
        .buttonStyle(.plain)
        .task {
            await self.fetchPlant()
            await self.fetchCompendium()
        }
    }
}

#Preview {
    NavigationStack {
        PlantRow(updates: .constant(0), plantId: -601)
    }
}
