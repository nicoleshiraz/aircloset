//
//  AcceptRejectModel.swift
//  AirCloset
//
//  Created by cql200 on 06/07/23.
//

import Foundation

struct AcceptRejectOrderModel: Codable {
    var success: Bool?
    var code: Int?
    var message: String?
    var body: AcceptRejectOrderModelBody?
}

// MARK: - Body
struct AcceptRejectOrderModelBody: Codable {
    var id, startDate, endDate: String?
    var totalDays, productPrice, totalPrice, status: Int?
    var serviceCharge: String?
    var phoneNumber: Int?
    var countryCode, address: String?
    var isReserved, cancelStatus, orderStatus, deleiveryStatus: Int?
    var returnClothStatus: Bool?
    var buyerID, productID, createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case startDate, endDate, totalDays, productPrice, totalPrice, status, serviceCharge, phoneNumber, countryCode, address, isReserved, cancelStatus, orderStatus, deleiveryStatus, returnClothStatus
        case buyerID = "buyerId"
        case productID = "productId"
        case createdAt, updatedAt
    }
}
