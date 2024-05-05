//
//  TabBar.swift
//  GardenAR
//
//  Created by Aashish Kapoor on 11/10/23.
//
//



import Foundation
import SwiftUI

struct TabBar: View {
    @Binding var loggedIn: Bool  // Add this to manage the login state

    var body: some View {
        TabView {
            NavigationStack {
                GardenView(loggedIn: $loggedIn)  // Pass loggedIn binding
            }
            .tabItem {
                Image(systemName: "leaf")
                Text("Garden")
            }
            
            // Other tabs remain unchanged...
            NavigationStack {
                DiscoverView()
            }
            .tabItem {
                Image(systemName: "safari")
                Text("Discover")
            }
            
            NavigationStack {
                ScanView()
            }
            .tabItem {
                Image(systemName: "camera")
                Text("Scan")
            }
            
            NavigationStack {
                CommunityView()
            }
            .tabItem {
                Image(systemName: "person.2")
                Text("Community")
            }
            
            NavigationStack {
                SearchView()
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search")
            }
        }
    }
}
