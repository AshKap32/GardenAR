//
//  SearchRow.swift
//  GardenAR
//
//  Created by KOBOLD! on 4/4/24.
//

import Foundation
import SwiftUI

struct CompendiumRow: View {
    @State var name = "Plant Type"
    @State var icon = "https://cdn.shopify.com/s/files/1/0150/6262/products/the_sill-variant-white_gloss-money_tree.jpg?v=1699404852"
    var compendiumId: Int
    
    func fetch() async {
        do {
            let (compendium, _) = try await CompendiumNetwork.getCompendium(compendiumId: compendiumId)
            guard let compendium = compendium else {
                return
            }
            
            self.icon = compendium._icon!
            self.name = compendium._name!
        } catch {
            
        }
    }
    
    var body: some View {
        NavigationLink(destination: CompendiumInfo(compendiumId: self.compendiumId)) {
            HStack(spacing: 16.0) {
                AsyncImage(url: URL(string: self.icon)) { image in
                    image
                        .image?
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 75.0, height: 75.0)
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
    CompendiumRow(compendiumId: -401)
}