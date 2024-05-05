//
//  CommunityView.swift
//  GardenAR
//
//  Created by Aashish Kapoor on 11/17/23.
//

import Foundation
import SwiftUI

struct CommunityView: View {
    @State var selectedSocialCategory = "All"
    @State private var isAddPostViewPresented = false
    @State var updates = 0
    @State var posts: [PostModel] = []
    @State var content = ""

    
    func fetchPosts() async {
        do {
            let (posts, _) = try await PostNetwork.getPosts()
            if let posts = posts {
                self.posts = posts.reversed()
            }
        } catch {}
    }
    
    func fetchFavorites() async {
        do {
            guard let token = UserDefaults.standard.string(forKey: "token") else {
                return
            }
            
            let (favorites, _) = try await PostNetwork.getFavorites(token: token)
            if let favorites = favorites {
                self.posts = favorites.reversed()
            }
        } catch {}
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
                LazyVStack(spacing: 12.0) {
                    ForEach(self.posts, id: \.self) { post in
                        PostRow(updates: self.$updates, post: post)
                    }
                }
            }
            .scrollIndicators(.hidden)
            Button(action: {
                isAddPostViewPresented = true // Update isAddPostViewPresented when button is tapped
                
            }, label: {
                Image(systemName: "plus")
                    .padding()
            })
            
            
        }
        .sheet(isPresented: $isAddPostViewPresented, content: {
            AddPostView(isPresented: $isAddPostViewPresented)
        })
        .onChange(of: self.isAddPostViewPresented, initial: true)
        {
            Task{
                await self.fetchPosts()
            }
        }
        .navigationTitle("Community")
        .navigationBarTitleDisplayMode(.large)
        .padding(.horizontal)
        .onChange(of: self.selectedSocialCategory, initial: true) {
            Task {
                self.selectedSocialCategory == "All" ? await self.fetchPosts() : await self.fetchFavorites()
            }
        }
        .onChange(of: self.updates, initial: false) {
            Task {
                if self.selectedSocialCategory == "Favorites" {
                    await self.fetchFavorites()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        CommunityView()
    }
}
