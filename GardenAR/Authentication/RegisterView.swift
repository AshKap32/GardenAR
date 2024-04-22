//
//  RegisterView.swift
//  GardenAR
//
//  Created by KOBOLD! on 3/10/24.
//

import Foundation
import SwiftUI

struct RegisterView: View {
    @Binding var showLogin: Bool
    @State var username: String = ""
    @State var nickname: String = ""
    @State var forename: String = ""
    @State var surname: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var skill: String = ""
    @State var city: String = ""
    @State var zip: String = ""
    
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
    
    func register() async {
        do {
            let (account, _) = try await AccountNetwork.postAccount(account: self.build(), password: self.password)
            if let account = account {
                self.showLogin = true
            } else {
                // to do: tell the user about a potential username conflict + other errors
            }
        } catch {}
    }
    
    func toggle() {
        self.showLogin = true
    }

    var body: some View {
        ZStack {
            Color("Colors/Alt")
                .ignoresSafeArea()
            
            VStack(spacing: 12.0) {
                HStack {
                    Image(systemName: "person.fill")
                        .frame(width: 24.0, alignment: .leading)
                    
                    TextField("Username", text: self.$username)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                }
                .padding(12.0)
                .background(.white)
                .clipShape(.rect(cornerRadius: 6.0))
                
                HStack {
                    Image(systemName: "person.fill")
                        .frame(width: 24.0, alignment: .leading)
                    
                    TextField("Nickname", text: self.$nickname)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                }
                .padding(12.0)
                .background(.white)
                .clipShape(.rect(cornerRadius: 6.0))
                
                HStack {
                    Image(systemName: "person.fill")
                        .frame(width: 24.0, alignment: .leading)
                    
                    TextField("First name", text: self.$forename)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                }
                .padding(12.0)
                .background(.white)
                .clipShape(.rect(cornerRadius: 6.0))
                
                HStack {
                    Image(systemName: "person.fill")
                        .frame(width: 24.0, alignment: .leading)
                    
                    TextField("Last name", text: self.$surname)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                }
                .padding(12.0)
                .background(.white)
                .clipShape(.rect(cornerRadius: 6.0))
                
                HStack {
                    Image(systemName: "envelope.fill")
                        .frame(width: 24.0, alignment: .leading)
                    
                    TextField("Email", text: self.$email)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                }
                .padding(12.0)
                .background(.white)
                .clipShape(.rect(cornerRadius: 6.0))
                
                HStack {
                    Image(systemName: "lock.fill")
                        .frame(width: 24.0, alignment: .leading)
                    
                    SecureField("Password", text: self.$password)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                }
                .padding(12.0)
                .background(.white)
                .clipShape(.rect(cornerRadius: 6.0))
                
                HStack {
                    Image(systemName: "rosette")
                        .frame(width: 24.0, alignment: .leading)
                    
                    TextField("Skill level", text: self.$skill)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                }
                .padding(12.0)
                .background(.white)
                .clipShape(.rect(cornerRadius: 6.0))
                
                HStack {
                    Image(systemName: "building.fill")
                        .frame(width: 24.0, alignment: .leading)
                    
                    TextField("City", text: self.$city)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                }
                .padding(12.0)
                .background(.white)
                .clipShape(.rect(cornerRadius: 6.0))
                
                HStack {
                    Image(systemName: "building.fill")
                        .frame(width: 24.0, alignment: .leading)
                    
                    TextField("Zip code", text: self.$zip)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                }
                .padding(12.0)
                .background(.white)
                .clipShape(.rect(cornerRadius: 6.0))
                
                Button(action: {
                    Task {
                        await self.register()
                    }
                }) {
                    Text("Sign up")
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                }
                .padding(12.0)
                .background(.black)
                .clipShape(.rect(cornerRadius: 6.0))

                HStack {
                    Text("Already have an account?")
                        .foregroundStyle(.white)
                    
                    Button(action: self.toggle) {
                        Text("Sign in")
                            .foregroundStyle(.green)
                    }
                }
            }
            .padding(.horizontal, 24.0)
        }
    }
}

#Preview {
    RegisterView(showLogin: .constant(false))
}
