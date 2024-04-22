//
//  SearchInfo.swift
//  GardenAR
//
//  Created by KOBOLD! on 4/4/24.
//

import Foundation
import SwiftUI

struct CompendiumInfo: View {
    @State var name = ""
    @State var description = ""
    @State var icon = ""
    @State var lighting = 0
    @State var depth = 0.0
    @State var spacing = 0.0
    @State var germination = 0
    @State var maturity = 0
    var compendiumId: Int
    
    func fetch() async {
        do {
            let (compendium, _) = try await CompendiumNetwork.getCompendium(compendiumId: self.compendiumId)
            if let compendium = compendium {
                self.icon = compendium._icon!
                self.name = compendium._name!
                self.description = compendium._description!
                self.lighting = compendium._lighting!
                self.depth = Double(compendium._depth!)!
                self.spacing = Double(compendium._spacing!)!
                self.germination = compendium._germination!
                self.maturity = compendium._maturity!
            }
        } catch {}
    }
    
    var body: some View {
        ScrollView {
            Text(self.description)
            AsyncImage(url: URL(string: self.icon)) { image in
                image
                    .image?
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 192.0, height: 192.0)
                    .clipShape(.rect(cornerRadius: 6.0))
            }
        }
        .scrollIndicators(.hidden)
        .navigationTitle(self.name)
        .navigationBarTitleDisplayMode(.inline)
        .padding(.horizontal, 24.0)
        .task {
            await self.fetch()
        }
    }
}

#Preview {
    NavigationStack {
        CompendiumInfo(compendiumId: -401)
    }
}
