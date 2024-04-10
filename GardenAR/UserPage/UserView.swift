//
//  UserView.swift
//  GardenAR
//
//  Created by Anh Thu Pham on 3/15/24.
//

import SwiftUI

struct UserView: View {
    var body: some View {
        // User header
        HStack {
            Circle()
                .fill(.gray)
                .frame(width: 100, height: 100)
            // user basic information
            VStack {
                Text("PlantUser").bold()
                Text("San Jose, CA")
                Text("Growing Zone 9b")
            }
            
        }.padding()
        Text("My Plants")
        
    }
}

#Preview {
    UserView()
}
