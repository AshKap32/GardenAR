//
//  NotificationRow.swift
//  GardenAR
//
//  Created by Aashish Kapoor on 11/17/23.
//

import Foundation
import SwiftUI

struct NotificationRow: View {
    var thatOneOnly = ""
    
    var body: some View {
        Label(thatOneOnly, systemImage: "bell")
            .padding()
            .frame(maxWidth: .infinity)
            .background(.tertiary)
    }
}

#Preview {
    NotificationRow()
}
