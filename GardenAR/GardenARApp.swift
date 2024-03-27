//
//  GardenARApp.swift
//  GardenAR
//
//  Created by Aashish Kapoor on 11/10/23.
//

import Foundation
import SwiftUI

@main struct GardenARApp: App {
    let authenticationEnvironment = AuthenticationEnvironment(
        loggedIn: false,
        showLogin: true
    )
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(authenticationEnvironment)
        }
    }
}
