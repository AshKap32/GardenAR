//
//  SessionNetwork.swift
//  GardenAR
//
//  Created by KOBOLD! on 3/27/24.
//

import Foundation

struct SessionNetwork {
    static let host = Bundle.main.object(forInfoDictionaryKey: "BACKEND_HOST") ?? "localhost:80"
    static let encoder = JSONEncoder()
    static let decoder = JSONDecoder()
    
    static func getSession(token: String) async throws -> ErrorReply {
        let url = URL(string: "http://\(self.host)/session/account/token")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        let (data, _) = try await URLSession.shared.data(for: request)
        return try self.decoder.decode(ErrorReply.self, from: data)
    }
    
    static func postSession(username: String, password: String) async throws -> (String?, ErrorReply) {
        let url = URL(string: "http://\(self.host)/session")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = SessionRequest(_username: username, _password: password)
        request.httpBody = try self.encoder.encode(body)

        let (data, _) = try await URLSession.shared.data(for: request)
        let reply = try self.decoder.decode(SessionReply.self, from: data)
        let e = try self.decoder.decode(ErrorReply.self, from: data)
        return (reply._token, e)
    }
    
    static func deleteSession(token: String) async throws -> ErrorReply {
        let url = URL(string: "http://\(self.host)/session/account/token")!
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        let (data, _) = try await URLSession.shared.data(for: request)
        return try self.decoder.decode(ErrorReply.self, from: data)
    }
}
