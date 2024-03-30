//
//  TabBar.swift
//  GardenAR
//
//  Created by Aashish Kapoor on 11/10/23.
//

import SwiftUI

struct TabBar: View {
    @Binding var loggedIn: Bool
    
    var body: some View {
        TabView {
            NavigationView {
                GardenView()
            }
            .tabItem {
                Image(systemName: "leaf")
                Text("Garden")
            }
            
            NavigationView {
                DiscoverView()
            }
            .tabItem {
                Image(systemName: "safari")
                Text("Discover")
            }
            
            NavigationView {
                EmptyView()
            }
            .tabItem {
                Image(systemName: "camera")
                Text("Scan")
            }
            
            NavigationView {
                CommunityView()
            }
            .tabItem {
                Image(systemName: "person.2")
                Text("Community")
            }
            
            NavigationView {
                SearchView()
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search")
            }
        }
    }
}

#Preview {
    TabBar(loggedIn: .constant(true))
}
