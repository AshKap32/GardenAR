//
//  PlantNetwork.swift
//  GardenAR
//
//  Created by KOBOLD! on 3/27/24.
//

import Foundation

struct PlantNetwork {
    static let host = "localhost:8080" // to do: extract this from some sort of config file
    
    static func extract(request: URLRequest) async throws -> (PlantReply, ErrorReply) {
        let (data, _) = try await URLSession.shared.data(for: request)
        let reply = try JSONDecoder().decode(PlantReply.self, from: data)
        let e = try JSONDecoder().decode(ErrorReply.self, from: data)
        return (reply, e)
    }
    
    static func getPlants() async throws -> (PlantReply, ErrorReply) {
        let url = URL(string: "http://\(self.host)/plants")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        return try await self.extract(request: request)
    }
    
    static func getPlants(accountId: Int) async throws -> (PlantReply, ErrorReply) {
        let url = URL(string: "http://\(self.host)/plants/account/\(accountId)")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        return try await self.extract(request: request)
    }
    
    static func getPlants(token: String = "") async throws -> (PlantReply, ErrorReply) {
        let url = URL(string: "http://\(self.host)/plants/account/token")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        return try await self.extract(request: request)
    }
    
    static func getPlant(plantId: Int) async throws -> (PlantReply, ErrorReply) {
        let url = URL(string: "http://\(self.host)/plant/\(plantId)")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        return try await self.extract(request: request)
    }
    
    static func postPlant(token: String = "", plant: PlantModel) async throws -> (PlantReply, ErrorReply) {
        let url = URL(string: "http://\(self.host)/plant/account/token")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.httpBody = try JSONEncoder().encode(PlantRequest(
            _plant: plant
        ))
        
        return try await self.extract(request: request)
    }
    
    static func deletePlant(plantId: Int, token: String = "") async throws -> (PlantReply, ErrorReply) {
        fatalError() // to do: actually implement this
    }
    
    static func patchPlant(plantId: Int, token: String = "", plant: PlantModel) async throws -> (PlantReply, ErrorReply) {
        let url = URL(string: "http://\(self.host)/plant/\(plantId)/account/token")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "PATCH"
        request.httpBody = try JSONEncoder().encode(PlantRequest(
            _plant: plant
        ))
        
        return try await self.extract(request: request)
    }
}
