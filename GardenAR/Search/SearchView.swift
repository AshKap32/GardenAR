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
    var categoryId: Int?
    var name: String = "Search"
    
    func fetchAll() async {
        do {
            let (compendia, _) = try await CompendiumNetwork.getCompendia()
            if let compendia = compendia {
                self.compendia = compendia
            }
        } catch {}
    }
    
    func fetchCategory() async {
        do {
            let (compendia, _) = try await CompendiumNetwork.getCompendia(categoryId: self.categoryId!)
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
                    CompendiumRow(name: compendium._name!, icon: compendium._icon!, compendiumId: compendium._compendium_id!)
                }
            }
        }
        .scrollIndicators(.hidden)
        .searchable(text: self.$searchText, placement: .navigationBarDrawer(displayMode: .always))
        .textInputAutocapitalization(.never)
        .autocorrectionDisabled()
        .navigationTitle(self.name)
        .navigationBarTitleDisplayMode(.inline)
        .padding(.horizontal, 24.0)
        .task {
            if self.categoryId == nil {
                await self.fetchAll()
            } else {
                await self.fetchCategory()
            }
        }
    }
}

#Preview {
    NavigationStack {
        SearchView()
    }
}
