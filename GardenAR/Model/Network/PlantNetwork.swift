//
//  PlantNetwork.swift
//  GardenAR
//
//  Created by KOBOLD! on 3/27/24.
//

import Foundation

struct PlantNetwork {
    static let host = "localhost:8080" // to do: extract this from some sort of config file
    
    static func getPlants() async throws -> ([PlantModel]?, ErrorReply) {
        let url = URL(string: "http://\(self.host)/plants")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"

        let (data, _) = try await URLSession.shared.data(for: request)
        let reply = try JSONDecoder().decode(PlantReply.self, from: data)
        let e = try JSONDecoder().decode(ErrorReply.self, from: data)
        return (reply._plants, e)
    }
    
    static func getPlants(accountId: Int) async throws -> ([PlantModel]?, ErrorReply) {
        let url = URL(string: "http://\(self.host)/plants/account/\(accountId)")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"

        let (data, _) = try await URLSession.shared.data(for: request)
        let reply = try JSONDecoder().decode(PlantReply.self, from: data)
        let e = try JSONDecoder().decode(ErrorReply.self, from: data)
        return (reply._plants, e)
    }
    
    static func getPlants(token: String = "") async throws -> ([PlantModel]?, ErrorReply) {
        let url = URL(string: "http://\(self.host)/plants/account/token")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"

        let (data, _) = try await URLSession.shared.data(for: request)
        let reply = try JSONDecoder().decode(PlantReply.self, from: data)
        let e = try JSONDecoder().decode(ErrorReply.self, from: data)
        return (reply._plants, e)
    }
    
    static func getPlant(plantId: Int) async throws -> (PlantModel?, ErrorReply) {
        let url = URL(string: "http://\(self.host)/plant/\(plantId)")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"

        let (data, _) = try await URLSession.shared.data(for: request)
        let reply = try JSONDecoder().decode(PlantReply.self, from: data)
        let e = try JSONDecoder().decode(ErrorReply.self, from: data)
        return (reply._plant, e)
    }
    
    static func postPlant(token: String = "", plant: PlantModel) async throws -> (PlantModel?, ErrorReply) {
        let url = URL(string: "http://\(self.host)/plant/account/token")!
        let body = PlantRequest(_plant: plant)
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.httpBody = try JSONEncoder().encode(body)

        let (data, _) = try await URLSession.shared.data(for: request)
        let reply = try JSONDecoder().decode(PlantReply.self, from: data)
        let e = try JSONDecoder().decode(ErrorReply.self, from: data)
        return (reply._plant, e)
    }
    
    static func deletePlant(plantId: Int, token: String = "") async throws -> (PlantReply, ErrorReply) {
        fatalError() // to do: actually implement this
    }
    
    static func patchPlant(plantId: Int, token: String = "", plant: PlantModel) async throws -> (PlantModel?, ErrorReply) {
        let url = URL(string: "http://\(self.host)/plant/\(plantId)/account/token")!
        let body = PlantRequest(_plant: plant)
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "PATCH"
        request.httpBody = try JSONEncoder().encode(body)

        let (data, _) = try await URLSession.shared.data(for: request)
        let reply = try JSONDecoder().decode(PlantReply.self, from: data)
        let e = try JSONDecoder().decode(ErrorReply.self, from: data)
        return (reply._plant, e)
    }
}
