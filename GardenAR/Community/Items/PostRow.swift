//
//  Post.swift
//  GardenAR
//
//  Created by Aashish Kapoor on 11/17/23.
//

import Foundation
import SwiftUI

struct PostRow: View {
    @Binding var updates: Int
    @State var favorited = false
    @State var comments: [CommentModel] = []
    @State var post: PostModel?
    var postId: Int?
    
    func fetchContent() async {
        do {
            guard let postId = self.postId else {
                return
            }
            
            let (post, _) = try await PostNetwork.getPost(postId: postId)
            if let post = post {
                self.post = post
            }
        } catch {}
    }
    
    func fetchStatus() async {
        do {
            guard let token = UserDefaults.standard.string(forKey: "token") else {
                return
            }
            
            guard let postId = self.post?._post_id else {
                return
            }
            
            let (post, _) = try await PostNetwork.getFavorite(postId: postId, token: token)
            if let post = post {
                self.favorited = true
            }
        } catch {}
    }
    
    func fetchComments() async {
        do {
            guard let postId = self.post?._post_id else {
                return
            }
            
            let (comments, _) = try await CommentNetwork.getComments(postId: postId)
            if let comments = comments {
                self.comments = comments
            }
        } catch {}
    }
    
    func favorite() async {
        do {
            guard let token = UserDefaults.standard.string(forKey: "token") else {
                return
            }
            
            guard let postId = self.post?._post_id else {
                return
            }
            
            let e = try await PostNetwork.postFavorite(postId: postId, token: token)
            if e.error == nil {
                self.favorited = true
                self.updates += 1
            }
        } catch {}
    }
    
    func unfavorite() async {
        do {
            guard let token = UserDefaults.standard.string(forKey: "token") else {
                return
            }
            
            guard let postId = self.post?._post_id else {
                return
            }
            
            let e = try await PostNetwork.deleteFavorite(postId: postId, token: token)
            if e.error == nil {
                self.favorited = false
                self.updates += 1
            }
        } catch {}
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12.0) {
            Text(self.post?._content ?? "")
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
            
            Divider()
        }
        .task {
            await self.fetchContent()
            await self.fetchStatus()
            await self.fetchComments()
        }
    }
}

#Preview {
    NavigationStack {
        PostRow(updates: .constant(0), postId: -201)
    }
}
