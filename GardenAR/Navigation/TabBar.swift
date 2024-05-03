//
//  TabBar.swift
//  GardenAR
//
//  Created by Aashish Kapoor on 11/10/23.
//

import Foundation
import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView {
            NavigationStack {
                GardenView()
            }
            .tabItem {
                Image(systemName: "leaf")
                Text("Garden")
            }
            
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

#Preview {
    TabBar()
}
