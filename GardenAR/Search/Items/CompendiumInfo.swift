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
            Text(self.compendium?._description ?? "")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 12.0)
            
            HStack(spacing: 12.0) {
                VStack(spacing: 12.0) {
                    AsyncImage(url: URL(string: self.compendium?._icon ?? "")) { image in
                        image.image?
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    .frame(width: 192.0, height: 192.0)
                    .clipShape(.rect(cornerRadius: 6.0))
                    
                    Spacer()
                }
                
                VStack(spacing: 12.0) {
                    VStack {
                        Text("Lighting")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text("\(String(self.compendium?._lighting ?? 0)) hours")
                            .font(.subheadline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    VStack {
                        Text("Depth")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text("\(self.compendium?._depth ?? "0") inches")
                            .font(.subheadline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Spacing")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text("\(self.compendium?._spacing ?? "0") inches")
                            .font(.subheadline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    
                    VStack(alignment: .leading) {
                        Text("Days to germinate")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text("\(String(self.compendium?._germination ?? 0)) days")
                            .font(.subheadline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Days to maturity")
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text("\(String(self.compendium?._maturity ?? 0)) days")
                            .font(.subheadline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    Spacer()
                }
            }
        }
        .scrollIndicators(.hidden)
        .navigationTitle(self.compendium?._name ?? "")
        .navigationBarTitleDisplayMode(.large)
        .padding(.horizontal)
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
