//
//  LoginView.swift
//  GardenAR
//
//  Created by KOBOLD! on 3/10/24.
//

import SwiftUI

struct LoginView: View {
    @State var email: String = ""
    @State var password: String = ""
    @Binding var displayLogin: Bool
    @Binding var loggedIn: Bool
    
    func validate() -> Bool {
        // to do: hook this up to the backend
        return true
    }
    
    func login() {
        if validate() {
            loggedIn.toggle()
        } else {
            // to do: display an error message
        }
    }
    
    func toggle() {
        displayLogin.toggle()
    }
    
    var body: some View {
        ZStack {
            VStack {
                Image("GardenARN")
                    .resizable()
                    .frame(width: 329, height: 273)
                
                HStack(spacing: 12.0) {
                    Image(systemName: "envelope")
                    TextField("Email", text: $email)
                }
                .padding(20.0)
                .background(.tertiary)
                .clipShape(RoundedRectangle(cornerRadius: 16.0))
                
                HStack(spacing: 12.0) {
                    Image(systemName: "lock")
                    SecureField("Password", text: $password)
                }
                .padding(20.0)
                .background(.tertiary)
                .clipShape(RoundedRectangle(cornerRadius: 16.0))
                
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
            .padding(24.0)
        }
        .background(Color("74C98B"))
    }
}

#Preview {
    LoginView(displayLogin: .constant(true), loggedIn: .constant(false))
}
