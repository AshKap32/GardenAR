//
//  AuthenticationModel.swift
//  GardenAR
//
//  Created by KOBOLD! on 3/24/24.
//

import Foundation

class AuthenticationEnvironment: ObservableObject {
    @Published var loggedIn: Bool
    @Published var showLogin: Bool
    
    init(loggedIn: Bool, showLogin: Bool) {
        self.loggedIn = loggedIn
        self.showLogin = showLogin
    }
    
    func login(username: String, password: String) async throws -> (ErrorReply, AccountReply) {
        let url = URL(string: "http://localhost:8080/account/login")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = try JSONEncoder().encode(AccountRequest(
            _username: username,
            _password: password
        ))
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let decoder = JSONDecoder()
        let error = try decoder.decode(ErrorReply.self, from: data)
        let reply = try decoder.decode(AccountReply.self, from: data)
        return (error, reply)
    }
    
    func register(account: AccountModel, password: String) async throws -> (ErrorReply, AccountReply) {
        let url = URL(string: "http://localhost:8080/account")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = try JSONEncoder().encode(AccountRequest(
            _account: account,
            _password: password
        ))
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let decoder = JSONDecoder()
        let error = try decoder.decode(ErrorReply.self, from: data)
        let reply = try decoder.decode(AccountReply.self, from: data)
        return (error, reply)
    }
}
