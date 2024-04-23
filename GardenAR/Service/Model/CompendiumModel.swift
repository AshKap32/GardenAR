//
//  CompendiumModel.swift
//  GardenAR
//
//  Created by KOBOLD! on 3/26/24.
//

import Foundation

struct CompendiumModel: Codable, Hashable {
    var _compendium_id: Int?
    var _name: String?
    var _description: String?
    var _icon: String?
    var _lighting: Int?
    var _depth: String?
    var _spacing: String?
    var _germination: Int?
    var _maturity: Int?
}
