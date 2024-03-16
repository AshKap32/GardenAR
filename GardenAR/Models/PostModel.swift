//
//  PostModel.swift
//  GardenAR
//
//  Created by KOBOLD! on 3/15/24.
//

import SwiftUI

class PostModel: Codable, ObservableObject {
    var postID: Int?
    var accountID: Int?
    var content: String?
    
    enum CodingKeys: String, CodingKey {
        case postID = "_post_id"
        case accountID = "_account_id"
        case content = "_content"
    }
}