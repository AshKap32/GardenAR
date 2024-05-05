////
////  RegisterView.swift
////  GardenAR
////
////  Created by KOBOLD! on 3/10/24.
////
//
import Foundation
import SwiftUI

struct RegisterView: View {
    @Binding var showLogin: Bool
    @Binding var loggedIn: Bool  // Add this line
    @State var username: String = ""
    @State var nickname: String = ""
    @State var forename: String = ""
    @State var surname: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var skill: String = ""
    @State var city: String = ""
    @State var zip: String = ""
    let skillOptions: [String] = ["Beginner", "Intermediate", "Professional"]
    
    func build() -> AccountModel {
        var skill: Int? = nil
        for (index, value) in self.skillOptions.enumerated() {
            if self.skill == value {
                skill = index
                break
            }
        }
        
        return AccountModel(
            _username: self.username,
            _nickname: self.nickname,
            _forename: self.forename,
            _surname: self.surname,
            _email: self.email,
            _skill: skill,
            _city: self.city,
            _zip: Int(self.zip)
        )
    }
    
    func register() async {
            do {
                let (account, _) = try await AccountNetwork.postAccount(account: self.build(), password: self.password)
                if let account = account {
                    self.loggedIn = true  // Set loggedIn to true on successful registration
                    self.showLogin = false
                } else {
                    // Handle registration failure...
                }
            } catch {
                // Handle errors...
            }
        }
    
    func toggle() {
        self.showLogin = true
    }

    var body: some View {
        ZStack {
            Color("Colors/Alt")
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 12.0) {
                    Text("Join GardenAR")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)

                    Text("Personal information")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding(.top, 12.0)
                    
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
                    
                    Text("Account Information")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding(.top, 12.0)
                    
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
                    
                    Text("Gardening information")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding(.top, 12.0)
                    
                    Menu {
                        ForEach(self.skillOptions, id: \.self) { item in
                            Button(item, action: {
                                self.skill = item
                            })
                        }
                    } label : {
                        Image(systemName: "rosette")
                            .frame(width: 24.0, alignment: .leading)
                            .foregroundStyle(.black)
                        
                        TextField("Skill level", text: self.$skill)
                            .disabled(true)
                            .multilineTextAlignment(.leading)
                        
                        Spacer()
                        Image(systemName: "chevron.down")
                            .foregroundStyle(.black)
                    }
                    .padding(12.0)
                    .background(.white)
                    .clipShape(.rect(cornerRadius: 6.0))
                    
                    Text("Location")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding(.top, 12.0)
                    
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
                        Spacer()
                        Text("Sign up")
                            .foregroundStyle(.white)
                        
                        Spacer()
                    }
                    .padding(12.0)
                    .background(.black)
                    .clipShape(.rect(cornerRadius: 6.0))

                    HStack {
                        Text("Already have an account?")
                            .foregroundStyle(.white)
                        
                        Button(action: self.toggle) {
                            Text("Log in")
                                .foregroundStyle(.green)
                            
                        }
                    }
                }
                .padding(.horizontal)
            }
            
        }
    }
}

#Preview {
    NavigationStack {
        RegisterView(showLogin: .constant(false), loggedIn: .constant(false))
    }
}

