//
//  CommonModelAddPost.swift
//  AirCloset
//
//  Created by cql200 on 24/05/23.
//

import Foundation



// MARK: - AddFavori
struct CatagoryModel: Codable {
    var success: Bool?
    var code: Int?
    var message: String?
    var body: [CatagoryBody]?
}

// MARK: - Body
struct CatagoryBody: Codable {
    var id, name, createdAt, updatedAt: String?
    var v: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, createdAt, updatedAt
        case v = "__v"
    }
}



//MARK: - CONDITION Model
struct ClothConditionModel: Codable {
    var success: Bool?
    var code: Int?
    var message: String?
    var body: [ClothConditionModelBody]?
}


struct ClothConditionModelBody: Codable {
    var id, name, createdAt, updatedAt: String?
    var v: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, createdAt, updatedAt
        case v = "__v"
    }
}

//MARK: - ColorModel

struct ColorModel: Codable {
    var success: Bool?
    var code: Int?
    var message: String?
    var body: [ColorModelBody]?
}

// MARK: - Body
struct ColorModelBody: Codable {
    var id, name, createdAt, updatedAt: String?
    var v: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, createdAt, updatedAt
        case v = "__v"
    }
}

//MARK: - StyleModel
struct StyleModel: Codable {
    var success: Bool?
    var code: Int?
    var message: String?
    var body: [StyleModelBody]?
}


struct StyleModelBody: Codable {
    var id, name, createdAt, updatedAt: String?
    var v: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, createdAt, updatedAt
        case v = "__v"
    }
}

//MARK: - BrandModel
struct BrandModel: Codable {
    var success: Bool?
    var code: Int?
    var message: String?
    var body: [BrandModelBody]?
}

// MARK: - Body
struct BrandModelBody: Codable {
    var id, name, createdAt, updatedAt: String?
    var v: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, createdAt, updatedAt
        case v = "__v"
    }
}

//MARK: - SizeModel
struct SizeModel: Codable {
    var success: Bool?
    var code: Int?
    var message: String?
    var body: [SizeModelBody]?
}

// MARK: - Body
struct SizeModelBody: Codable {
    var id, name, createdAt, updatedAt: String?
    var v: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, createdAt, updatedAt
        case v = "__v"
    }
}
