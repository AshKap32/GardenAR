//
//  ErrorModel.swift
//  GardenAR
//
//  Created by KOBOLD! on 3/26/24.
//

import Foundation

struct ErrorReply: Codable {
    var error: String?
    var message: String?
    var statusCode: Int?
}
