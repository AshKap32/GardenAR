//
//  CompendiumModel.swift
//  GardenAR
//
//  Created by KOBOLD! on 3/15/24.
//

import SwiftUI

class CompendiumModel: Codable, ObservableObject {
    var compendiumID: Int?
    var name: String?
    var description: String?
    
    enum CodingKeys: String, CodingKey {
        case compendiumID = "_compendium_id"
        case name = "_name"
        case description = "_description"
    }
}
