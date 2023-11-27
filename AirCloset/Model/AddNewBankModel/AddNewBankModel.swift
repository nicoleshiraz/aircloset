//
//  AddNewBankModel.swift
//  AirCloset
//
//  Created by cql200 on 14/06/23.
//

import Foundation

struct AddNewBankModel: Codable {
    var success: Bool?
    var code: Int?
    var message: String?
    var body: AddNewBankModelBody?
}

// MARK: - Body
struct AddNewBankModelBody: Codable {
    var accountHolderName, accountHolderType, accountNumber, ifscCode: String?
    var stripeBankAccountID: String?
    var isDefault: Int?
    var userID, id, createdAt, updatedAt: String?
    var v: Int?

    enum CodingKeys: String, CodingKey {
        case accountHolderName, accountHolderType, accountNumber, ifscCode
        case stripeBankAccountID = "stripeBankAccountId"
        case isDefault
        case userID = "userId"
        case id = "_id"
        case createdAt, updatedAt
        case v = "__v"
    }
}

