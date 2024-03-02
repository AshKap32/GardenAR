//
//  CommunityView.swift
//  GardenAR
//
//  Created by Aashish Kapoor on 11/17/23.
//

import SwiftUI

struct CommunityView: View {
    
    @State var selectedSocialCategory = "Favorites"
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24.0) {
                Picker(selection: $selectedSocialCategory) {
                    Text("Favorites").tag("Favorites")
                    Text("All").tag("All")
                } label: {}
                    .pickerStyle(.segmented)
                ForEach(0..<3) { post in
                    Post()
                    Divider()
                }
            }
        }
        .padding(.horizontal, 24.0)
        .navigationTitle("Community")
    }
}

#Preview {
    CommunityView()
}
