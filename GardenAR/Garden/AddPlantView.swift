//
//  GardenEditView.swift
//  GardenAR
//
//  Created by KOBOLD! on 4/22/24.
//

import Foundation
import SwiftUI

struct AddPlantView: View {
    @State var searchText = ""
    @State var compendia: [CompendiumModel] = []
    
    func fetch() async {
        do {
            let (compendia, _) = try await CompendiumNetwork.getCompendia()
            if let compendia = compendia {
                self.compendia = compendia
            }
        } catch {}
    }
    
    func filter() -> [CompendiumModel] {
        let query = self.searchText.lowercased()
        if query.isEmpty {
            return self.compendia
        } else {
            return self.compendia.filter { compendium in
                let name = compendium._name!.lowercased()
                return name.contains(query)
            }
        }
    }
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(self.filter(), id: \.self) { compendium in
                    AddPlantRow(compendium: compendium)
                }
            }
        }
        .scrollIndicators(.hidden)
        .searchable(text: self.$searchText, placement: .navigationBarDrawer(displayMode: .always))
        .textInputAutocapitalization(.never)
        .autocorrectionDisabled()
        .navigationTitle("Add plant")
        .navigationBarTitleDisplayMode(.inline)
        .padding(.horizontal, 24.0)
        .task {
            await self.fetch()
        }
    }
}

#Preview {
    NavigationStack {
        AddPlantView()
    }
}
