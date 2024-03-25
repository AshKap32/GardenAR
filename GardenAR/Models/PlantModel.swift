//
//  PlantModel.swift
//  GardenAR
//
//  Created by KOBOLD! on 3/15/24.
//

import SwiftUI

class PlantModel: Codable, ObservableObject {
    var plantID: String?
    var compendiumID: String?
    var accountID: String?
    var datePlanted: String?
    
    enum CodingKeys: String, CodingKey {
        case plantID = "_plant_id"
        case compendiumID = "_compendium_id"
        case accountID = "_account_id"
        case datePlanted = "_date_planted"
    }
}
