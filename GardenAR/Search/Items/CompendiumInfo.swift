//
//  SearchInfo.swift
//  GardenAR
//
//  Created by KOBOLD! on 4/4/24.
//

import Foundation
import SwiftUI

struct CompendiumInfo: View {
    @State var compendium: CompendiumModel?
    var compendiumId: Int?
    
    func fetch() async {
        do {
            guard let compendiumId = self.compendiumId else {
                return
            }
            
            let (compendium, _) = try await CompendiumNetwork.getCompendium(compendiumId: compendiumId)
            if let compendium = compendium {
                self.compendium = compendium
            }
        } catch {}
    }
    
    var body: some View {
        ScrollView {
            AsyncImage(url: URL(string: self.compendium?._icon ?? "")) { image in
                image.image?
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .frame(width: 192.0, height: 192.0)
            .clipShape(.rect(cornerRadius: 6.0))
            
            Text(self.compendium?._description ?? "")
        }
        .scrollIndicators(.hidden)
        .navigationTitle(self.compendium?._name ?? "")
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
