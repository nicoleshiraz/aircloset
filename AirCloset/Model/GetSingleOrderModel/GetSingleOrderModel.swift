//
//  GetSingleOrderModel.swift
//  AirCloset
//
//  Created by cql200 on 03/07/23.
//

import Foundation

//struct GetSingleOrderModel: Codable {
//    var success: Bool?
//    var code: Int?
//    var message: String?
//    var body: GetSingleOrderModelBody?
//}
//
//// MARK: - Body
//struct GetSingleOrderModelBody: Codable {
//    var id, startDate, endDate: String?
//    var totalDays, productPrice, totalPrice, status: Int?
//    var serviceCharge: String?
//    var phoneNumber: Int?
//    var countryCode, address: String?
//    var isReserved, cancelStatus, orderStatus, deleiveryStatus: Int?
//    var returnClothStatus: Bool?
//    var buyerID: ErID?
//    var productID: ProductIIDD?
//    var createdAt, updatedAt: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id = "_id"
//        case startDate, endDate, totalDays, productPrice, totalPrice, status, serviceCharge, phoneNumber, countryCode, address, isReserved, cancelStatus, orderStatus, deleiveryStatus, returnClothStatus
//        case buyerID = "buyerId"
//        case productID = "productId"
//        case createdAt, updatedAt
//    }
//}
//
//// MARK: - ErID
//struct ErID: Codable {
//    var id, name, email: String?
//    var phoneNumber: Int?
//    var countryCode, countryCodePhonenumber, password: String?
//    var idVerification, role: Int?
//    var latitude, longitude, image: String?
//    var isAdmin: Bool?
//    var loginTime: Int?
//    var securityKey: String?
//    var otp, otpVerified: Int?
//    var token, bio, ranToken: String?
//    var isVerified, isNotification: Int?
//    var customerID, termAndCondition, stripeAccountID: String?
//    var wallet: String?
//    var createdAt, updatedAt, deviceToken: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id = "_id"
//        case name, email, phoneNumber, countryCode
//        case countryCodePhonenumber = "countryCode_phonenumber"
//        case password, idVerification, role, latitude, longitude, image, isAdmin
//        case loginTime = "login_time"
//        case securityKey = "security_key"
//        case otp, otpVerified, token, bio, ranToken, isVerified, isNotification
//        case customerID = "customerId"
//        case termAndCondition
//        case stripeAccountID = "stripeAccountId"
//        case wallet, createdAt, updatedAt, deviceToken
//    }
//}
//
//// MARK: - ProductID
//struct ProductIIDD: Codable {
//    var location: Location?
//    var id: String?
//    var price: Int?
//    var image: [String]?
//    var video, description: String?
//    var deposit: Int?
//    var facilities: Facilitiess?
//    var shipping: Int?
//    var locationName: String?
//    var lat, long, isFavourite, isAvailable: Int?
//    var brandID, sizeID, categoryID, styleID: IDDd?
//    var colorID, conditionID: IDDd?
//    var userID: ErID?
//    var rating: Int?
//    var termAddCondition, createdAt, updatedAt: String?
//
//    enum CodingKeys: String, CodingKey {
//        case location
//        case id = "_id"
//        case price, image, video, description, deposit, facilities, shipping, locationName, lat, long, isFavourite, isAvailable
//        case brandID = "brandId"
//        case sizeID = "sizeId"
//        case categoryID = "categoryId"
//        case styleID = "styleId"
//        case colorID = "colorId"
//        case conditionID = "conditionId"
//        case userID = "userId"
//        case rating, termAddCondition, createdAt, updatedAt
//    }
//}
//
//// MARK: - ID
//struct IDDd: Codable {
//    var id, name, createdAt, updatedAt: String?
//    var v: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case id = "_id"
//        case name, createdAt, updatedAt
//        case v = "__v"
//    }
//}
//
//// MARK: - Facilities
//struct Facilitiess: Codable {
//    var deleivery, pickup, drycleaning: Int?
//}
//
//// MARK: - Location
//struct Location: Codable {
//    var type: String?
//    var coordinates: [Int]?
//    var name: String?
//}



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
    let phoneNumber, orderType: Int?
    let countryCode, address, serviceCharge: String?
    let isReserved, orderStatus, deleiveryStatus, feedBackStatus: Int?
    let returnClothStatus: Bool?
    let buyerID: ErID?
    let productID: ProductIIDD?
    let createdAt, updatedAt, image: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case startDate, endDate, totalDays, productPrice, totalPrice, status, serviceCharge, phoneNumber, countryCode, address, isReserved, orderStatus, deleiveryStatus, returnClothStatus, feedBackStatus, orderType,name, image
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
    let wallet: Int?
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
    let adminCommision, adminCancelFee: Int?
    let createdAt, updatedAt: String?
    let v: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case adminCommision, adminCancelFee, createdAt, updatedAt
        case v = "__v"
    }
}
