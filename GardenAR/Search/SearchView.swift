//
//  SearchView.swift
//  GardenAR
//
//  Created by Aashish Kapoor on 11/10/23.
//

import Foundation
import SwiftUI

struct SearchView: View {
    @State var searchText = ""
    @State var compendia: [CompendiumModel] = []
    @State var category: CategoryModel?
    
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
            guard let categoryId = self.category?._category_id else {
                return
            }
            
            let (compendia, _) = try await CompendiumNetwork.getCompendia(categoryId: categoryId)
            if let compendia = compendia {
                self.compendia = compendia
            }
        } catch {}
    }
    
    func filter() -> [CompendiumModel] {
        let query = self.searchText.lowercased()
        return query.isEmpty ? self.compendia : self.compendia.filter { compendium in
            let name = compendium._name!.lowercased()
            return name.contains(query)
        }
    }
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(self.filter(), id: \.self) { compendium in
                    CompendiumRow(compendium: compendium)
                }
            }
        }
        .scrollIndicators(.hidden)
        .searchable(text: self.$searchText, placement: .navigationBarDrawer(displayMode: .always))
        .textInputAutocapitalization(.never)
        .autocorrectionDisabled()
        .navigationTitle(self.category?._name ?? "Search")
        .navigationBarTitleDisplayMode(.inline)
        .padding(.horizontal, 24.0)
        .task {
            self.category == nil ? await self.fetchAll() : await self.fetchCategory()
        }
    }
}

#Preview {
    NavigationStack {
        SearchView()
    }
}
