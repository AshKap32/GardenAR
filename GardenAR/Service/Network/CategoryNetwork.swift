//
//  CategoryNetwork.swift
//  GardenAR
//
//  Created by KOBOLD! on 4/20/24.
//

import Foundation

struct CategoryNetwork {
    static let host = Bundle.main.object(forInfoDictionaryKey: "BACKEND_HOST") ?? "localhost:80"
    static let encoder = JSONEncoder()
    static let decoder = JSONDecoder()
    
    static func getCategories() async throws -> ([CategoryModel]?, ErrorReply) {
        let url = URL(string: "http://\(self.host)/categories")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let reply = try self.decoder.decode(CategoryReply.self, from: data)
        let e = try self.decoder.decode(ErrorReply.self, from: data)
        return (reply._categories, e)
    }
    
    static func getCategories(compendiumId: Int) async throws -> ([CategoryModel]?, ErrorReply) {
        let url = URL(string: "http://\(self.host)/categories/compendium/\(compendiumId)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let reply = try self.decoder.decode(CategoryReply.self, from: data)
        let e = try self.decoder.decode(ErrorReply.self, from: data)
        return (reply._categories, e)
    }
    
    static func getCategory(categoryId: Int) async throws -> (CategoryModel?, ErrorReply) {
        let url = URL(string: "http://\(self.host)/category/\(categoryId)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let reply = try self.decoder.decode(CategoryReply.self, from: data)
        let e = try self.decoder.decode(ErrorReply.self, from: data)
        return (reply._category, e)
    }
    
    static func postCategory(category: CategoryModel) async throws -> (CategoryModel?, ErrorReply) {
        let url = URL(string: "http://\(self.host)/category")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = CategoryRequest(_category: category)
        request.httpBody = try self.encoder.encode(body)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let reply = try self.decoder.decode(CategoryReply.self, from: data)
        let e = try self.decoder.decode(ErrorReply.self, from: data)
        return (reply._category, e)
    }
    
    static func deleteCategory(categoryId: Int) async throws -> (CategoryReply, ErrorReply) {
        fatalError() // to do: actually implement this
    }
    
    static func patchCategory(categoryId: Int, category: CategoryModel) async throws -> (CategoryModel?, ErrorReply) {
        let url = URL(string: "http://\(self.host)/category/\(categoryId)")!
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = CategoryRequest(_category: category)
        request.httpBody = try self.encoder.encode(body)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let reply = try self.decoder.decode(CategoryReply.self, from: data)
        let e = try self.decoder.decode(ErrorReply.self, from: data)
        return (reply._category, e)
    }
}
