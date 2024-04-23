//
//  CompendiumRow.swift
//  GardenAR
//
//  Created by KOBOLD! on 4/22/24.
//

import Foundation
import SwiftUI

struct CompendiumRow: View {
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
        NavigationLink(destination: CompendiumInfo(compendium: self.compendium)) {
            HStack(spacing: 12.0) {
                AsyncImage(url: URL(string: self.compendium?._icon ?? "")) { image in
                    image.image?
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: 96.0, height: 96.0)
                .clipShape(.rect(cornerRadius: 6.0))
                
                Text(self.compendium?._name ?? "")
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
        CompendiumRow(compendiumId: -401)
    }
}
