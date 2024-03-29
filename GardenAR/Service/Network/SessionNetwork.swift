//
//  SessionNetwork.swift
//  GardenAR
//
//  Created by KOBOLD! on 3/27/24.
//

import Foundation

struct SessionNetwork {
    static let host = "localhost:8080" // to do: extract this from some sort of config file
    
    static func getSession() async throws -> (Bool?, ErrorReply) {
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        let url = URL(string: "http://\(self.host)/session/account/token")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"

        let (data, _) = try await URLSession.shared.data(for: request)
        let reply = try JSONDecoder().decode(SessionReply.self, from: data)
        let e = try JSONDecoder().decode(ErrorReply.self, from: data)
        return (reply._valid, e)
    }
    
    static func postSession(username: String, password: String) async throws -> (String?, ErrorReply) {
        let url = URL(string: "http://\(self.host)/session")!
        let body = SessionRequest(_username: username, _password: password)
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = try JSONEncoder().encode(body)

        let (data, _) = try await URLSession.shared.data(for: request)
        let reply = try JSONDecoder().decode(SessionReply.self, from: data)
        let e = try JSONDecoder().decode(ErrorReply.self, from: data)
        return (reply._token, e)
    }
    
    static func deleteSession() async throws -> (String?, ErrorReply) {
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        let url = URL(string: "http://\(self.host)/session/account/token")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "DELETE"

        let (data, _) = try await URLSession.shared.data(for: request)
        let reply = try JSONDecoder().decode(SessionReply.self, from: data)
        let e = try JSONDecoder().decode(ErrorReply.self, from: data)
        return (reply._status, e)
    }
}
