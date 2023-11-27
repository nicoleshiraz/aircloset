//
//  ClosetListingModel.swift
//  AirCloset
//
//  Created by cql131 on 20/06/23.
//

import Foundation

//MARK: - Model for Fav
struct ClosetListingFavModel: Codable {
    var success: Bool?
    var code: Int?
    var message: String?
    var body: [ClosetListingFavModelBody]?
}

// MARK: - Body
struct ClosetListingFavModelBody: Codable {
    var id: String?
    var type: Int?
    var productID: FavProductID?
    var userID, createdAt, updatedAt: String?
    var v: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case type
        case productID = "productId"
        case userID = "userId"
        case createdAt, updatedAt
        case v = "__v"
    }
}

// MARK: - ProductID
struct FavProductID: Codable {
    var id: String?
    var price: Int?
    var image: [String]?
    var description, brandID: String?
    var sizeID: FavSizeID?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case price, image, description
        case brandID = "brandId"
        case sizeID = "sizeId"
    }
}

// MARK: - SizeID
struct FavSizeID: Codable {
    var id, name, createdAt, updatedAt: String?
    var v: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, createdAt, updatedAt
        case v = "__v"
    }
}

//MARK: - OdredByMe
struct ClosetListingOrderByMeModel: Codable {
    var success: Bool?
    var code: Int?
    var message: String?
    var body: [ClosetListingOrderByMeModelBody]?
}

// MARK: - Body
struct ClosetListingOrderByMeModelBody: Codable {
    var id, startDate, endDate: String?
    var totalDays, productPrice, totalPrice, status: Int?
    var serviceCharge: String?
    var phoneNumber, deleiveryStatus: Int?
    var countryCode, address: String?
    var isReserved, cancelStatus, orderStatus, feedBackStatus,orderType : Int?
    var returnClothStatus: Bool?
    var buyerID: String?
    var productID: ProductIID?
    var createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case startDate, endDate, totalDays, productPrice, totalPrice, status, serviceCharge, phoneNumber, countryCode, address, isReserved, cancelStatus, orderStatus, deleiveryStatus, returnClothStatus, feedBackStatus,orderType
        case buyerID = "buyerId"
        case productID = "productId"
        case createdAt, updatedAt
    }
}

// MARK: - ProductID
struct ProductIID: Codable {
    var id: String?
    var price, deposit: Int?
    var image: [String]?
    var description, name: String?
    var brandID, sizeID, categoryID: IDStruct?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case price, image, description, deposit, name
        case brandID = "brandId"
        case sizeID = "sizeId"
        case categoryID = "categoryId"
    }
}

// MARK: - ID
struct IDStruct: Codable {
    var id, name, createdAt, updatedAt: String?
    var v: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, createdAt, updatedAt
        case v = "__v"
    }
}

//MARK: -
struct ClosetListingOderedByOtherModel: Codable {
    var success: Bool?
    var code: Int?
    var message: String?
    var body: [ClosetListingOderedByOtherModelBody]?
}

// MARK: - Body
struct ClosetListingOderedByOtherModelBody: Codable {
    var id, startDate, endDate: String?
    var totalDays, productPrice, totalPrice, status: Int?
    var serviceCharge: String?
    var phoneNumber: Int?
    var countryCode, address: String?
    var isReserved, cancelStatus, orderStatus, deleiveryStatus, orderType: Int?
    var returnClothStatus: Bool?
    var buyerID: String?
    var productID: ProductIDD?
    var createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case startDate, endDate, totalDays, productPrice, totalPrice, status, serviceCharge, phoneNumber, countryCode, address, isReserved, cancelStatus, orderStatus, deleiveryStatus, returnClothStatus, orderType
        case buyerID = "buyerId"
        case productID = "productId"
        case createdAt, updatedAt
    }
}

// MARK: - ProductID
struct ProductIDD: Codable {
    var id: String?
    var price: Int?
    var image: [String]?
    var description, brandID, name: String?
    var sizeID, categoryID: IDD?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case price, image, description, name
        case brandID = "brandId"
        case sizeID = "sizeId"
        case categoryID = "categoryId"
    }
}

// MARK: - ID
struct IDD: Codable {
    var id, name, createdAt, updatedAt: String?
    var v: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, createdAt, updatedAt
        case v = "__v"
    }
}
