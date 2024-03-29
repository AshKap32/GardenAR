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
    
    func toggle() {
        self.authenticationEnvironment.showLogin = true
    }
    
    func build() -> AccountModel {
        return AccountModel(
            _username: self.username,
            _nickname: self.nickname,
            _forename: self.forename,
            _surname: self.surname,
            _email: self.email,
            _skill: Int(self.skill),
            _city: self.city,
            _zip: Int(self.zip)
        )
    }
    
    func register() {
        Task {
            let (_, e) = try await AccountNetwork.postAccount(account: self.build(), password: self.password)
            if e.error == nil {
                self.authenticationEnvironment.showLogin = true
            } else {
                // to do: tell the user about a potential username conflict + other errors
            }
        }
    }

    var body: some View {
        VStack(spacing: 16.0) {
            HStack(spacing: 16.0) {
                Image(systemName: "person.fill")
                TextField("Username", text: self.$username).textInputAutocapitalization(.never).autocorrectionDisabled(true)
            }
            .padding(16.0)
            .background(.tertiary)
            .clipShape(RoundedRectangle(cornerRadius: 8.0))
            
            HStack(spacing: 16.0) {
                Image(systemName: "person.fill")
                TextField("Nickname", text: self.$nickname).textInputAutocapitalization(.never).autocorrectionDisabled(true)
            }
            .padding(16.0)
            .background(.tertiary)
            .clipShape(RoundedRectangle(cornerRadius: 8.0))
            
            HStack(spacing: 16.0) {
                Image(systemName: "person.fill")
                TextField("First Name", text: self.$forename).textInputAutocapitalization(.never).autocorrectionDisabled(true)
            }
            .padding(16.0)
            .background(.tertiary)
            .clipShape(RoundedRectangle(cornerRadius: 8.0))
            
            HStack(spacing: 16.0) {
                Image(systemName: "person.fill")
                TextField("Last Name", text: self.$surname).textInputAutocapitalization(.never).autocorrectionDisabled(true)
            }
            .padding(16.0)
            .background(.tertiary)
            .clipShape(RoundedRectangle(cornerRadius: 8.0))
            
            HStack(spacing: 16.0) {
                Image(systemName: "envelope.fill")
                TextField("Email", text: self.$email).textInputAutocapitalization(.never).autocorrectionDisabled(true)
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
            
            HStack(spacing: 16.0) {
                Image(systemName: "rosette")
                TextField("Skill Level", text: self.$skill).textInputAutocapitalization(.never).autocorrectionDisabled(true)
            }
            .padding(16.0)
            .background(.tertiary)
            .clipShape(RoundedRectangle(cornerRadius: 8.0))
            
            HStack(spacing: 16.0) {
                Image(systemName: "building.fill")
                TextField("City", text: self.$city).textInputAutocapitalization(.never).autocorrectionDisabled(true)
            }
            .padding(16.0)
            .background(.tertiary)
            .clipShape(RoundedRectangle(cornerRadius: 8.0))
            
            HStack(spacing: 16.0) {
                Image(systemName: "building.fill")
                TextField("Zip Code", text: self.$zip).textInputAutocapitalization(.never).autocorrectionDisabled(true)
            }
            .padding(16.0)
            .background(.tertiary)
            .clipShape(RoundedRectangle(cornerRadius: 8.0))
            
            Button(action: self.register) {
                Text("Create Account").tint(.white)
            }
            .padding(8.0)

            Button(action: self.toggle) {
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
