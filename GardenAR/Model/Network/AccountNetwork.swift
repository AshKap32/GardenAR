//
//  AccountNetwork.swift
//  GardenAR
//
//  Created by KOBOLD! on 3/27/24.
//

import Foundation

struct AccountNetwork {
    static let host = "localhost:8080" // to do: extract this from some sort of config file
    
    static func extract(request: URLRequest) async throws -> (AccountReply, ErrorReply) {
        let (data, _) = try await URLSession.shared.data(for: request)
        let reply = try JSONDecoder().decode(AccountReply.self, from: data)
        let e = try JSONDecoder().decode(ErrorReply.self, from: data)
        return (reply, e)
    }
    
    static func getAccounts() async throws -> (AccountReply, ErrorReply) {
        let url = URL(string: "http://\(self.host)/accounts")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        return try await self.extract(request: request)
    }
    
    static func getAccount(accountId: Int) async throws -> (AccountReply, ErrorReply) {
        let url = URL(string: "http://\(self.host)/account/\(accountId)")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        return try await self.extract(request: request)
    }
    
    static func getAccount(token: String = "") async throws -> (AccountReply, ErrorReply) {
        let url = URL(string: "http://\(self.host)/account/token")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        return try await self.extract(request: request)
    }
    
    static func postAccount(account: AccountModel, password: String) async throws -> (AccountReply, ErrorReply) {
        let url = URL(string: "http://\(self.host)/account")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = try JSONEncoder().encode(AccountRequest(
            _account: account,
            _password: password
        ))
        
        return try await self.extract(request: request)
    }
    
    static func deleteAccount() async throws -> (AccountReply, ErrorReply) {
        fatalError() // to do: actually implement this
    }
    
    static func patchAccount(token: String = "", account: AccountModel, password: String) async throws -> (AccountReply, ErrorReply) {
        let url = URL(string: "http://\(self.host)/account/token")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "PATCH"
        request.httpBody = try JSONEncoder().encode(AccountRequest(
            _account: account,
            _password: password
        ))
        
        return try await self.extract(request: request)
    }
}
