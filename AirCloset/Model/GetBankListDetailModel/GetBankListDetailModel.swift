//
//  GetBankListDetailModel.swift
//  AirCloset
//
//  Created by cql200 on 14/06/23.
//

import Foundation
struct GetBankListDetailModel: Codable {
    var success: Bool?
    var code: Int?
    var message: String?
    var body: [GetBankListDetailModelBody]?
}

// MARK: - Body
struct GetBankListDetailModelBody: Codable {
    var id, accountHolderName, accountHolderType, accountNumber: String?
    var ifscCode, stripeBankAccountID: String?
    var isDefault: Int?
    var userID, createdAt, updatedAt: String?
    var v: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case accountHolderName, accountHolderType, accountNumber, ifscCode
        case stripeBankAccountID = "stripeBankAccountId"
        case isDefault
        case userID = "userId"
        case createdAt, updatedAt
        case v = "__v"
    }
}
