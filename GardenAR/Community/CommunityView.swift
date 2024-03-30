//
//  CommunityView.swift
//  GardenAR
//
//  Created by Aashish Kapoor on 11/17/23.
//

import SwiftUI

struct CommunityView: View {
    @State var selectedSocialCategory = "All"
    @State var posts: [PostModel] = []
    @State var favorites: [PostModel] = []
    
    func fetchPosts() async {
        do {
            let (posts, _) = try await PostNetwork.getPosts()
            guard let posts = posts else {
                return
            }
            
            self.posts = posts.reversed()
        } catch {
            
        }
    }
    
    func fetchFavorites() async {
        do {
            guard let token = UserDefaults.standard.string(forKey: "token") else {
               return
            }
            
            let (favorites, _) = try await PostNetwork.getFavorites(token: token)
            guard let favorites = favorites else {
               return
            }
            
            self.favorites = favorites.reversed()
        } catch {
            
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24.0) {
                Picker(selection: self.$selectedSocialCategory) {
                    Text("All").tag("All")
                    Text("Favorites").tag("Favorites")
                } label: {
                    
                }
                .pickerStyle(.segmented)
                
                if self.selectedSocialCategory == "All" {
                    ForEach(self.posts.indices, id: \.self) { i in
                        Post(text: self.posts[i]._content!)
                        Divider()
                    }
                } else {
                    ForEach( self.favorites.indices, id: \.self) { i in
                        Post(text: self.favorites[i]._content!)
                        Divider()
                    }
                }
            }
        }
        .padding(.horizontal, 24.0)
        .navigationTitle("Community")
        .task {
            Task {
                await self.fetchPosts()
                await self.fetchFavorites()
            }
        }
    }
}

#Preview {
    CommunityView()
}
