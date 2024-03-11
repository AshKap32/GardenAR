//
//  ContentView.swift
//  GardenAR
//
//  Created by Aashish Kapoor on 11/10/23.
//

import SwiftUI

struct ContentView: View {
    @State var loggedIn = false
    
    var body: some View {
        if loggedIn {
            TabBar()
        } else {
            AuthenticationView(loggedIn: $loggedIn)
        }
    }
}

#Preview {
    ContentView()
}
