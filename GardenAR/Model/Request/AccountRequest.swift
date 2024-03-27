//
//  AccountRequest.swift
//  GardenAR
//
//  Created by KOBOLD! on 3/26/24.
//

import Foundation

struct AccountRequest: Codable {
    var _account: AccountModel?
    var _username: String?
    var _password: String?
}
