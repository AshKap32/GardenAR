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
    let skillOptions: [String] = ["Beginner", "Intermediate", "Professional"]
    
    func build() -> AccountModel {
        var skill: Int? = nil
        for (index, value) in self.skillOptions.enumerated() {
            if self.skill == value {
                skill = index
                break
            }
        }
        
        // print(skill)
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
                self.showLogin = true
            } else {
                // to do: tell the user about a potential username conflict + other errors
            }
        } catch {}
    }
    
    func toggle() {
        self.showLogin = true
    }
    
    // checks if any of the forms are empty
    func isformEmpty() -> Bool {
        let isFormEmpty = !username.isEmpty && !nickname.isEmpty && !forename.isEmpty && !surname.isEmpty && !email.isEmpty && !password.isEmpty && !skill.isEmpty && !city.isEmpty && !zip.isEmpty
        return isFormEmpty
    }
    
    // checks for email form has an "@"
    func isEmailValid() -> Bool {
        let isEmailValid = email.contains("@")
        return isEmailValid
    }
    
    // checks zip code for 5 number characters
    func isZipValid() -> Bool {
        let isZipValid = zip.contains("1234567890") && zip.count == 5
        return isZipValid
    }
    
    // checks for password with 6 or more characters, contains a number, special character and an uppercase character
    private func passwordValidation(_ password : String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[0-9])(?=.*[$@$#!%*?&])(?=.*[A-Z]).{6,}$")
        return passwordTest.evaluate(with: password)
    }

    var body: some View {
        ZStack {
            Color("Colors/Alt")
                .ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 12.0) {
                    Text("Join GardenAR")
                        .foregroundColor(.white)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(5)

                    Text("Personal Information")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 5)
                        .padding(.bottom, 5)
                    
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
                        .foregroundColor(.white)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .padding(.top, 10)
                        .padding(.top, 5)
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
                    
                    if !passwordValidation(password){
                        Text("Must be at least 6 characters long, contains number, an uppercase, and a special character.")
                            .foregroundColor(.white)
                    }
                    
                    Text("Gardening information")
                        .foregroundColor(.white)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .padding(.top, 10)
                        .padding(.top, 5)
                    
                    Menu {
                        ForEach(self.skillOptions, id: \.self) { item in
                            Button(item, action: {
                                self.skill = item
                            })
                        }
                    } label : {
                        Image(systemName: "rosette")
                            .frame(width: 24.0, alignment: .leading)
                            .foregroundColor(.black)
                        
                        TextField("Skill level", text: self.$skill)
                            .disabled(true)
                            .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                        
                        Spacer()
                        Image(systemName: "chevron.down")
                            .foregroundColor(.black)
                    }
                    .padding(12.0)
                    .background(.white)
                    .clipShape(.rect(cornerRadius: 6.0))
                    
                    Text("Location")
                        .foregroundColor(.white)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .padding(.top, 10)
                        .padding(.top, 5)
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
                    .disabled(!isformEmpty() && !isEmailValid())
                    .opacity(!isformEmpty() ? 0.5 : 1.0)

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
        RegisterView(showLogin: .constant(false))
    }
}
