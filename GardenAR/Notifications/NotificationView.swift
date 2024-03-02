//
//  NotificationView.swift
//  GardenAR
//
//  Created by Aashish Kapoor on 11/17/23.
//

import SwiftUI

struct NotificationView: View {
    
    @State var selectedNotificationCategory = "Favorites"
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24.0) {
                Picker(selection: $selectedNotificationCategory) {
                    Text("Favorites").tag("Direct Message")
                    Text("All").tag("All")
                    Text("Recurring").tag("Recurring")
                } label: {}
                    .pickerStyle(.segmented)
                VStack {
                    NotificationRow(thatOneOnly: "Test Notification 1")
                    NotificationRow(thatOneOnly: "Test Notification 2")
                    NotificationRow(thatOneOnly: "Test Notification 3")
                    NotificationRow(thatOneOnly: "Test Notification 4")
                    NotificationRow(thatOneOnly: "Test Notification 5")
                }
            }
        }
        .padding(.horizontal, 24.0)
        .navigationTitle("Notifications")
    }
}

#Preview {
    NotificationView()
}
