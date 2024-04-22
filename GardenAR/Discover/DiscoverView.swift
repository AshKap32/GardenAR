//
//  DiscoverView.swift
//  GardenAR
//
//  Created by Aashish Kapoor on 11/17/23.
//

import Foundation
import SwiftUI

struct DiscoverView: View {
    @State var categories: [CategoryModel] = []
    @State var searchText = ""
    
    func fetch() async {
        do {
            let (categories, _) = try await CategoryNetwork.getCategories()
            if let categories = categories {
                self.categories = categories
            }
        } catch {}
    }
    
    func filter() -> [CategoryModel] {
        let query = self.searchText.lowercased()
        return query.isEmpty ? self.categories : self.categories.filter { category in
            let name = category._name!.lowercased()
            return name.contains(query)
        }
    }
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(self.filter(), id: \.self) { category in
                    DiscoverRow(name: category._name!, icon: category._icon!, categoryId: category._category_id!)
                }
            }
        }
        .scrollIndicators(.hidden)
        .searchable(text: self.$searchText, placement: .navigationBarDrawer(displayMode: .always))
        .textInputAutocapitalization(.never)
        .autocorrectionDisabled()
        .navigationTitle("Discover")
        .navigationBarTitleDisplayMode(.inline)
        .padding(.horizontal, 24.0)
        .task {
            await self.fetch()
        }
    }
}

#Preview {
    NavigationStack {
        DiscoverView()
    }
}
