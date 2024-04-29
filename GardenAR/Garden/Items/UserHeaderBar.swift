//
//  UserHeaderBar.swift
//  GardenAR
//
//  Created by Aashish Kapoor on 11/10/23.
//

import Foundation
import SwiftUI

struct UserHeaderBar: View {
    @State var account: AccountModel?
    
    func fetch() async {
        do {
            guard let token = UserDefaults.standard.string(forKey: "token") else {
                return
            }
            
            let (account, _) = try await AccountNetwork.getAccount(token: token)
            if let account = account {
                self.account = account
            }
        } catch {}
    }
    
    func formatDate(date: Date) -> String {
        let weekday = date.formatted(.dateTime.weekday(Date.FormatStyle.Symbol.Weekday.wide))
        let date = date.formatted(.dateTime.month(Date.FormatStyle.Symbol.Month.wide).day().year())
        return "\(weekday), \(date)"
    }
    
    var body: some View {
        HStack(spacing: 12.0) {
            VStack(alignment: .leading) {
                Text(self.account?._nickname ?? self.account?._username ?? "")
                    .font(.title)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                
                Text(formatDate(date: Date.now))
            }
            
            Spacer()
            NavigationLink(destination: NotificationView()) {
                Image(systemName: "bell")
            }
            .buttonStyle(.plain)
            
            NavigationLink(destination: AddPlantView()) {
                Image(systemName: "plus")
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
