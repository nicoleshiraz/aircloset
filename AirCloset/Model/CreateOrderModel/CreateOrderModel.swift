//
//  CreateOrderModel.swift
//  AirCloset
//
//  Created by cql200 on 08/06/23.
//

import Foundation

struct CreateOrderModel: Codable {
    var success: Bool?
    var code: Int?
    var message: String?
    var body: CreateOrderModelBody?
}

// MARK: - Body
struct CreateOrderModelBody: Codable {
    var startDate, endDate: String?
    var totalDays, productPrice, totalPrice, status: Int?
    var serviceCharge: Int?
    var phoneNumber: Int?
    var countryCode,address: String?
    var isReserved, cancelStatus, orderStatus, deleiveryStatus: Int?
    var returnClothStatus: Bool?
    var buyerID, productID, id, createdAt: String?
    var updatedAt: String?
    var v: Int?

    enum CodingKeys: String, CodingKey {
        case startDate, endDate, totalDays, productPrice, totalPrice, status, serviceCharge, phoneNumber, address, isReserved, cancelStatus, orderStatus, deleiveryStatus, returnClothStatus
        case buyerID = "buyerId"
        case productID = "productId"
        case id = "_id"
        case createdAt, updatedAt
        case v = "__v"
    }
}
