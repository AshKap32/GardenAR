//
//  AddPlantRow.swift
//  GardenAR
//
//  Created by KOBOLD! on 4/22/24.
//

import Foundation
import SwiftUI

struct AddPlantRow: View {
    @Environment(\.dismiss) var dismiss
    @State var compendium: CompendiumModel?
    var compendiumId: Int?
    
    func fetch() async {
        do {
            guard let compendiumId = self.compendiumId else {
                return
            }
            
            let (compendium, _) = try await CompendiumNetwork.getCompendium(compendiumId: compendiumId)
            if let compendium = compendium {
                self.compendium = compendium
            }
        } catch {}
    }
    
    func add() async -> Bool {
        do {
            guard let token = UserDefaults.standard.string(forKey: "token") else {
                return false
            }
            
            guard let compendiumId = self.compendium?._compendium_id else {
                return false
            }
            
            let (plant, _) = try await PlantNetwork.postPlant(token: token, plant: PlantModel(_compendium_id: compendiumId))
            if let plant = plant {
                return true
            } else {
                return false
            }
        } catch {
            return false
        }
    }
    
    var body: some View {
        Button(action: {
            Task {
                if await self.add() {
                    self.dismiss()
                }
            }
        }) {
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
        AddPlantRow(compendiumId: -401)
    }
}
