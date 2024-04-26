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
            if let token = token {
                UserDefaults.standard.set(token, forKey: "token")
                self.loggedIn = true
            } else {
                // to do: tell the user to check their credentials
            }
        } catch {}
    }
    
    func toggle() {
        self.showLogin = false
    }
    
    var body: some View {
        ZStack {
            Color("Colors/Alt")
                .ignoresSafeArea()
            
            VStack(spacing: 12.0) {
                Image("Images/LogoNoText")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300)
                
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
                    Image(systemName: "lock.fill")
                        .frame(width: 24.0, alignment: .leading)
                    
                    SecureField("Password", text: self.$password)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                }
                .padding(12.0)
                .background(.white)
                .clipShape(.rect(cornerRadius: 6.0))
                
                Button(action: {
                    Task {
                        await self.login()
                    }
                }) {
                    Spacer()
                    Text("Sign in")
                        .foregroundStyle(.white)
                    
                    Spacer()
                }
                .padding(12.0)
                .background(.black)
                .clipShape(.rect(cornerRadius: 6.0))
                
                HStack {
                    Text("Don't have an account?")
                        .foregroundStyle(.white)
                    
                    Button(action: self.toggle) {
                        Text("Sign up")
                            .foregroundStyle(.green)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    NavigationStack {
        LoginView(showLogin: .constant(true), loggedIn: .constant(false))
    }
}
