//
//  LoginView.swift
//  GardenAR
//
//  Created by KOBOLD! on 3/10/24.
//

import Foundation
import SwiftUI

struct LoginView: View {
    @Binding var showLogin: Bool
    @Binding var loggedIn: Bool
    @State var username: String = ""
    @State var password: String = ""
    
    func login() async {
        do {
            let (token, _) = try await SessionNetwork.postSession(username: self.username, password: self.password)
            guard let token = token else {
                // to do: tell the user to check their credentials
                return
            }
            
            UserDefaults.standard.set(token, forKey: "token")
            self.loggedIn = true
        } catch {
            
        }
    }
    
    func toggle() {
        self.showLogin = false
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
            
            Button(action: {
                Task{
                    await self.login()
                }
            }) {
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
    LoginView(showLogin: .constant(true), loggedIn: .constant(false))
}
