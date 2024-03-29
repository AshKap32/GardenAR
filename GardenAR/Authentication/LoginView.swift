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
    
    func toggle() {
        self.authenticationEnvironment.showLogin = false
    }
    
    func login() {
        Task {
            let (token, e) = try await SessionNetwork.postSession(username: self.username, password: self.password)
            if e.error == nil {
                UserDefaults.standard.set(token, forKey: "token")
                self.authenticationEnvironment.loggedIn = true
                self.authenticationEnvironment.showLogin = true
            } else {
                // to do: tell the user to check their credentials
            }
        }
    }
    
    var body: some View {
        VStack(spacing: 16.0) {
            Image("Images/LogoTransparent").resizable().frame(width: 500)
            
            HStack(spacing: 16.0) {
                Image(systemName: "person.fill")
                TextField("Username", text: self.$username).textInputAutocapitalization(.never).autocorrectionDisabled(true)
            }
            .padding(16.0)
            .background(.tertiary)
            .clipShape(RoundedRectangle(cornerRadius: 8.0))
            
            HStack(spacing: 16.0) {
                Image(systemName: "lock.fill")
                SecureField("Password", text: self.$password).textInputAutocapitalization(.never).autocorrectionDisabled(true)
            }
            .padding(16.0)
            .background(.tertiary)
            .clipShape(RoundedRectangle(cornerRadius: 8.0))
            
            Button(action: self.login) {
                Text("Sign In").tint(.white)
            }
            .padding(8.0)

            Button(action: self.toggle) {
                Text("Create Account").tint(.white)
            }
            .padding(8.0)
          
            Spacer()
        }
        .padding(32.0)
        .background(Color("Colors/Body"))
    }
}

#Preview {
    let authenticationEnvironment = AuthenticationEnvironment(loggedIn: false, showLogin: true)
    return LoginView().environmentObject(authenticationEnvironment)
}
