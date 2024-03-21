//
//  ProductDetailModel.swift
//  AirCloset
//
//  Created by cql200 on 19/05/23.
//

import Foundation
import SwiftUI

//
//struct ProductDetailModel: Codable {
//    var success: Bool?
//    var code: Int?
//    var message: String?
//    var body: ProductDetailBody?
//}
//
//// MARK: - Body
//struct ProductDetailBody: Codable {
//    var id: String?
//    var price: Int?
//    var image: [String]?
//    var video, description: String?
//    var deposit: Int?
//    var facilities: Facilities?
//    var shipping: Int?
//    var locationName: String?
//    var lat, long, isFavourite, isAvailable: Int?
//    var brandID, sizeID, categoryID, styleID: ID?
//    var colorID: ID?
//    var conditionID: ID?
//    var userID: UserID?
//    var createdAt, updatedAt: String?
//    var v, rating: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case id = "_id"
//        case price, image, video, description, deposit, facilities, shipping, locationName, lat, long, isFavourite, isAvailable
//        case brandID = "brandId"
//        case sizeID = "sizeId"
//        case categoryID = "categoryId"
//        case styleID = "styleId"
//        case colorID = "colorId"
//        case conditionID = "conditionId"
//        case userID = "userId"
//        case createdAt, updatedAt
//        case v = "__v"
//        case rating
//    }
//}
//
//// MARK: - ID
//struct ID: Codable {
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
//struct Facilities: Codable {
//    var deleivery, pickup, drycleaning: Int?
//}
//
//// MARK: - UserID
//struct UserID: Codable {
//    var id, name, email: String?
//    var phoneNumber: Int?
//    var countryCode, countryCodePhonenumber, password: String?
//    var idVerification, role: Int?
//    var image: String?
//    var isAdmin: Bool?
//    var loginTime: Int?
//    var securityKey: String?
//    var otp, otpVerified: Int?
//    var token: String?
//    var bio, ranToken: String?
//    var isVerified, isNotification: Int?
//    var customerID, createdAt, updatedAt: String?
//    var v: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case id = "_id"
//        case name, email, phoneNumber, countryCode
//        case countryCodePhonenumber = "countryCode_phonenumber"
//        case password, idVerification, role, image, isAdmin
//        case loginTime = "login_time"
//        case securityKey = "security_key"
//        case otp, otpVerified, token, bio, ranToken, isVerified, isNotification
//        case customerID = "customerId"
//        case createdAt, updatedAt
//        case v = "__v"
//    }
//}

/////////////////////////
//struct ProductDetailModel: Codable {
//    var success: Bool?
//    var code: Int?
//    var message: String?
//    var body: ProductDetailBody?
//}
//
//// MARK: - Body
//struct ProductDetailBody: Codable {
//    var id: String?
//    var price: Int?
//    var image: [String]?
//    var video, description: String?
//    var deposit: Int?
//    var facilities: Facilities?
//    var shipping: Int?
//    var locationName: String?
//    var lat, long, isFavourite, isAvailable: Int?
//    var brandID, sizeID, categoryID, styleID: ID?
//    var colorID, conditionID: ID?
//    var userID: UserID?
//    var termAddCondition, createdAt, updatedAt: String?
//    var rating: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case id = "_id"
//        case price, image, video, description, deposit, facilities, shipping, locationName, lat, long, isFavourite, isAvailable
//        case brandID = "brandId"
//        case sizeID = "sizeId"
//        case categoryID = "categoryId"
//        case styleID = "styleId"
//        case colorID = "colorId"
//        case conditionID = "conditionId"
//        case userID = "userId"
//        case termAddCondition, createdAt, updatedAt, rating
//    }
//}
//
//// MARK: - ID
//struct ID: Codable {
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
//struct Facilities: Codable {
//    var deleivery, pickup, drycleaning: Int?
//}
//
//// MARK: - UserID
//struct UserID: Codable {
//   // var location : String
//    var stripeAccountID: String?
//    var wallet: String?
//    var id, name, email: String?
//    var phoneNumber: Int?
//    var countryCode, countryCodePhonenumber, password: String?
//    var idVerification, role: Int?
//    var image: String?
//    var isAdmin: Bool?
//    var loginTime: Int?
//    var securityKey: String?
//    var otp, otpVerified: Int?
//    var token: String?
//    var bio, ranToken: String?
//    var isVerified, isNotification: Int?
//    var customerID, createdAt, updatedAt: String?
//    var v: Int?
//    var deviceToken, termAndCondition: String?
//
//    enum CodingKeys: String, CodingKey {
//        case stripeAccountID = "stripeAccountId"
//        case wallet
//        case id = "_id"
//        case name, email, phoneNumber, countryCode
//        case countryCodePhonenumber = "countryCode_phonenumber"
//        case password, idVerification, role, image, isAdmin
//        case loginTime = "login_time"
//        case securityKey = "security_key"
//        case otp, otpVerified, token, bio, ranToken, isVerified, isNotification
//        case customerID = "customerId"
//        case createdAt, updatedAt
//        case v = "__v"
//        case deviceToken, termAndCondition
//    }
//}
///////////////////





//struct ProductDetailModel: Codable {
//    var success: Bool?
//    var code: Int?
//    var message: String?
//    var body: ProductDetailBody?
//}
//
//// MARK: - Body
//struct ProductDetailBody: Codable {
//    var location: String?
//    var id: String?
//    var price: Int?
//    var image: [String]?
//    var video, description: String?
//    var deposit: Int?
//    var facilities: Facilities?
//    var shipping: Int?
//   // var locationName: String?
//    var lat, long, isFavourite, isAvailable: Int?
//    var brandID, sizeID, categoryID, styleID: ID?
//    var colorID, conditionID: ID?
//    var userID: UserID?
//    var rating: Int?
//    var termAddCondition, createdAt, updatedAt: String?
//
//    enum CodingKeys: String, CodingKey {
//        case location
//        case id = "_id"
//        case price, image, video, description, deposit, facilities, shipping, lat, long, isFavourite, isAvailable
//        case brandID = "brandId"
//        case sizeID = "sizeId"
//        case categoryID = "categoryId"
//        case styleID = "styleId"
//        case colorID = "colorId"
//        case conditionID = "conditionId"
//        case userID = "userId"
//        case rating, termAddCondition, createdAt, updatedAt
//       // case locationName
//    }
//}
//
//// MARK: - ID
//struct ID: Codable {
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
//struct Facilities: Codable {
//    var deleivery, pickup, drycleaning: Int?
//}
//
//// MARK: - Location
////struct Location: Codable {
////    var type: String?
////    var coordinates: [Int]?
////    var name: String?
////}
//
//// MARK: - UserID
//struct UserID: Codable {
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

struct ProductDetailModel: Codable {
    var success: Bool?
    var code: Int?
    var message: String?
    var body: ProductDetailModelBody?
}

// MARK: - Body
struct ProductDetailModelBody: Codable {
    var location,name, id: String?
    var price: Int?
    var image: [String]?
    var video, description: String?
    var deposit: Int?
    var facilities: Facilities?
    var shipping: Int?
    var locationName, lat, long : String?
    var isFavourite, isAvailable: Int?
    var brandID, sizeID, categoryID, styleID: ID?
    var colorID, conditionID: ID?
    var userID: UserID?
    var rating : Double?
    var serviceCharge: Double?
    var termAddCondition, createdAt, updatedAt, thumbnail: String?

    enum CodingKeys: String, CodingKey {
        case location
        case id = "_id"
        case price, image, video, description, deposit, facilities, shipping, locationName, lat, long, isFavourite, isAvailable,thumbnail, name, serviceCharge
        case brandID = "brandId"
        case sizeID = "sizeId"
        case categoryID = "categoryId"
        case styleID = "styleId"
        case colorID = "colorId"
        case conditionID = "conditionId"
        case userID = "userId"
        case rating, termAddCondition, createdAt, updatedAt
    }
}

// MARK: - ID
struct ID: Codable {
    var id, name, createdAt, updatedAt: String?
    var v: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, createdAt, updatedAt
        case v = "__v"
    }
}

// MARK: - Facilities
struct Facilities: Codable {
    var deleivery, pickup, drycleaning: Int?
}

// MARK: - UserID
struct UserID: Codable {
    var id, name, email: String?
    var phoneNumber: Int?
    var countryCode, countryCodePhonenumber, password: String?
    var idVerification, role: Int?
    var latitude, longitude, image: String?
    var isAdmin: Bool?
    var loginTime: Int?
    var securityKey: String?
    var otp, otpVerified: Int?
    var token, bio, ranToken: String?
    var isVerified, isNotification: Int?
    var customerID, termAndCondition, stripeAccountID: String?
    var wallet: Double?
    var createdAt, updatedAt, deviceToken: String?
 
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


extension Double {
    var formattedString: String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 16 // Adjust this based on your needs
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
}


func removeTrailingZeros(from input: String) -> String {
    var components = input.components(separatedBy: ".")
    
    // Check if there is a decimal part and it contains only zeros
    if components.count == 2, let decimalPart = components.last, decimalPart.allSatisfy({ $0 == "0" }) {
        components.removeLast() // Remove the decimal part with only zeros
    }
    
    return components.joined(separator: ".")
}

extension Double {
    var formattedStringWithoutDecimal: String {
        return String(format: "%.0f", self)
    }
}
