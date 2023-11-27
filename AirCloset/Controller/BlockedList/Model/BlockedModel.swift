//
//  BlockedModel.swift
//  AirCloset
//
//  Created by cqlios3 on 24/07/23.
//

import Foundation

// MARK: - BlockedListModel
struct BlockedListModel: Codable {
    var success: Bool?
    var code: Int?
    var message: String?
    var body: [BlockedListModelBody]?
}

// MARK: - Body
struct BlockedListModelBody: Codable {
    var id, name, image, bio: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, image, bio
    }
}
