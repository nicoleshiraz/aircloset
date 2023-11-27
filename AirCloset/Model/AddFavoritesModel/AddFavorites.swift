//
//  AddFavorites.swift
//  AirCloset
//
//  Created by cql200 on 19/05/23.
//

import Foundation

struct AddFavoritesModel: Codable {
    var success: Bool?
    var code: Int?
    var message: String?
    var body: AddFavoritesBody?
}

// MARK: - Body
struct AddFavoritesBody: Codable {
    var type: Int?
    var productID, userID, id, createdAt: String?
    var updatedAt: String?
    var v: Int?

    enum CodingKeys: String, CodingKey {
        case type
        case productID = "productId"
        case userID = "userId"
        case id = "_id"
        case createdAt, updatedAt
        case v = "__v"
    }
}
