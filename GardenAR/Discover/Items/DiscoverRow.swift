//
//  DiscoverRow.swift
//  GardenAR
//
//  Created by KOBOLD! on 4/21/24.
//

import Foundation
import SwiftUI

struct DiscoverRow: View {
    @State var category: CategoryModel?
    var categoryId: Int?
    
    func fetch() async {
        do {
            guard let categoryId = self.categoryId else {
                return
            }
            
            let (category, _) = try await CategoryNetwork.getCategory(categoryId: categoryId)
            if let category = category {
                self.category = category
            }
        } catch {}
    }
    
    var body: some View {
        NavigationLink(destination: SearchView(category: self.category)) {
            HStack(spacing: 12.0) {
                AsyncImage(url: URL(string: self.category?._icon ?? "")) { image in
                    image.image?
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: 96.0, height: 96.0)
                .clipShape(.rect(cornerRadius: 8.0))
                
                Text(self.category?._name ?? "")
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
