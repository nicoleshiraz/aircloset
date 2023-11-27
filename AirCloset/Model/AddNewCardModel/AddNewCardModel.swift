//
//  AddNewCardModel.swift
//  AirCloset
//
//  Created by cql200 on 08/06/23.
//

import Foundation

struct AddNewCardModel: Codable {
    var success: Bool?
    var code: Int?
    var message: String?
    var body: AddNewCardModelBody?
}

// MARK: - Body
struct AddNewCardModelBody: Codable {
    var brand: String?
    var number: Int?
    var cardStripeID: String?
    var isDefault: Int?
    var userID, id, createdAt, updatedAt: String?
    var v: Int?

    enum CodingKeys: String, CodingKey {
        case brand, number
        case cardStripeID = "cardStripeId"
        case isDefault
        case userID = "userId"
        case id = "_id"
        case createdAt, updatedAt
        case v = "__v"
    }
}




