//
//  AddPostModel.swift
//  AirCloset
//
//  Created by cql200 on 02/06/23.
//

import Foundation

//struct AddPostModel: Codable {
//    var success: Bool?
//    var code: Int?
//    var message: String?
//    var body: AddPostModelBody?
//}
//
//// MARK: - Body
//struct AddPostModelBody: Codable {
//    var id: String?
//    var price: Int?
//    var image: [String]?
//    var video, productProfileImage: String?
//    var description: String?
//    var deposit: Int?
//    var facilities: AllFacilities?
//    var shipping: Int?
//    var locationName: String?
//    var lat, long, isFavourite, isAvailable: Int?
//    var brandID, sizeID, categoryID, styleID: String?
//    var colorID, conditionID, userID, createdAt: String?
//    var updatedAt: String?
//    var v: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case id = "_id"
//        case price, image, video, productProfileImage, description, deposit, facilities, shipping, locationName, lat, long, isFavourite, isAvailable
//        case brandID = "brandId"
//        case sizeID = "sizeId"
//        case categoryID = "categoryId"
//        case styleID = "styleId"
//        case colorID = "colorId"
//        case conditionID = "conditionId"
//        case userID = "userId"
//        case createdAt, updatedAt
//        case v = "__v"
//    }
//}
//
//// MARK: - Facilities
//struct AllFacilities: Codable {
//    var pickup, drycleaning, deleivery: Int?
//}

struct AddPostModel: Codable {
    var success: Bool?
    var code: Int?
    var message: String?
    var body: AddPostModelBody?
}

// MARK: - Body
struct AddPostModelBody: Codable {
    var location : String?
    var id: String?
    var price: Int?
    var image: [String]?
    var video: String?
    var description: String?
    var deposit: Int?
    var facilities: AllFacilities?
    var shipping: Int?
   // var locationName: String?
    var lat, long : String?
    var isFavourite, isAvailable: Int?
    var brandID, sizeID, categoryID, styleID: String?
    var colorID, conditionID, userID, termAddCondition: String?
    var createdAt, updatedAt: String?
    var rating: Int?
    enum CodingKeys: String, CodingKey {
        case location
      //  case locationName
        case id = "_id"
        case price, image, video, description, deposit, facilities, shipping, lat, long, isFavourite, isAvailable
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

// MARK: - Facilities
struct AllFacilities: Codable {
    var pickup, drycleaning, deleivery: Int?
}
