//
//  RegisterView.swift
//  GardenAR
//
//  Created by KOBOLD! on 3/10/24.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var authenticationModel: AuthenticationModel
    @State var username: String = ""
    @State var nickname: String = ""
    @State var forename: String = ""
    @State var surname: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var skill: String = ""
    @State var city: String = ""
    @State var zip: String = ""
    
    func register() {
        // to do: send a post request to /account with every state variable in the body
        if (true) {
            authenticationModel.showLogin = true
        } else {
            // display an error message
        }
    }
    
    func toggle() {
        authenticationModel.showLogin = true
    }
    
    var body: some View {
        ZStack {
            VStack {
                HStack(spacing: 8.0) {
                    Image(systemName: "person")
                    TextField("Username", text: $username)
                }
                .padding(16.0)
                .background(.tertiary)
                .clipShape(RoundedRectangle(cornerRadius: 8.0))
                
                HStack(spacing: 8.0) {
                    Image(systemName: "person")
                    SecureField("Nickname", text: $nickname)
                }
                .padding(16.0)
                .background(.tertiary)
                .clipShape(RoundedRectangle(cornerRadius: 8.0))
                
                HStack(spacing: 8.0) {
                    Image(systemName: "person")
                    SecureField("First Name", text: $forename)
                }
                .padding(16.0)
                .background(.tertiary)
                .clipShape(RoundedRectangle(cornerRadius: 8.0))
                
                HStack(spacing: 8.0) {
                    Image(systemName: "person")
                    SecureField("Last Name", text: $surname)
                }
                .padding(16.0)
                .background(.tertiary)
                .clipShape(RoundedRectangle(cornerRadius: 8.0))
                
                HStack(spacing: 8.0) {
                    Image(systemName: "envelope")
                    SecureField("Email", text: $email)
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
                
                HStack(spacing: 8.0) {
                    Image(systemName: "lock")
                    SecureField("Skill Level", text: $skill)
                }
                .padding(16.0)
                .background(.tertiary)
                .clipShape(RoundedRectangle(cornerRadius: 8.0))
                
                HStack(spacing: 8.0) {
                    Image(systemName: "lock")
                    SecureField("City", text: $city)
                }
                .padding(16.0)
                .background(.tertiary)
                .clipShape(RoundedRectangle(cornerRadius: 8.0))
                
                HStack(spacing: 8.0) {
                    Image(systemName: "lock")
                    SecureField("Zip Code", text: $zip)
                }
                .padding(16.0)
                .background(.tertiary)
                .clipShape(RoundedRectangle(cornerRadius: 8.0))
                
                Button(action: register) {
                    Text("Create Account")
                        .tint(.white)
                }
                .padding()
   
                Button(action: toggle) {
                    Text("Sign In")
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
    RegisterView()
        .environmentObject(AuthenticationModel(
            loggedIn: false,
            showLogin: false
        ))
}
