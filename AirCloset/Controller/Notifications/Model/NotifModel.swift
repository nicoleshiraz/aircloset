//
//  NotifModel.swift
//  AirCloset
//
//  Created by cqlios3 on 08/08/23.
//

import Foundation

// MARK: - NotifModel
struct NotifModel: Codable {
    var success: Bool?
    var code: Int?
    var message: String?
    var body: [NotifModelBody]?
}

// MARK: - Body
struct NotifModelBody: Codable {
    var id, message: String?
    var senderID, receiverID: NotifModelBodyErID?
    var type: Int?
    var createdAt, updatedAt, productName: String?
    var v: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case message
        case senderID = "senderId"
        case receiverID = "receiverId"
        case type, createdAt, updatedAt, productName
        case v = "__v"
    }
}

// MARK: - ErID
struct NotifModelBodyErID: Codable {
    var id, name, email: String?
    var phoneNumber: Int?
    var countryCode, countryCodePhonenumber, password: String?
    var idVerification, role: Int?
    var latitude, longitude, image: String?
    var isAdmin: Bool?
    var loginTime: Int?
    var securityKey: Int?
    var otp, otpVerified: Int?
    var token, bio, ranToken: String?
    var isVerified, isNotification: Int?
    var customerID, termAndCondition, stripeAccountID: String?
    var wallet: Double?
    var createdAt, updatedAt, deviceToken, productName: String?
    var deviceType: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, email, phoneNumber, countryCode
        case countryCodePhonenumber = "countryCode_phonenumber"
        case password, idVerification, role, latitude, longitude, image, isAdmin
        case loginTime = "login_time"
        case securityKey = "security_key"
        case otp, otpVerified, token, bio, ranToken, isVerified, isNotification
        case customerID = "customerId"
        case termAndCondition
        case stripeAccountID = "stripeAccountId"
        case wallet, createdAt, updatedAt, deviceToken, deviceType, productName
    }
}
