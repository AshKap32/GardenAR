//
//  AccountNetwork.swift
//  GardenAR
//
//  Created by KOBOLD! on 3/27/24.
//

import Foundation

struct AccountNetwork {
    static let host = Bundle.main.object(forInfoDictionaryKey: "BACKEND_HOST") ?? "localhost"
    static let encoder = JSONEncoder()
    static let decoder = JSONDecoder()
    
    static func getAccounts() async throws -> ([AccountModel]?, ErrorReply) {
        let url = URL(string: "http://\(self.host)/accounts")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let (data, _) = try await URLSession.shared.data(for: request)
        let reply = try self.decoder.decode(AccountReply.self, from: data)
        let e = try self.decoder.decode(ErrorReply.self, from: data)
        return (reply._accounts, e)
    }
    
    static func getAccount(accountId: Int) async throws -> (AccountModel?, ErrorReply) {
        let url = URL(string: "http://\(self.host)/account/\(accountId)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let (data, _) = try await URLSession.shared.data(for: request)
        let reply = try self.decoder.decode(AccountReply.self, from: data)
        let e = try self.decoder.decode(ErrorReply.self, from: data)
        return (reply._account, e)
    }
    
    static func getAccount(token: String) async throws -> (AccountModel?, ErrorReply) {
        let url = URL(string: "http://\(self.host)/account/token")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        let (data, _) = try await URLSession.shared.data(for: request)
        let reply = try self.decoder.decode(AccountReply.self, from: data)
        let e = try self.decoder.decode(ErrorReply.self, from: data)
        return (reply._account, e)
    }
    
    static func postAccount(account: AccountModel, password: String) async throws -> (AccountModel?, ErrorReply) {
        let url = URL(string: "http://\(self.host)/account")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = AccountRequest(_account: account, _password: password)
        request.httpBody = try self.encoder.encode(body)

        let (data, _) = try await URLSession.shared.data(for: request)
        let reply = try self.decoder.decode(AccountReply.self, from: data)
        let e = try self.decoder.decode(ErrorReply.self, from: data)
        return (reply._account, e)
    }
    
    static func deleteAccount() async throws -> (AccountReply, ErrorReply) {
        fatalError() // to do: actually implement this
    }
    
    static func patchAccount(token: String, account: AccountModel, password: String) async throws -> (AccountModel?, ErrorReply) {
        let url = URL(string: "http://\(self.host)/account/token")!
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let body = AccountRequest(_account: account, _password: password)
        request.httpBody = try self.encoder.encode(body)

        let (data, _) = try await URLSession.shared.data(for: request)
        let reply = try self.decoder.decode(AccountReply.self, from: data)
        let e = try self.decoder.decode(ErrorReply.self, from: data)
        return (reply._account, e)
    }
}
