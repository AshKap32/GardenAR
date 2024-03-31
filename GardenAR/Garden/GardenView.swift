//
//  GardenView.swift
//  GardenAR
//
//  Created by Aashish Kapoor on 11/10/23.
//

import SwiftUI

struct GardenView: View {
    @State var plants: [PlantModel] = []
    
    func fetch() async {
        do {
            guard let token = UserDefaults.standard.string(forKey: "token") else {
                return
            }
            
            let (plants, _) = try await PlantNetwork.getPlants(token: token)
            guard let plants = plants else {
                return
            }
            
            self.plants = plants
        } catch {
            
        }
    }
    
    var body: some View {
        ScrollView {
            Group {
                UserHeaderBar()
                ForEach(self.plants, id: \.self) { plant in
                    PlantRow(compendiumId: plant._compendium_id!)
                }
            }
            .padding(24.0)
        }.task {
            await self.fetch()
        }
    }
}

#Preview {
    GardenView()
}
