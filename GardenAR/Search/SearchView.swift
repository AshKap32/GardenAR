//
//  SearchView.swift
//  GardenAR
//
//  Created by Aashish Kapoor on 11/10/23.
//

import SwiftUI

struct SearchView: View {
    
    @State var searchText = ""
    
    var body: some View {
        List {
            PlantRow()
        }
        .navigationTitle("Search")
        .searchable(text: $searchText)
    }
}

#Preview {
    SearchView()
}
