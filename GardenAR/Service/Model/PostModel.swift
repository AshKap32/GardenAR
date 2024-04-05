//
//  PostModel.swift
//  GardenAR
//
//  Created by KOBOLD! on 3/26/24.
//

import Foundation

struct PostModel: Codable, Hashable {
    var _post_id: Int?
    var _account_id: Int?
    var _content: String?
    var _timestamp: String?
}