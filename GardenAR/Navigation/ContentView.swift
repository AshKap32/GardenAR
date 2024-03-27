//
//  ContentView.swift
//  GardenAR
//
//  Created by Aashish Kapoor on 11/10/23.
//

import Foundation
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authenticationEnvironment: AuthenticationEnvironment
    
    var body: some View {
        if authenticationEnvironment.loggedIn {
            TabBar()
        } else if authenticationEnvironment.showLogin {
            LoginView()
        } else {
            RegisterView()
        }
    }
}

#Preview {
    let authenticationEnvironment = AuthenticationEnvironment(
        loggedIn: false,
        showLogin: true
    )
    
    return ContentView().environmentObject(authenticationEnvironment)
}
