//
//  SearchView.swift
//  GardenAR
//
//  Created by Aashish Kapoor on 11/10/23.
//

import SwiftUI

struct SearchView: View {
    @State var compendia: [CompendiumModel] = []
    @State var searchText = ""
    
    func fetch() async {
        do {
            let (compendia, _) = try await CompendiumNetwork.getCompendia()
            guard let compendia = compendia else {
                return
            }
            
            self.compendia = compendia
        } catch {
            
        }
    }
    
    var body: some View {
        List {
            ForEach(self.compendia, id: \.self) { compendium in
                PlantRow(compendiumId: compendium._compendium_id!)
            }
        }
        .navigationTitle("Search")
        .searchable(text: self.$searchText)
        .task {
            await self.fetch()
        }
    }
}

#Preview {
    SearchView()
}
