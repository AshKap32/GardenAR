//
//  DiscoverRow.swift
//  GardenAR
//
//  Created by KOBOLD! on 4/21/24.
//

import Foundation
import SwiftUI

struct DiscoverRow: View {
    @State var name = ""
    @State var icon = ""
    var categoryId: Int
    
    func fetch() async {
        do {
            let (category, _) = try await CategoryNetwork.getCategory(categoryId: self.categoryId)
            if let category = category {
                self.name = category._name!
                self.icon = category._icon!
            }
        } catch {}
    }
    
    var body: some View {
        NavigationLink(destination: SearchView(categoryId: self.categoryId, name: self.name)) {
            HStack(spacing: 12.0) {
                AsyncImage(url: URL(string: self.icon)) { image in
                    image
                        .image?
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 96.0, height: 96.0)
                        .clipShape(.rect(cornerRadius: 8.0))
                }
                
                Text(self.name)
                Spacer()
            }
        }
        .buttonStyle(.plain)
        .task {
            await self.fetch()
        }
    }
}

#Preview {
    NavigationStack {
        DiscoverRow(categoryId: -501)
    }
}
