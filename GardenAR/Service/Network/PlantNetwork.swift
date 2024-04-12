//
//  PlantNetwork.swift
//  GardenAR
//
//  Created by KOBOLD! on 3/27/24.
//

import Foundation

struct PlantNetwork {
    static let host = "localhost:8080" // to do: extract this from some sort of config file
    static let encoder = JSONEncoder()
    static let decoder = JSONDecoder()
    
    static func getPlants() async throws -> ([PlantModel]?, ErrorReply) {
        let url = URL(string: "http://\(self.host)/plants")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let (data, _) = try await URLSession.shared.data(for: request)
        let reply = try self.decoder.decode(PlantReply.self, from: data)
        let e = try self.decoder.decode(ErrorReply.self, from: data)
        return (reply._plants, e)
    }
    
    static func getPlants(accountId: Int) async throws -> ([PlantModel]?, ErrorReply) {
        let url = URL(string: "http://\(self.host)/plants/account/\(accountId)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let (data, _) = try await URLSession.shared.data(for: request)
        let reply = try self.decoder.decode(PlantReply.self, from: data)
        let e = try self.decoder.decode(ErrorReply.self, from: data)
        return (reply._plants, e)
    }
    
    static func getPlants(token: String) async throws -> ([PlantModel]?, ErrorReply) {
        let url = URL(string: "http://\(self.host)/plants/account/token")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        let (data, _) = try await URLSession.shared.data(for: request)
        let reply = try self.decoder.decode(PlantReply.self, from: data)
        let e = try self.decoder.decode(ErrorReply.self, from: data)
        return (reply._plants, e)
    }
    
    static func getPlant(plantId: Int) async throws -> (PlantModel?, ErrorReply) {
        let url = URL(string: "http://\(self.host)/plant/\(plantId)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let (data, _) = try await URLSession.shared.data(for: request)
        let reply = try self.decoder.decode(PlantReply.self, from: data)
        let e = try self.decoder.decode(ErrorReply.self, from: data)
        return (reply._plant, e)
    }
    
    static func postPlant(token: String, plant: PlantModel) async throws -> (PlantModel?, ErrorReply) {
        let url = URL(string: "http://\(self.host)/plant/account/token")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let body = PlantRequest(_plant: plant)
        request.httpBody = try self.encoder.encode(body)

        let (data, _) = try await URLSession.shared.data(for: request)
        let reply = try self.decoder.decode(PlantReply.self, from: data)
        let e = try self.decoder.decode(ErrorReply.self, from: data)
        return (reply._plant, e)
    }
    
    static func deletePlant(plantId: Int, token: String) async throws -> (PlantReply, ErrorReply) {
        fatalError() // to do: actually implement this
    }
    
    static func patchPlant(plantId: Int, token: String, plant: PlantModel) async throws -> (PlantModel?, ErrorReply) {
        let url = URL(string: "http://\(self.host)/plant/\(plantId)/account/token")!
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let body = PlantRequest(_plant: plant)
        request.httpBody = try self.encoder.encode(body)

        let (data, _) = try await URLSession.shared.data(for: request)
        let reply = try self.decoder.decode(PlantReply.self, from: data)
        let e = try self.decoder.decode(ErrorReply.self, from: data)
        return (reply._plant, e)
    }
}
