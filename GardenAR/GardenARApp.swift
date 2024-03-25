//
//  GardenARApp.swift
//  GardenAR
//
//  Created by Aashish Kapoor on 11/10/23.
//

import SwiftUI

@main struct GardenARApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(AuthenticationModel(
                    loggedIn: false,
                    showLogin: true
                ))
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
