//
//  MyClosetModel.swift
//  AirCloset
//
//  Created by cql200 on 03/07/23.
//

import Foundation

//struct MyClosetModel: Codable {
//    var success: Bool?
//    var code: Int?
//    var message: String?
//    var body: [MyClosetModelBody]?
//}
//
//// MARK: - Body
//struct MyClosetModelBody: Codable {
//    var id, startDate, endDate: String?
//    var totalDays, productPrice, totalPrice, status: Int?
//    var serviceCharge: String?
//    var phoneNumber: Int?
//    var countryCode, address: String?
//    var isReserved, cancelStatus, orderStatus, deleiveryStatus: Int?
//    var returnClothStatus: Bool?
//    var buyerID: String?
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
//// MARK: - ProductID
//struct ProductIIDD: Codable {
//    var id: String?
//    var price: Int?
//    var image: [String]?
//    var description, brandID: String?
//    var sizeID, categoryID: IIDD?
//
//    enum CodingKeys: String, CodingKey {
//        case id = "_id"
//        case price, image, description
//        case brandID = "brandId"
//        case sizeID = "sizeId"
//        case categoryID = "categoryId"
//    }
//}
//
//// MARK: - ID
//struct IIDD: Codable {
//    var id, name, createdAt, updatedAt: String?
//    var v: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case id = "_id"
//        case name, createdAt, updatedAt
//        case v = "__v"
//    }
//}

struct MyClosetModel: Codable {
    var success: Bool?
    var code: Int?
    var message: String?
    var body: MyClosetModelBody?
}

// MARK: - Body
struct MyClosetModelBody: Codable {
    var userData: UserData?
    var myClosets: [MyCloset]?
}

// MARK: - MyCloset
struct MyCloset: Codable {
    var id: String?
    var image: [String]?
    var video: String?
    var status : Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case image, video
        case status
    }
}

// MARK: - UserData
struct UserData: Codable {
    var id, name: String?
    var idVerification: Int?
    var image, bio: String?
    var isVerified, subscriberCount: Int?
    var rating: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, idVerification, image, bio, isVerified, subscriberCount, rating
    }
}
