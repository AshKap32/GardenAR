//
//  LoginView.swift
//  GardenAR
//
//  Created by KOBOLD! on 3/10/24.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authenticationModel: AuthenticationModel
    @State var username: String = ""
    @State var password: String = ""
    
    func login() {
        // to do: send a post request to /account/login with password and username in the body
        if (true) {
            // to do: store the token and id that we get somewhere
            authenticationModel.loggedIn = true
            authenticationModel.showLogin = true
        } else {
            // to do: display an error message
        }
    }
    
    func toggle() {
        authenticationModel.showLogin = false
    }
    
    var body: some View {
        ZStack {
            VStack {
                Image("GardenARN")
                    .resizable()
                    .frame(width: 329, height: 273)
                
                HStack(spacing: 8.0) {
                    Image(systemName: "person")
                    TextField("Username", text: $username)
                }
                .padding(16.0)
                .background(.tertiary)
                .clipShape(RoundedRectangle(cornerRadius: 8.0))
                
                HStack(spacing: 8.0) {
                    Image(systemName: "lock")
                    SecureField("Password", text: $password)
                }
                .padding(16.0)
                .background(.tertiary)
                .clipShape(RoundedRectangle(cornerRadius: 8.0))
                
                Button(action: login) {
                    Text("Sign In")
                        .tint(.white)
                }
                .padding()
   
                Button(action: toggle) {
                    Text("Create Account")
                        .tint(.white)
                }
              
                Spacer()
            }
            .padding(32.0)
        }
        .background(Color("74C98B"))
    }
}

#Preview {
    LoginView()
        .environmentObject(AuthenticationModel(
            loggedIn: false,
            showLogin: true
        ))
}
