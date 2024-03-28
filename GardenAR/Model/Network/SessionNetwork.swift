//
//  SessionNetwork.swift
//  GardenAR
//
//  Created by KOBOLD! on 3/27/24.
//

import Foundation

struct SessionNetwork {
    static let host = "localhost:8080" // to do: extract this from some sort of config file
    
    static func extract(request: URLRequest) async throws -> (SessionReply, ErrorReply) {
        let (data, _) = try await URLSession.shared.data(for: request)
        let reply = try JSONDecoder().decode(SessionReply.self, from: data)
        let e = try JSONDecoder().decode(ErrorReply.self, from: data)
        return (reply, e)
    }
    
    static func getSession() async throws -> (SessionReply, ErrorReply) {
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        let url = URL(string: "http://\(self.host)/session/account/token")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        return try await self.extract(request: request)
    }
    
    static func postSession(username: String, password: String) async throws -> (SessionReply, ErrorReply) {
        let url = URL(string: "http://\(self.host)/session")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = try JSONEncoder().encode(SessionRequest(
            _username: username,
            _password: password
        ))
        
        return try await self.extract(request: request)
    }
    
    static func deleteSession() async throws -> (SessionReply, ErrorReply) {
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        let url = URL(string: "http://\(self.host)/session/account/token")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "DELETE"
        return try await self.extract(request: request)
    }
}
