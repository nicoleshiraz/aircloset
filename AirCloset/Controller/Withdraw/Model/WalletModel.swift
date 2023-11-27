//
//  WalletModel.swift
//  AirCloset
//
//  Created by cqlios3 on 03/08/23.
//

import Foundation

// MARK: - WalletModel
struct WalletModel: Codable {
    let success: Bool?
    let code: Int?
    let message: String?
    let body: WalletModelBody?
}

// MARK: - Body
struct WalletModelBody: Codable {
    let response: WalletModelResponse?
    let getTransactionDetail: [WalletModelGetTransactionDetail]?
}

// MARK: - GetTransactionDetail
struct WalletModelGetTransactionDetail: Codable {
    let paymentProcess: Int?
    let id, orderID: String?
    let name: String?
    let paidFrom: String?
    let paidTo: String?
    let amount: Int?
    let stripeTrasectionID: String?
    let paymentMethod: Int?
    let createdAt, updatedAt: String?
    let v: Int?

    enum CodingKeys: String, CodingKey {
        case paymentProcess
        case id = "_id"
        case orderID = "orderId"
        case name, paidFrom, paidTo, amount
        case stripeTrasectionID = "stripeTrasectionId"
        case paymentMethod, createdAt, updatedAt
        case v = "__v"
    }
}

// MARK: - Response
struct WalletModelResponse: Codable {
    let wallet: Int?
}
