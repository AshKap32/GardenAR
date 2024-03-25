//
//  AccountModel.swift
//  GardenAR
//
//  Created by KOBOLD! on 3/15/24.
//

import SwiftUI

class AccountModel: Codable, ObservableObject {
    var accountID: String?
    var username: String?
    var nickname: String?
    var forename: String?
    var surname: String?
    var email: String?
    var hash: String?
    var skill: String?
    var city: String?
    var zip: String?
    
    enum CodingKeys: String, CodingKey {
        case accountID = "_account_id"
        case username = "_username"
        case nickname = "_nickname"
        case forename = "_forename"
        case surname = "_surname"
        case email = "_email"
        case hash = "_hash"
        case skill = "_skill"
        case city = "_city"
        case zip = "_zip"
    }
}
