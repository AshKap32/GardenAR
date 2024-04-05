//
//  Post.swift
//  GardenAR
//
//  Created by Aashish Kapoor on 11/17/23.
//

import Foundation
import SwiftUI

struct Post: View {
    @State var content = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    @State var favorited = false
    var postId: Int
    
    func fetchContent() async {
        do {
            let (post, _) = try await PostNetwork.getPost(postId: self.postId)
            guard let post = post else {
                return
            }
            
            self.content = post._content!
        } catch {
            
        }
    }
    
    func fetchStatus() async {
        do {
            guard let token = UserDefaults.standard.string(forKey: "token") else {
                return
            }
            
            let (post, _) = try await PostNetwork.getFavorite(postId: self.postId, token: token)
            guard let post = post else {
                self.favorited = false
                return
            }
            
            self.favorited = true
        } catch {
            
        }
    }
    
    func favorite() async {
        do {
            guard let token = UserDefaults.standard.string(forKey: "token") else {
                return
            }
            
            let (post, _) = try await PostNetwork.postFavorite(postId: self.postId, token: token)
            guard let post = post else {
                return
            }
            
            self.favorited = true
        } catch {
            
        }
    }
    
    func unfavorite() async {
        do {
            guard let token = UserDefaults.standard.string(forKey: "token") else {
                return
            }
            
            let (post, _) = try await PostNetwork.deleteFavorite(postId: self.postId, token: token)
            guard let post = post else {
                return
            }
            
            self.favorited = false
        } catch {
            
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16.0) {
            Text(self.content)
            HStack {
                Button(action: {
                    Task {
                        self.favorited ? await self.unfavorite() : await self.favorite()
                    }
                }) {
                    Image(systemName: self.favorited ? "heart.fill" : "heart")
                }
                
                
                Spacer()
                Button(action: {}) {
                    Image(systemName: "bubble.left.and.text.bubble.right")
                }
                
                Spacer()
                Button(action: {}) {
                    Image(systemName: "arrowshape.turn.up.right")
                }
            }
        }
        .task {
            await self.fetchContent()
            await self.fetchStatus()
        }
    }
}

#Preview {
    Post(postId: -201)
}
