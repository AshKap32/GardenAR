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
            let (error, reply) = try await authenticationEnvironment.register(
                account: AccountModel(
                    _username: username,
                    _nickname: nickname,
                    _forename: forename,
                    _surname: surname,
                    _email: email,
                    _skill: Int(skill),
                    _city: city,
                    _zip: Int(zip)
                ),
                password: password
            )
            
            print(error)
            print(reply)
            if reply._account == nil {
                // to do: display a whole bunch of error messages
            } else {
                authenticationEnvironment.showLogin = true
            }
        }
    }
    
    func toggle() {
        authenticationEnvironment.showLogin = true
    }

    var body: some View {
        ZStack {
            VStack {
                HStack(spacing: 8.0) {
                    Image(systemName: "person.fill")
                    TextField("Username", text: $username)
                }
                .padding(16.0)
                .background(.tertiary)
                .clipShape(RoundedRectangle(cornerRadius: 8.0))
                
                HStack(spacing: 8.0) {
                    Image(systemName: "person.fill")
                    TextField("Nickname", text: $nickname)
                }
                .padding(16.0)
                .background(.tertiary)
                .clipShape(RoundedRectangle(cornerRadius: 8.0))
                
                HStack(spacing: 8.0) {
                    Image(systemName: "person.fill")
                    TextField("First Name", text: $forename)
                }
                .padding(16.0)
                .background(.tertiary)
                .clipShape(RoundedRectangle(cornerRadius: 8.0))
                
                HStack(spacing: 8.0) {
                    Image(systemName: "person.fill")
                    TextField("Last Name", text: $surname)
                }
                .padding(16.0)
                .background(.tertiary)
                .clipShape(RoundedRectangle(cornerRadius: 8.0))
                
                HStack(spacing: 8.0) {
                    Image(systemName: "envelope.fill")
                    TextField("Email", text: $email)
                }
                .padding(16.0)
                .background(.tertiary)
                .clipShape(RoundedRectangle(cornerRadius: 8.0))
                
                HStack(spacing: 8.0) {
                    Image(systemName: "lock.fill")
                    SecureField("Password", text: $password)
                }
                .padding(16.0)
                .background(.tertiary)
                .clipShape(RoundedRectangle(cornerRadius: 8.0))
                
                HStack(spacing: 8.0) {
                    Image(systemName: "rosette")
                    TextField("Skill Level", text: $skill)
                }
                .padding(16.0)
                .background(.tertiary)
                .clipShape(RoundedRectangle(cornerRadius: 8.0))
                
                HStack(spacing: 8.0) {
                    Image(systemName: "building.fill")
                    TextField("City", text: $city)
                }
                .padding(16.0)
                .background(.tertiary)
                .clipShape(RoundedRectangle(cornerRadius: 8.0))
                
                HStack(spacing: 8.0) {
                    Image(systemName: "building.fill")
                    TextField("Zip Code", text: $zip)
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
    let authenticationEnvironment = AuthenticationEnvironment(
        loggedIn: false,
        showLogin: false
    )
    
    return RegisterView().environmentObject(authenticationEnvironment)
}
