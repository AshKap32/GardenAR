//
//  PostNetwork.swift
//  GardenAR
//
//  Created by KOBOLD! on 3/27/24.
//

import Foundation

struct PostNetwork {
    static let host = "localhost:8080" // to do: extract this from some sort of config file
    
    static func getPosts() async throws -> ([PostModel]?, ErrorReply) {
        let url = URL(string: "http://\(self.host)/posts")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"

        let (data, _) = try await URLSession.shared.data(for: request)
        let reply = try JSONDecoder().decode(PostReply.self, from: data)
        let e = try JSONDecoder().decode(ErrorReply.self, from: data)
        return (reply._posts, e)
    }
    
    static func getPosts(accountId: Int) async throws -> ([PostModel]?, ErrorReply) {
        let url = URL(string: "http://\(self.host)/posts/account/\(accountId)")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"

        let (data, _) = try await URLSession.shared.data(for: request)
        let reply = try JSONDecoder().decode(PostReply.self, from: data)
        let e = try JSONDecoder().decode(ErrorReply.self, from: data)
        return (reply._posts, e)
    }
    
    static func getPosts(token: String) async throws -> ([PostModel]?, ErrorReply) {
        let url = URL(string: "http://\(self.host)/posts/account/token")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"

        let (data, _) = try await URLSession.shared.data(for: request)
        let reply = try JSONDecoder().decode(PostReply.self, from: data)
        let e = try JSONDecoder().decode(ErrorReply.self, from: data)
        return (reply._posts, e)
    }
    
    static func getFavorites(accountId: Int) async throws -> ([PostModel]?, ErrorReply) {
        let url = URL(string: "http://\(self.host)/posts/favorites/account/\(accountId)")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"

        let (data, _) = try await URLSession.shared.data(for: request)
        let reply = try JSONDecoder().decode(PostReply.self, from: data)
        let e = try JSONDecoder().decode(ErrorReply.self, from: data)
        return (reply._posts, e)
    }
    
    static func getFavorites(token: String) async throws -> ([PostModel]?, ErrorReply) {
        let url = URL(string: "http://\(self.host)/posts/favorites/account/token")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"

        let (data, _) = try await URLSession.shared.data(for: request)
        let reply = try JSONDecoder().decode(PostReply.self, from: data)
        let e = try JSONDecoder().decode(ErrorReply.self, from: data)
        return (reply._posts, e)
    }
    
    static func getPost(postId: Int) async throws -> (PostModel?, ErrorReply) {
        let url = URL(string: "http://\(self.host)/post/\(postId)")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"

        let (data, _) = try await URLSession.shared.data(for: request)
        let reply = try JSONDecoder().decode(PostReply.self, from: data)
        let e = try JSONDecoder().decode(ErrorReply.self, from: data)
        return (reply._post, e)
    }
    
    static func postPost(token: String = "", post: PostModel) async throws -> (PostModel?, ErrorReply) {
        let url = URL(string: "http://\(self.host)/post/account/token")!
        let body = PostRequest(_post: post)
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.httpBody = try JSONEncoder().encode(body)

        let (data, _) = try await URLSession.shared.data(for: request)
        let reply = try JSONDecoder().decode(PostReply.self, from: data)
        let e = try JSONDecoder().decode(ErrorReply.self, from: data)
        return (reply._post, e)
    }
    
    static func postFavorite(postId: Int, token: String = "") async throws -> (PostModel?, ErrorReply) {
        let url = URL(string: "http://\(self.host)/posts/favorite/\(postId)/account/token")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"

        let (data, _) = try await URLSession.shared.data(for: request)
        let reply = try JSONDecoder().decode(PostReply.self, from: data)
        let e = try JSONDecoder().decode(ErrorReply.self, from: data)
        return (reply._post, e)
    }
    
    static func deletePost(postId: Int, token: String = "") async throws -> (PostReply, ErrorReply) {
        fatalError() // to do: actually implement this
    }
    
    static func deleteFavorite(postId: Int, token: String = "") async throws -> (PostModel?, ErrorReply) {
        let url = URL(string: "http://\(self.host)/posts/favorite/\(postId)/account/token")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "DELETE"

        let (data, _) = try await URLSession.shared.data(for: request)
        let reply = try JSONDecoder().decode(PostReply.self, from: data)
        let e = try JSONDecoder().decode(ErrorReply.self, from: data)
        return (reply._post, e)
    }
    
    static func patchPost(postId: Int, token: String = "", post: PostModel) async throws -> (PostModel?, ErrorReply) {
        let url = URL(string: "http://\(self.host)/post/\(postId)/account/token")!
        let body = PostRequest(_post: post)
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "PATCH"
        request.httpBody = try JSONEncoder().encode(body)

        let (data, _) = try await URLSession.shared.data(for: request)
        let reply = try JSONDecoder().decode(PostReply.self, from: data)
        let e = try JSONDecoder().decode(ErrorReply.self, from: data)
        return (reply._post, e)
    }
}
