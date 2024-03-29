//
//  Post.swift
//  GardenAR
//
//  Created by Aashish Kapoor on 11/17/23.
//

import SwiftUI

struct Post: View {
    var text: String

    init(text: String) {
        self.text = text
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16.0) {
            Text(self.text)
            HStack(spacing: 8.0) {
                Button(action: {}) {
                    Image(systemName: "heart")
                }
                
                Spacer()
                Button(action: {}) {
                    Image(systemName: "bubble.left.and.text.bubble.right")
                }
                
                Spacer()
                Button(action: {}) {
                    Image(systemName: "arrowshape.turn.up.right")
                }
            }
        }
    }
}

#Preview {
    Post(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
}
