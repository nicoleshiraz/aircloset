//
//  ReviewModel.swift
//  AirCloset
//
//  Created by cqlios3 on 02/08/23.
//

import Foundation

// MARK: - ReviewModel
struct ReviewModel: Codable {
    var success: Bool?
    var code: Int?
    var message: String?
    var body: [ReviewModelBody]?
}

// MARK: - Body
struct ReviewModelBody: Codable {
    var id: String?
    var rating: Int?
    var review, message: String?
    var productID: ReviewModelProductID?
    var userID: ReviewModelUserID?
    var createdAt, updatedAt: String?
    var v: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case rating, review, message
        case productID = "productId"
        case userID = "userId"
        case createdAt, updatedAt
        case v = "__v"
    }
}

// MARK: - ProductID
struct ReviewModelProductID: Codable {
    var location: ReviewModelLocation?
    var id: String?
    var price: Int?
    var image: [String]?
    var video, description: String?
    var deposit: Int?
    var facilities: String?
    var shipping: Int?
    var locationName: String?
    var lat, long: Double?
    var isFavourite, isAvailable: Int?
    var brandID, sizeID: String?
    var categoryID: ReviewModelCategoryID?
    var conditionID, serviceCharge, userID: String?
    var rating: Int?
    var termAddCondition, createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case location
        case id = "_id"
        case price, image, video, description, deposit, facilities, shipping, locationName, lat, long, isFavourite, isAvailable
        case brandID = "brandId"
        case sizeID = "sizeId"
        case categoryID = "categoryId"
        case conditionID = "conditionId"
        case serviceCharge
        case userID = "userId"
        case rating, termAddCondition, createdAt, updatedAt
    }
}

// MARK: - CategoryID
struct ReviewModelCategoryID: Codable {
    var id, name, createdAt, updatedAt: String?
    var v: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, createdAt, updatedAt
        case v = "__v"
    }
}

// MARK: - Location
struct ReviewModelLocation: Codable {
    var type: String?
    var coordinates: [Double]?
    var name: String?
}

// MARK: - UserID
struct ReviewModelUserID: Codable {
    var id, name, email: String?
    var phoneNumber: Int?
    var countryCode, countryCodePhonenumber, password: String?
    var idVerification, role: Int?
    var latitude, longitude, image: String?
    var isAdmin: Bool?
    var loginTime: Int?
    var securityKey: Int?
    var deviceType, otp, otpVerified: Int?
    var deviceToken, token, bio, ranToken: String?
    var isVerified, isNotification: Int?
    var customerID, termAndCondition, stripeAccountID: String?
    var wallet: Int?
    var createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, email, phoneNumber, countryCode
        case countryCodePhonenumber = "countryCode_phonenumber"
        case password, idVerification, role, latitude, longitude, image, isAdmin
        case loginTime = "login_time"
        case securityKey = "security_key"
        case deviceType, otp, otpVerified, deviceToken, token, bio, ranToken, isVerified, isNotification
        case customerID = "customerId"
        case termAndCondition
        case stripeAccountID = "stripeAccountId"
        case wallet, createdAt, updatedAt
    }
}



// MARK: - ReviewModel
struct ReviewModelSingleProduct: Codable {
    var success: Bool?
    var code: Int?
    var message: String?
    var body: [ReviewModelSingleProductBody]?
}

// MARK: - Body
struct ReviewModelSingleProductBody: Codable {
    var id: String?
    var rating: Int?
    var review, message: String?
    var productID: ReviewModelSingleProductProductID?
    var userID: ReviewModelSingleProductUserID?
    var createdAt, updatedAt: String?
    var v: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case rating, review, message
        case productID = "productId"
        case userID = "userId"
        case createdAt, updatedAt
        case v = "__v"
    }
}

// MARK: - ProductID
struct ReviewModelSingleProductProductID: Codable {
    var location: ReviewModelSingleProductLocation?
    var id: String?
    var price: Int?
    var image: [String]?
    var video, description: String?
    var deposit: Int?
    var facilities: String?
    var shipping: Int?
    var locationName: String?
    var lat, long: Double?
    var isFavourite, isAvailable: Int?
    var brandID, sizeID, categoryID, conditionID: String?
    var serviceCharge, userID: String?
    var rating: Int?
    var termAddCondition, createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case location
        case id = "_id"
        case price, image, video, description, deposit, facilities, shipping, locationName, lat, long, isFavourite, isAvailable
        case brandID = "brandId"
        case sizeID = "sizeId"
        case categoryID = "categoryId"
        case conditionID = "conditionId"
        case serviceCharge
        case userID = "userId"
        case rating, termAddCondition, createdAt, updatedAt
    }
}

// MARK: - Location
struct ReviewModelSingleProductLocation: Codable {
    var type: String?
    var coordinates: [Double]?
    var name: String?
}

// MARK: - UserID
struct ReviewModelSingleProductUserID: Codable {
    var id, name, email: String?
    var phoneNumber: Int?
    var countryCode, countryCodePhonenumber, password: String?
    var idVerification, role: Int?
    var latitude, longitude, image: String?
    var isAdmin: Bool?
    var loginTime: Int?
    var securityKey: Int?
    var deviceType, otp, otpVerified: Int?
    var deviceToken, token, bio, ranToken: String?
    var isVerified, isNotification: Int?
    var customerID, termAndCondition, stripeAccountID: String?
    var wallet: Int?
    var createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, email, phoneNumber, countryCode
        case countryCodePhonenumber = "countryCode_phonenumber"
        case password, idVerification, role, latitude, longitude, image, isAdmin
        case loginTime = "login_time"
        case securityKey = "security_key"
        case deviceType, otp, otpVerified, deviceToken, token, bio, ranToken, isVerified, isNotification
        case customerID = "customerId"
        case termAndCondition
        case stripeAccountID = "stripeAccountId"
        case wallet, createdAt, updatedAt
    }
}
