//
//  AccountModel.swift
//  GardenAR
//
//  Created by KOBOLD! on 3/15/24.
//

import SwiftUI

class AccountModel: Codable, ObservableObject {
    var accountID: Int?
    var username: String?
    var nickname: String?
    var forename: String?
    var surname: String?
    var email: String?
    var skill: Int?
    var city: String?
    var zip: Int?
    
    enum CodingKeys: String, CodingKey {
        case accountID = "_account_id"
        case username = "_username"
        case nickname = "_nickname"
        case forename = "_forename"
        case surname = "_surname"
        case email = "_email"
        case skill = "_skill"
        case city = "_city"
        case zip = "_zip"
    }
}
