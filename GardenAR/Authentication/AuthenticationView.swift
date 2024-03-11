//
//  AuthenticationView.swift
//  GardenAR
//
//  Created by Aashish Kapoor on 11/17/23.
//

import SwiftUI

struct AuthenticationView: View {
    @State var displayLogin = true
    @Binding var loggedIn: Bool
    
    var body: some View {
        if displayLogin {
            LoginView(displayLogin: $displayLogin, loggedIn: $loggedIn)
        } else {
            RegisterView(displayLogin: $displayLogin)
        }
    }
}

#Preview {
    AuthenticationView(loggedIn: .constant(false))
}
