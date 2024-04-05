//
//  CommentNetwork.swift
//  GardenAR
//
//  Created by KOBOLD! on 3/29/24.
//

import Foundation

struct CommentNetwork {
    static let host = "localhost:8080" // to do: extract this from some sort of config file
    static let encoder = JSONEncoder()
    static let decoder = JSONDecoder()
    
    static func getComments() async throws -> ([CommentModel]?, ErrorReply) {
        let url = URL(string: "http://\(self.host)/comments")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let reply = try self.decoder.decode(CommentReply.self, from: data)
        let e = try self.decoder.decode(ErrorReply.self, from: data)
        return (reply._comments, e)
    }
    
    static func getComments(postId: Int) async throws -> ([CommentModel]?, ErrorReply) {
        let url = URL(string: "http://\(self.host)/comments/post/\(postId)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let reply = try self.decoder.decode(CommentReply.self, from: data)
        let e = try self.decoder.decode(ErrorReply.self, from: data)
        return (reply._comments, e)
    }
    
    static func getComments(accountId: Int) async throws -> ([CommentModel]?, ErrorReply) {
        let url = URL(string: "http://\(self.host)/comments/account/\(accountId)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let reply = try self.decoder.decode(CommentReply.self, from: data)
        let e = try self.decoder.decode(ErrorReply.self, from: data)
        return (reply._comments, e)
    }
    
    static func getComments(token: String) async throws -> ([CommentModel]?, ErrorReply) {
        let url = URL(string: "http://\(self.host)/comments/account/token")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let reply = try self.decoder.decode(CommentReply.self, from: data)
        let e = try self.decoder.decode(ErrorReply.self, from: data)
        return (reply._comments, e)
    }
    
    static func getComment(commentId: Int) async throws -> (CommentModel?, ErrorReply) {
        let url = URL(string: "http://\(self.host)/comment/\(commentId)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let reply = try self.decoder.decode(CommentReply.self, from: data)
        let e = try self.decoder.decode(ErrorReply.self, from: data)
        return (reply._comment, e)
    }
    
    static func postComment(token: String, comment: CommentModel) async throws -> (CommentModel?, ErrorReply) {
        let url = URL(string: "http://\(self.host)/comment/account/token")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let body = CommentRequest(_comment: comment)
        request.httpBody = try self.encoder.encode(body)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let reply = try self.decoder.decode(CommentReply.self, from: data)
        let e = try self.decoder.decode(ErrorReply.self, from: data)
        return (reply._comment, e)
    }
    
    static func deleteComment(commentId: Int, token: String) async throws -> (CommentReply, ErrorReply) {
        fatalError()
    }
    
    static func patchComment(commentId: Int, token: String, comment: CommentModel) async throws -> (CommentModel?, ErrorReply) {
        let url = URL(string: "http://\(self.host)/comment/\(commentId)/account/token")!
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let body = CommentRequest(_comment: comment)
        request.httpBody = try self.encoder.encode(body)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let reply = try self.decoder.decode(CommentReply.self, from: data)
        let e = try self.decoder.decode(ErrorReply.self, from: data)
        return (reply._comment, e)
    }
}
