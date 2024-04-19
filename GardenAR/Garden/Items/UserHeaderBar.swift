//
//  UserHeaderBar.swift
//  GardenAR
//
//  Created by Aashish Kapoor on 11/10/23.
//

import Foundation
import SwiftUI

struct UserHeaderBar: View {
    @State var username = "Aashish"
    
    func fetch() async {
        do {
            guard let token = UserDefaults.standard.string(forKey: "token") else {
                return
            }
            
            let (account, _) = try await AccountNetwork.getAccount(token: token)
            guard let account = account else {
                return
            }
            
            if let username = account._nickname ?? account._username {
                self.username = username
            }
        } catch {}
    }
    
    var body: some View {
        HStack(spacing: 12.0) {
            VStack(alignment: .leading) {
                Text("Welcome \(self.username) 👋")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("\(Date(), format: .dateTime.weekday(Date.FormatStyle.Symbol.Weekday.wide)), \(Date(), format: .dateTime.month(Date.FormatStyle.Symbol.Month.wide).day().year())")
            }
            
            Spacer()
            NavigationLink(destination: NotificationView()) {
                Image(systemName: "bell")
            }
            .buttonStyle(.plain)
            
            Image(systemName: "heart")
        }
        .task {
            await self.fetch()
        }
    }
}

#Preview {
    UserHeaderBar()
}
