//
//  UserHeaderBar.swift
//  GardenAR
//
//  Created by Aashish Kapoor on 11/10/23.
//

import SwiftUI

struct UserHeaderBar: View {
    var body: some View {
        HStack(spacing: 16.0) {
            VStack(alignment: .leading, spacing: 6.0) {
            Text("Welcome Aashish 👋")
                .font(.title2)
                .fontWeight(.bold)
                Text("\(Date(), format: .dateTime.weekday(Date.FormatStyle.Symbol.Weekday.wide)), \(Date(), format: .dateTime.month(Date.FormatStyle.Symbol.Month.wide).day().year())")
                    .fontWeight(.medium)
            }
            Spacer()
            NavigationLink(destination: NotificationView()) {
                Image(systemName: "bell")
            }
            .buttonStyle(.plain)
            Image(systemName: "heart")
        }
    }
}

#Preview {
    UserHeaderBar()
}
