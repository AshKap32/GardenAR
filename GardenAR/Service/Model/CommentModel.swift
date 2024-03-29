//
//  CommentModel.swift
//  GardenAR
//
//  Created by KOBOLD! on 3/29/24.
//

import Foundation

struct CommentModel: Codable {
    var _comment_id: Int?
    var _post_id: Int?
    var _account_id: Int?
    var _content: String?
    var _timestamp: String?
}
