//
//  DiscoverView.swift
//  GardenAR
//
//  Created by Aashish Kapoor on 11/17/23.
//

import Foundation
import SwiftUI

struct DiscoverView: View {
    var body: some View {
        VStack {
            HStack {
                VStack {
                    AsyncImage(url: URL(string: "https://media.houseandgarden.co.uk/photos/64e4d253e1a65c932c542b2e/master/w_1600%2Cc_limit/Screenshot%25202023-08-22%2520at%252016.20.41.png")) { image in
                        image
                            .image?
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: .infinity, height: 200.0)
                            .clipShape(.rect(cornerRadius: 8.0))
                    }
                    
                    Text("Spider Variety")
                }
                
                VStack {
                    AsyncImage(url: URL(string: "https://costafarms.com/cdn/shop/files/snake-plant-medium-white--white_2048x2048.jpg?v=1694799744")) { image in
                        image
                            .image?
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: .infinity, height: 200.0)
                            .clipShape(.rect(cornerRadius: 8.0))
                    }
                    
                    Text("Snake Variety")
                }
            }
            AsyncImage(url: URL(string: "https://hips.hearstapps.com/vader-prod.s3.amazonaws.com/1554477330-beautiful-asparagus-fern-plant-in-a-basket-royalty-free-image-972247932-1546889240.jpg?crop=0.457xw:0.301xh;0.447xw,0.372xh&resize=980:*")) { image in
                image
                    .image?
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: .infinity)
                    .clipShape(.rect(cornerRadius: 8.0))
            }
            
            Text("Fern Variety")
        }
        .navigationTitle("Discover")
        .padding(.horizontal, 32.0)
    }
}

#Preview {
    DiscoverView()
}
