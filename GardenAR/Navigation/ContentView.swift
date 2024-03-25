//
//  ContentView.swift
//  GardenAR
//
//  Created by Aashish Kapoor on 11/10/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authenticationModel: AuthenticationModel
    
    var body: some View {
        if authenticationModel.loggedIn {
            TabBar()
        } else if authenticationModel.showLogin {
            LoginView()
        } else {
            RegisterView()
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthenticationModel(
            loggedIn: false,
            showLogin: true
        ))
}
