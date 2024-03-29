//
//  AuthenticationEnvironment.swift
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
}
