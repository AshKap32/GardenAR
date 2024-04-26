//
//  DiscoverView.swift
//  GardenAR
//
//  Created by Aashish Kapoor on 11/17/23.
//

import Foundation
import SwiftUI

struct DiscoverView: View {
    @State var searchText = ""
    @State var categories: [CategoryModel] = []
    
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
            LazyVStack(spacing: 12.0) {
                ForEach(self.filter(), id: \.self) { category in
                    DiscoverRow(category: category)
                }
            }
        }
        .scrollIndicators(.hidden)
        .searchable(text: self.$searchText, placement: .navigationBarDrawer(displayMode: .always))
        .textInputAutocapitalization(.never)
        .autocorrectionDisabled()
        .navigationTitle("Discover")
        .navigationBarTitleDisplayMode(.large)
        .padding(.horizontal)
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
