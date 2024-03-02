//
//  User.swift
//  GardenAR
//
//  Created by Aashish Kapoor on 11/10/23.
//

import SwiftUI

class User: Codable, ObservableObject {
    var userID: String
    var name: String
    var firstName: String
    var lastName: String
    var emailAddress: String
    var userName: String
    var skillLevel: String
    var city: String
    var zipCode: Int
}
