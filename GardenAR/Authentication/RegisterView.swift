//
//  RegisterView.swift
//  GardenAR
//
//  Created by KOBOLD! on 3/10/24.
//

import Foundation
import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var authenticationEnvironment: AuthenticationEnvironment
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
        Task {
            let account = AccountModel(
                _username: username,
                _nickname: nickname,
                _forename: forename,
                _surname: surname,
                _email: email,
                _skill: Int(skill),
                _city: city,
                _zip: Int(zip)
            )
            
            let (_, e) = try await AccountNetwork.postAccount(account: account, password: password)
            if e.error == nil {
                authenticationEnvironment.showLogin = true
            } else {
                // to do: tell the user about a potential username conflict + other errors
            }
        }
    }
    
    func toggle() {
        authenticationEnvironment.showLogin = true
    }

    var body: some View {
        VStack(spacing: 16.0) {
            HStack(spacing: 16.0) {
                Image(systemName: "person.fill")
                TextField("Username", text: $username).textInputAutocapitalization(.never).autocorrectionDisabled(true)
            }
            .padding(16.0)
            .background(.tertiary)
            .clipShape(RoundedRectangle(cornerRadius: 8.0))
            
            HStack(spacing: 16.0) {
                Image(systemName: "person.fill")
                TextField("Nickname", text: $nickname).textInputAutocapitalization(.never).autocorrectionDisabled(true)
            }
            .padding(16.0)
            .background(.tertiary)
            .clipShape(RoundedRectangle(cornerRadius: 8.0))
            
            HStack(spacing: 16.0) {
                Image(systemName: "person.fill")
                TextField("First Name", text: $forename).textInputAutocapitalization(.never).autocorrectionDisabled(true)
            }
            .padding(16.0)
            .background(.tertiary)
            .clipShape(RoundedRectangle(cornerRadius: 8.0))
            
            HStack(spacing: 16.0) {
                Image(systemName: "person.fill")
                TextField("Last Name", text: $surname).textInputAutocapitalization(.never).autocorrectionDisabled(true)
            }
            .padding(16.0)
            .background(.tertiary)
            .clipShape(RoundedRectangle(cornerRadius: 8.0))
            
            HStack(spacing: 16.0) {
                Image(systemName: "envelope.fill")
                TextField("Email", text: $email).textInputAutocapitalization(.never).autocorrectionDisabled(true)
            }
            .padding(16.0)
            .background(.tertiary)
            .clipShape(RoundedRectangle(cornerRadius: 8.0))
            
            HStack(spacing: 16.0) {
                Image(systemName: "lock.fill")
                SecureField("Password", text: $password).textInputAutocapitalization(.never).autocorrectionDisabled(true)
            }
            .padding(16.0)
            .background(.tertiary)
            .clipShape(RoundedRectangle(cornerRadius: 8.0))
            
            HStack(spacing: 16.0) {
                Image(systemName: "rosette")
                TextField("Skill Level", text: $skill).textInputAutocapitalization(.never).autocorrectionDisabled(true)
            }
            .padding(16.0)
            .background(.tertiary)
            .clipShape(RoundedRectangle(cornerRadius: 8.0))
            
            HStack(spacing: 16.0) {
                Image(systemName: "building.fill")
                TextField("City", text: $city).textInputAutocapitalization(.never).autocorrectionDisabled(true)
            }
            .padding(16.0)
            .background(.tertiary)
            .clipShape(RoundedRectangle(cornerRadius: 8.0))
            
            HStack(spacing: 16.0) {
                Image(systemName: "building.fill")
                TextField("Zip Code", text: $zip).textInputAutocapitalization(.never).autocorrectionDisabled(true)
            }
            .padding(16.0)
            .background(.tertiary)
            .clipShape(RoundedRectangle(cornerRadius: 8.0))
            
            Button(action: register) {
                Text("Create Account").tint(.white)
            }
            .padding(8.0)

            Button(action: toggle) {
                Text("Sign In").tint(.white)
            }
            .padding(8.0)
          
            Spacer()
        }
        .padding(32.0)
        .background(Color("Colors/Body"))
    }
}

#Preview {
    let authenticationEnvironment = AuthenticationEnvironment(loggedIn: false, showLogin: false)
    return RegisterView().environmentObject(authenticationEnvironment)
}
