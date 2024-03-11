//
//  AuthenticationView.swift
//  GardenAR
//
//  Created by Aashish Kapoor on 11/17/23.
//

import SwiftUI

struct AuthenticationView: View {
    
    @State var modal: AuthModel = .login
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
        if modal == .login {
            login
        } else {
            register
        }
    }
    
    var login: some View {
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
                
              
                
                Button(action: {
                    
                }) {
                    Text("Sign In")
                        .tint(.white)
                }
                .padding()
   
                Button(action: {
                    
                }){
                    Text("Create Account")
                        .tint(.white)
                }
              
                Spacer()
            }
            
            .padding(24.0)
        }
        .background(Color("74C98B"))
    }
    
    var register: some View {
        VStack {
            
        }
    }
}

#Preview {
    AuthenticationView()
}

enum AuthModel {
    case login
    case register
}

