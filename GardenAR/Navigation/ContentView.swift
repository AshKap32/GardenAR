////
////  ContentView.swift
////  GardenAR
////
////  Created by Aashish Kapoor on 11/10/23.
////
//

import Foundation
import SwiftUI

struct ContentView: View {
    @State var showLogin = true
    @State var loggedIn = false
    
    func ping() async {
        do {
            guard let token = UserDefaults.standard.string(forKey: "token") else {
                return
            }
            
            let e = try await SessionNetwork.getSession(token: token)
            if e.error == nil {
                self.loggedIn = true
            } else {
                UserDefaults.standard.removeObject(forKey: "token")
                self.loggedIn = false
            }
        } catch {}
    }
    
    var body: some View {
        ZStack {
            if self.loggedIn {
                TabBar(loggedIn: $loggedIn)  // Pass loggedIn binding
            } else if self.showLogin {
                LoginView(showLogin: $showLogin, loggedIn: $loggedIn)  // Continue to pass bindings
            } else {
                RegisterView(showLogin: $showLogin, loggedIn: $loggedIn)  // Now pass loggedIn binding
            }
        }
        .task {
            await self.ping()
        }
    }
}

#Preview {
    ContentView()
}
