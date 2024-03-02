//
//  GardenView.swift
//  GardenAR
//
//  Created by Aashish Kapoor on 11/10/23.
//

import SwiftUI

struct GardenView: View {
    var body: some View {
        ScrollView {
            Group {
                UserHeaderBar()
                ForEach(0..<6) { plant in
                    PlantRow()
                }
            }
            .padding(24.0)
        }
    }
}

#Preview {
    GardenView()
}
