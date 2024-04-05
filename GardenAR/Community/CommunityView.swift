//
//  CommunityView.swift
//  GardenAR
//
//  Created by Aashish Kapoor on 11/17/23.
//

import Foundation
import SwiftUI

struct CommunityView: View {
    @State var posts: [PostModel] = []
    @State var selectedSocialCategory = "All"
    
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
            
            self.posts = favorites.reversed()
        } catch {
            
        }
    }
    
    var body: some View {
        VStack {
            Picker("", selection: self.$selectedSocialCategory) {
                Text("All")
                    .tag("All")
                
                Text("Favorites")
                    .tag("Favorites")
            }
            .pickerStyle(.segmented)
            
            ScrollView {
                ForEach(self.posts, id: \.self) { post in
                    Post(postId: post._post_id!)
                    Divider()
                }
            }
            .scrollIndicators(.hidden)
        }
        .navigationTitle("Community")
        .padding(.horizontal, 32.0)
        .onChange(of: self.selectedSocialCategory, initial: true) {
            Task {
                self.selectedSocialCategory == "All" ? await self.fetchPosts() : await self.fetchFavorites()
            }
        }
    }
}

#Preview {
    CommunityView()
}
