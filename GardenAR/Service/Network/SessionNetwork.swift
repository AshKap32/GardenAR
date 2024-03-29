//
//  SessionNetwork.swift
//  GardenAR
//
//  Created by KOBOLD! on 3/27/24.
//

import Foundation

struct SessionNetwork {
    static let host = "localhost:8080" // to do: extract this from some sort of config file
    
    static func getSession(token: String) async throws -> (Bool?, ErrorReply) {
        let url = URL(string: "http://\(self.host)/session/account/token")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        let (data, _) = try await URLSession.shared.data(for: request)
        let reply = try JSONDecoder().decode(SessionReply.self, from: data)
        let e = try JSONDecoder().decode(ErrorReply.self, from: data)
        return (reply._valid, e)
    }
    
    static func postSession(username: String, password: String) async throws -> (String?, ErrorReply) {
        let url = URL(string: "http://\(self.host)/session")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = SessionRequest(_username: username, _password: password)
        request.httpBody = try JSONEncoder().encode(body)

        let (data, _) = try await URLSession.shared.data(for: request)
        let reply = try JSONDecoder().decode(SessionReply.self, from: data)
        let e = try JSONDecoder().decode(ErrorReply.self, from: data)
        return (reply._token, e)
    }
    
    static func deleteSession(token: String) async throws -> (String?, ErrorReply) {
        let url = URL(string: "http://\(self.host)/session/account/token")!
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        let (data, _) = try await URLSession.shared.data(for: request)
        let reply = try JSONDecoder().decode(SessionReply.self, from: data)
        let e = try JSONDecoder().decode(ErrorReply.self, from: data)
        return (reply._status, e)
    }
}
