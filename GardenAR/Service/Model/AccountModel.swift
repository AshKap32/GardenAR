//
//  AccountModel.swift
//  GardenAR
//
//  Created by KOBOLD! on 3/26/24.
//

import Foundation

struct AccountModel: Codable {
    var _account_id: Int?
    var _username: String?
    var _nickname: String?
    var _forename: String?
    var _surname: String?
    var _email: String?
    var _hash: String?
    var _skill: Int?
    var _city: String?
    var _zip: Int?
}
