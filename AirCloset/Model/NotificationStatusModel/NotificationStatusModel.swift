//
//  NotificationStatusModel.swift
//  AirCloset
//
//  Created by cql200 on 11/05/23.
//

import Foundation

struct NotificationStatus: Codable {
    var success: Bool?
    var code: Int?
    var message: String?
    var body: NotificationStatusBody?
}

// MARK: - Body
struct NotificationStatusBody: Codable {
    var id, name, email: String?
    var phoneNumber: Int?
    var countryCode, countryCodePhonenumber, password: String?
    var idVerification, role: Int?
    var image: String?
    var isAdmin: Bool?
    var loginTime: Int?
    var securityKey, token: String?
    var bio: String?
    var isNotification: Int?
    var createdAt, updatedAt: String?
    var v, otp: Int?
    var forgotPasswordToken: String?
    var otpVerified: Int?
    var ranToken, deviceToken: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, email, phoneNumber, countryCode
        case countryCodePhonenumber = "countryCode_phonenumber"
        case password, idVerification, role, image, isAdmin
        case loginTime = "login_time"
        case securityKey = "security_key"
        case token, bio, isNotification, createdAt, updatedAt
        case v = "__v"
        case otp, forgotPasswordToken, otpVerified, ranToken, deviceToken
    }
}
