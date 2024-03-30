//
//  Post.swift
//  GardenAR
//
//  Created by Aashish Kapoor on 11/17/23.
//

import SwiftUI

struct Post: View {
    @State var content = ""
    @State var favorited = false
    var postId: Int

    init(postId: Int) {
        self.postId = postId
    }
    
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
            
            let (post, e) = try await PostNetwork.postFavorite(postId: self.postId, token: token)
            guard let post = post else {
                print(e)
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
            
            let (post, e) = try await PostNetwork.deleteFavorite(postId: self.postId, token: token)
            guard let post = post else {
                print(e)
                return
            }
            
            self.favorited = false
        } catch {
            
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16.0) {
            Text(self.content)
            HStack(spacing: 8.0) {
                if self.favorited {
                    Button(action: {
                        Task {
                            await self.unfavorite()
                        }
                    }) {
                        Image(systemName: "heart.fill")
                    }
                } else {
                    Button(action: {
                        Task {
                            await self.favorite()
                        }
                    }) {
                        Image(systemName: "heart")
                    }
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
        }.task {
            await self.fetchContent()
            await self.fetchStatus()
        }
    }
}

#Preview {
    Post(postId: -201)
}
