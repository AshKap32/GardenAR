//
//  AddPostView.swift
//  GardenAR
//
//  Created by Rishi Jagtap on 5/3/24.
//

import Foundation
import SwiftUI

struct AddPostView: View {
    @Binding var isPresented: Bool
    @State private var postContent = ""
    @State var posts: [PostModel] = []
    @State var accounts: [AccountModel] = []

    var body: some View {
        NavigationView {
            VStack {
                Text("Create a New Post")
                    .font(.title)

                TextField("Enter your post here", text: $postContent)
                    .frame(minHeight: 100)

                Button("Post") {
                    Task {
                            await createNewPost(postContent: postContent)
                        }
                }
                .padding()
            }
            .padding()
            .navigationBarItems(trailing: Button("Cancel") {
                isPresented = false
            })
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func createNewPost(postContent: String) async {
        do {
            // create a newPost type PostModel
            let newPost = PostModel(_post_id: nil, _account_id: nil, _content: postContent, _timestamp: nil)
                    
            guard let token = UserDefaults.standard.string(forKey: "token") else { return }

            // Post the new post to the network
            try await PostNetwork.postPost(token: token, post: newPost)
                    
                 
            
        } catch {
            // Handle error
            print("Error creating post", error)
        }
    }
}



