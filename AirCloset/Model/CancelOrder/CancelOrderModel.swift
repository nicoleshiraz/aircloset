//
//  CancelOrderModel.swift
//  AirCloset
//
//  Created by cqlios3 on 19/07/23.
//

import Foundation

// MARK: - OrderCancel
struct OrderCancel: Codable {
    let success: Bool?
    let code: Int?
    let message: String?
    let body: OrderCancelBody?
}

// MARK: - Body
struct OrderCancelBody: Codable {
    let id, startDate, endDate: String?
    let totalDays, productPrice, totalPrice, status: Int?
    let serviceCharge: Int?
    let phoneNumber: Int?
    let countryCode, address: String?
    let isReserved, cancelStatus, orderStatus, deleiveryStatus: Int?
    let returnClothStatus: Bool?
    let buyerID, productID, createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case startDate, endDate, totalDays, productPrice, totalPrice, status, serviceCharge, phoneNumber, countryCode, address, isReserved, cancelStatus, orderStatus, deleiveryStatus, returnClothStatus
        case buyerID = "buyerId"
        case productID = "productId"
        case createdAt, updatedAt
    }
}


// MARK: - ReciptModel
struct ReciptModel: Codable {
    let success: Bool?
    let code: Int?
    let message: String?
    let body: ReciptModelBody?
}

// MARK: - Body
struct ReciptModelBody: Codable {
    let productName: String?
    let serviceCharge: Double?
    let productPrice, shipping, orderType: Int?
    let pickupDate, returnDate: String?
    let totalPrice, totalDays, deposit: Int?
}
