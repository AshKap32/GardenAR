//
//  CompendiumNetwork.swift
//  GardenAR
//
//  Created by KOBOLD! on 3/27/24.
//

import Foundation

struct CompendiumNetwork {
    static let host = "localhost:8080" // to do: extract this from some sort of config file
    static let encoder = JSONEncoder()
    static let decoder = JSONDecoder()
    
    static func getCompendia() async throws -> ([CompendiumModel]?, ErrorReply) {
        let url = URL(string: "http://\(self.host)/compendia")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let (data, _) = try await URLSession.shared.data(for: request)
        let reply = try self.decoder.decode(CompendiumReply.self, from: data)
        let e = try self.decoder.decode(ErrorReply.self, from: data)
        return (reply._compendia, e)
    }
    
    static func getCompendia(categoryId: Int) async throws -> ([CompendiumModel]?, ErrorReply) {
        let url = URL(string: "http://\(self.host)/compendia/category/\(categoryId)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let reply = try self.decoder.decode(CompendiumReply.self, from: data)
        let e = try self.decoder.decode(ErrorReply.self, from: data)
        return (reply._compendia, e)
    }
    
    static func getCompendium(compendiumId: Int) async throws -> (CompendiumModel?, ErrorReply) {
        let url = URL(string: "http://\(self.host)/compendium/\(compendiumId)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let reply = try self.decoder.decode(CompendiumReply.self, from: data)
        let e = try self.decoder.decode(ErrorReply.self, from: data)
        return (reply._compendium, e)
    }
    
    static func postCompendium(compendium: CompendiumModel) async throws -> (CompendiumModel?, ErrorReply) {
        let url = URL(string: "http://\(self.host)/compendium")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = CompendiumRequest(_compendium: compendium)
        request.httpBody = try self.encoder.encode(body)

        let (data, _) = try await URLSession.shared.data(for: request)
        let reply = try self.decoder.decode(CompendiumReply.self, from: data)
        let e = try self.decoder.decode(ErrorReply.self, from: data)
        return (reply._compendium, e)
    }
    
    static func postTag(compendiumId: Int, categoryId: Int) async throws -> ErrorReply {
        let url = URL(string: "http://\(self.host)/compendium/\(compendiumId)/category/\(categoryId)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try self.encoder.encode("")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        return try self.decoder.decode(ErrorReply.self, from: data)
    }
    
    static func deleteCompendium(compendiumId: Int) async throws -> (CompendiumReply, ErrorReply) {
        fatalError() // to do: actually implement this
    }
    
    static func deleteTag(compendiumId: Int, categoryId: Int) async throws -> ErrorReply {
        let url = URL(string: "http://\(self.host)/compendium/\(compendiumId)/category/\(categoryId)")!
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try self.encoder.encode("")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        return try self.decoder.decode(ErrorReply.self, from: data)
    }
    
    static func patchCompendium(compendiumId: Int, compendium: CompendiumModel) async throws -> (CompendiumModel?, ErrorReply) {
        let url = URL(string: "http://\(self.host)/compendium/\(compendiumId)")!
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = CompendiumRequest(_compendium: compendium)
        request.httpBody = try self.encoder.encode(body)

        let (data, _) = try await URLSession.shared.data(for: request)
        let reply = try self.decoder.decode(CompendiumReply.self, from: data)
        let e = try self.decoder.decode(ErrorReply.self, from: data)
        return (reply._compendium, e)
    }
}
