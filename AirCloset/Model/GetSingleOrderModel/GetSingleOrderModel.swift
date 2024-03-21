//
//  GetSingleOrderModel.swift
//  AirCloset
//
//  Created by cql200 on 03/07/23.
//

import Foundation

struct GetSingleOrderModel: Codable {
    let success: Bool?
    let code: Int?
    let message: String?
    let body: GetSingleOrderModelBody?
}

// MARK: - Body
struct GetSingleOrderModelBody: Codable {
    let id, startDate,name, endDate, trackingID: String?
    let totalDays, productPrice, totalPrice, status: Int?
    let phoneNumber, orderType, isDepositReturned: Int?
    let countryCode, address: String?
    let isReserved, orderStatus, deleiveryStatus, feedBackStatus: Int?
    let returnClothStatus: Bool?
    let buyerID: ErID?
    let productID: ProductIIDD?
    let createdAt, updatedAt, image: String?
    let serviceCharge: Double?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case startDate, endDate, totalDays, productPrice, totalPrice, status, serviceCharge, phoneNumber, countryCode, address, isReserved, orderStatus, deleiveryStatus, returnClothStatus, feedBackStatus, orderType,name, image, isDepositReturned
        case buyerID = "buyerId"
        case productID = "productId"
        case createdAt, updatedAt
        case trackingID = "trackingId"
    }
}

// MARK: - ErID
struct ErID: Codable {
    let id, name, email: String?
    let phoneNumber: Int?
    let countryCode, countryCodePhonenumber, password: String?
    let idVerification, role: Int?
    let latitude, longitude, image: String?
    let isAdmin: Bool?
    let loginTime: Int?
    let securityKey: String?
    let otp, otpVerified: Int?
    let token, bio, ranToken: String?
    let isVerified, isNotification: Int?
    let customerID, termAndCondition, stripeAccountID: String?
    let wallet: Double?
    let createdAt, updatedAt, deviceToken: String?

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
        case wallet, createdAt, updatedAt, deviceToken
    }
}

// MARK: - ProductID
struct ProductIIDD: Codable {
    let location: Location?
    let id: String?
    let price: Int?
    let image: [String]?
    let video, description: String?
    let deposit: Int?
    let facilities: Facilitiess?
    let shipping: Int?
    let locationName: String?
    let isFavourite, isAvailable: Int?
    let brandID, sizeID, categoryID, styleID: IDdD?
    let colorID, conditionID: IDdD?
    let serviceCharge: ServiceCharge?
//    let serviceCharge: Double?
    let userID: ErID?
    let rating: Double?
    let termAddCondition, createdAt, updatedAt, thumbnail, name: String?
    let lat, long: Double?

    enum CodingKeys: String, CodingKey {
        case location
        case id = "_id"
        case price, image, video, description, deposit, facilities, shipping, locationName, lat, long, isFavourite, isAvailable, thumbnail
        case brandID = "brandId"
        case sizeID = "sizeId"
        case categoryID = "categoryId"
        case styleID = "styleId"
        case colorID = "colorId"
        case conditionID = "conditionId"
        case serviceCharge
        case userID = "userId"
        case rating, termAddCondition, createdAt, updatedAt, name
    }
}

// MARK: - ID
struct IDdD: Codable {
    let id, name, createdAt, updatedAt: String?
    let v: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, createdAt, updatedAt
        case v = "__v"
    }
}

// MARK: - Facilities
struct Facilitiess: Codable {
    let deleivery, pickup, drycleaning: Int?
}

// MARK: - Location
struct Location: Codable {
    let type: String?
    let coordinates: [Double]?
    let name: String?
}

// MARK: - ServiceCharge
struct ServiceCharge: Codable {
    let id: String?
    let adminCancelFee: Double?
    let createdAt, updatedAt: String?
    let v: Int?
    let adminCommision: Double?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case adminCommision, adminCancelFee, createdAt, updatedAt
        case v = "__v"
    }
}
