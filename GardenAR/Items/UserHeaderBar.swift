//
//  UserHeaderBar.swift
//  GardenAR
//
//  Created by Aashish Kapoor on 11/10/23.
//

import SwiftUI

struct UserHeaderBar: View {
    @State var username = "Aashish"
    
    func fetch() {
        Task {
            let token = UserDefaults.standard.string(forKey: "token") ?? ""
            let (account, e) = try await AccountNetwork.getAccount(token: token)
            if e.error == nil {
                guard let account = account else {
                    return
                }
                
                if let name = account._nickname ?? account._username {
                    self.username = name
                }
            }
        }
    }
    
    var body: some View {
        HStack(spacing: 16.0) {
            VStack(alignment: .leading, spacing: 6.0) {
                Text("Welcome \(self.username) 👋").font(.title2).fontWeight(.bold).task {
                    self.fetch()
                }
                
                Text("\(Date(), format: .dateTime.weekday(Date.FormatStyle.Symbol.Weekday.wide)), \(Date(), format: .dateTime.month(Date.FormatStyle.Symbol.Month.wide).day().year())").fontWeight(.medium)
            }
            
            Spacer()
            NavigationLink(destination: NotificationView()) {
                Image(systemName: "bell")
            }
            .buttonStyle(.plain)
            
            Image(systemName: "heart")
        }
    }
}

#Preview {
    UserHeaderBar()
}
