//
//  SearchView.swift
//  GardenAR
//
//  Created by Aashish Kapoor on 11/10/23.
//

import Foundation
import SwiftUI

struct SearchView: View {
    @State var compendia: [CompendiumModel] = []
    @State var searchText = ""
    
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
        return query.isEmpty ? self.compendia : self.compendia.filter { compendia in
            let name = compendia._name!.lowercased()
            return name.contains(query)
        }
    }
    
    var body: some View {
        ScrollView {
            ForEach(self.filter(), id: \.self) { compendium in
                CompendiumRow(compendiumId: compendium._compendium_id!)
            }
        }
        .scrollIndicators(.hidden)
        .searchable(text: self.$searchText, placement: .navigationBarDrawer(displayMode: .always))
        .padding(.horizontal, 24.0)
        .task {
            await self.fetch()
        }
    }
}

#Preview {
    NavigationStack {
        SearchView()
    }
}
