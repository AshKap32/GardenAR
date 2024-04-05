//
//  SearchView.swift
//  GardenAR
//
//  Created by Aashish Kapoor on 11/10/23.
//

import Foundation
import SwiftUI

struct SearchView: View {
    @State var compendia: [CompendiumModel] = []
    @State var searchText = ""
    
    func fetch() async {
        do {
            let (compendia, _) = try await CompendiumNetwork.getCompendia()
            guard let compendia = compendia else {
                return
            }
            
            self.compendia = compendia
        } catch {
            
        }
    }
    
    var body: some View {
        ScrollView {
            ForEach(self.compendia, id: \.self) { compendium in
                CompendiumRow(compendiumId: compendium._compendium_id!)
            }
        }
        .scrollIndicators(.hidden)
        .padding(.horizontal, 32.0)
        .searchable(text: self.$searchText, placement: .navigationBarDrawer(displayMode: .always))
        .task {
            await self.fetch()
        }
    }
}

#Preview {
    SearchView()
}
