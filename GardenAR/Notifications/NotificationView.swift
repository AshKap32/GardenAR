//
//  NotificationView.swift
//  GardenAR
//
//  Created by Aashish Kapoor on 11/17/23.
//

import Foundation
import SwiftUI

struct NotificationView: View {
    @State var selectedNotificationCategory = "Favorites"
    
    var body: some View {
        VStack {
            Picker("", selection: $selectedNotificationCategory) {
                Text("Favorites")
                    .tag("Favorites")
                
                Text("All")
                    .tag("All")
                
                Text("Recurring")
                    .tag("Recurring")
            }
            .pickerStyle(.segmented)
            
            ScrollView {
                NotificationRow(thatOneOnly: "Test Notification 1")
                NotificationRow(thatOneOnly: "Test Notification 2")
                NotificationRow(thatOneOnly: "Test Notification 3")
                NotificationRow(thatOneOnly: "Test Notification 4")
                NotificationRow(thatOneOnly: "Test Notification 5")
            }
            .scrollIndicators(.hidden)
        }
        .padding(.horizontal, 32.0)
    }
}

#Preview {
    NotificationView()
}
