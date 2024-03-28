//
//  LoginView.swift
//  GardenAR
//
//  Created by KOBOLD! on 3/10/24.
//

import Foundation
import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authenticationEnvironment: AuthenticationEnvironment
    @State var username: String = ""
    @State var password: String = ""
    
    func login() {
        Task {
            let (token, e) = try await SessionNetwork.postSession(username: username, password: password)
            if e.error == nil {
                UserDefaults.standard.set(token, forKey: "token")
                authenticationEnvironment.loggedIn = true
                authenticationEnvironment.showLogin = true
            } else {
                // to do: tell the user to check their credentials
            }
        }
    }
    
    func toggle() {
        authenticationEnvironment.showLogin = false
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 16.0) {
                Image("GardenARN").resizable().frame(width: 329, height: 273)
                
                HStack(spacing: 16.0) {
                    Image(systemName: "person.fill")
                    TextField("Username", text: $username).textInputAutocapitalization(.never)
                }
                .padding(16.0)
                .background(.tertiary)
                .clipShape(RoundedRectangle(cornerRadius: 8.0))
                
                HStack(spacing: 16.0) {
                    Image(systemName: "lock.fill")
                    SecureField("Password", text: $password).textInputAutocapitalization(.never)
                }
                .padding(16.0)
                .background(.tertiary)
                .clipShape(RoundedRectangle(cornerRadius: 8.0))
                
                Button(action: login) {
                    Text("Sign In").tint(.white)
                }
                .padding()
   
                Button(action: toggle) {
                    Text("Create Account").tint(.white)
                }
              
                Spacer()
            }
            .padding(32.0)
        }
        .background(Color("74C98B"))
    }
}

#Preview {
    let authenticationEnvironment = AuthenticationEnvironment(loggedIn: false, showLogin: true)
    return LoginView().environmentObject(authenticationEnvironment)
}
