//
//  GetCardListDetailModel.swift
//  AirCloset
//
//  Created by cql200 on 08/06/23.
//

import Foundation

//struct GetCardListDetailModel: Codable {
//    var success: Bool?
//    var code: Int?
//    var message: String?
//    var body: [GetCardListDetailModelBody]?
//}
//
//// MARK: - Body
//struct GetCardListDetailModelBody: Codable {
//    var id, brand: String?
//    var number: Int?
//    var cardStripeID: String?
//    var isDefault: Int?
//    var userID, createdAt, updatedAt: String?
//    var v: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case id = "_id"
//        case brand, number
//        case cardStripeID = "cardStripeId"
//        case isDefault
//        case userID = "userId"
//        case createdAt, updatedAt
//        case v = "__v"
//    }
//}
//

struct GetCardListDetailModel: Codable {
    var success: Bool?
    var code: Int?
    var message: String?
    var body: [GetCardListDetailModelBody]?
}

// MARK: - Body
struct GetCardListDetailModelBody: Codable {
    var id, brand: String?
    var number: Int?
    var cardStripeID: String?
    var isDefault: Int?
    var userID, createdAt, updatedAt: String?
    var v: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case brand, number
        case cardStripeID = "cardStripeId"
        case isDefault
        case userID = "userId"
        case createdAt, updatedAt
        case v = "__v"
    }
}
