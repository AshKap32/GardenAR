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
                Picker(selection: self.$selectedSocialCategory) {
                    Text("Favorites").tag("Favorites")
                    Text("All").tag("All")
                } label: {
                    
                }
                .pickerStyle(.segmented)
                
                ForEach(0 ..< 3) { i in
                    Post(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
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
