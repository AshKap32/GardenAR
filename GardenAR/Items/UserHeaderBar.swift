//
//  UserHeaderBar.swift
//  GardenAR
//
//  Created by Aashish Kapoor on 11/10/23.
//

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
            
            guard let username = account._nickname ?? account._username else {
                return
            }
            
            self.username = username
        } catch {
            
        }
    }
    
    var body: some View {
        HStack(spacing: 16.0) {
            VStack(alignment: .leading, spacing: 6.0) {
                Text("Welcome \(self.username) 👋").font(.title2).fontWeight(.bold)
                Text("\(Date(), format: .dateTime.weekday(Date.FormatStyle.Symbol.Weekday.wide)), \(Date(), format: .dateTime.month(Date.FormatStyle.Symbol.Month.wide).day().year())").fontWeight(.medium)
            }
            
            Spacer()
            NavigationLink(destination: NotificationView()) {
                Image(systemName: "bell")
            }
            .buttonStyle(.plain)
            
            Image(systemName: "heart")
        }.task {
            await self.fetch()
        }
    }
}

#Preview {
    UserHeaderBar()
}
