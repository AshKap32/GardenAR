//
//  ContentView.swift
//  GardenAR
//
//  Created by Aashish Kapoor on 11/10/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var isLoggedIn = true
    
    var body: some View {
        if isLoggedIn {
            TabBar()
        } else {
            Text("Login View Here")
        }
    }
}

#Preview {
    ContentView()
}
