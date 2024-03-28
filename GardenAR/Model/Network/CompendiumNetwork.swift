//
//  CompendiumNetwork.swift
//  GardenAR
//
//  Created by KOBOLD! on 3/27/24.
//

import Foundation

struct CompendiumNetwork {
    static let host = "localhost:8080" // to do: extract this from some sort of config file
    
    static func getCompendia() async throws -> ([CompendiumModel]?, ErrorReply) {
        let url = URL(string: "http://\(self.host)/compendia")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"

        let (data, _) = try await URLSession.shared.data(for: request)
        let reply = try JSONDecoder().decode(CompendiumReply.self, from: data)
        let e = try JSONDecoder().decode(ErrorReply.self, from: data)
        return (reply._compendia, e)
    }
    
    static func getCompendium(compendiumId: Int) async throws -> (CompendiumModel?, ErrorReply) {
        let url = URL(string: "http://\(self.host)/compendium/\(compendiumId)")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"

        let (data, _) = try await URLSession.shared.data(for: request)
        let reply = try JSONDecoder().decode(CompendiumReply.self, from: data)
        let e = try JSONDecoder().decode(ErrorReply.self, from: data)
        return (reply._compendium, e)
    }
    
    static func postCompendium(compendium: CompendiumModel) async throws -> (CompendiumModel?, ErrorReply) {
        let url = URL(string: "http://\(self.host)/compendium")!
        let body = CompendiumRequest(_compendium: compendium)
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = try JSONEncoder().encode(body)

        let (data, _) = try await URLSession.shared.data(for: request)
        let reply = try JSONDecoder().decode(CompendiumReply.self, from: data)
        let e = try JSONDecoder().decode(ErrorReply.self, from: data)
        return (reply._compendium, e)
    }
    
    static func deleteCompendium(compendiumId: Int) async throws -> (CompendiumReply, ErrorReply) {
        fatalError() // to do: actually implement this
    }
    
    static func patchCompendium(compendiumId: Int, compendium: CompendiumModel) async throws -> (CompendiumModel?, ErrorReply) {
        let url = URL(string: "http://\(self.host)/compendium/\(compendiumId)")!
        let body = CompendiumRequest(_compendium: compendium)
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "PATCH"
        request.httpBody = try JSONEncoder().encode(body)

        let (data, _) = try await URLSession.shared.data(for: request)
        let reply = try JSONDecoder().decode(CompendiumReply.self, from: data)
        let e = try JSONDecoder().decode(ErrorReply.self, from: data)
        return (reply._compendium, e)
    }
}
