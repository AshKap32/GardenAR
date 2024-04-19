//
//  SearchInfo.swift
//  GardenAR
//
//  Created by KOBOLD! on 4/4/24.
//

import Foundation
import SwiftUI

struct CompendiumInfo: View {
    @State var name = "Plant Type"
    @State var description = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    @State var icon = "https://cdn.shopify.com/s/files/1/0150/6262/products/the_sill-variant-white_gloss-money_tree.jpg?v=1699404852"
    var compendiumId: Int
    
    func fetch() async {
        do {
            let (compendium, _) = try await CompendiumNetwork.getCompendium(compendiumId: self.compendiumId)
            if let compendium = compendium {
                self.icon = compendium._icon!
                self.name = compendium._name!
                self.description = compendium._description!
            }
        } catch {}
    }
    
    var body: some View {
        ScrollView {
            AsyncImage(url: URL(string: self.icon)) { image in
                image
                    .image?
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 192.0, height: 192.0)
                    .clipShape(.rect(cornerRadius: 6.0))
            }
            
            Text(self.name)
                .font(.title2)
                .fontWeight(.bold)
            
            Text(self.description)
        }
        .scrollIndicators(.hidden)
        .padding(.horizontal, 24.0)
        .task {
            await self.fetch()
        }
    }
}

#Preview {
    CompendiumInfo(compendiumId: -401)
}
