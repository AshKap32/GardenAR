//
//  GardenView.swift
//  GardenAR
//
//  Created by Aashish Kapoor on 11/10/23.
//

import Foundation
import SwiftUI

struct GardenView: View {
    @State var updates = 0
    @State var plants: [PlantModel] = []
    
    func fetch() async {
        do {
            guard let token = UserDefaults.standard.string(forKey: "token") else {
                return
            }
            
            let (plants, _) = try await PlantNetwork.getPlants(token: token)
            if let plants = plants {
                self.plants = plants
            }
        } catch {}
    }
    
    var body: some View {
        VStack {
            UserHeaderBar()
            ScrollView {
                LazyVStack(spacing: 12.0) {
                    ForEach(self.plants, id: \.self) { plant in
                        PlantRow(updates: self.$updates, plant: plant)
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
        .padding(.horizontal)
        .onChange(of: self.updates, initial: true) {
            Task {
                await self.fetch()
            }
        }
    }
}

#Preview {
    NavigationStack {
        GardenView()
    }
}
