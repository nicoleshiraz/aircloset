//
//  SellerModel.swift
//  AirCloset
//
//  Created by cqlios3 on 24/07/23.
//

import Foundation

struct SellerProfileModel: Codable {
    let success: Bool?
    let code: Int?
    let message: String?
    let body: SellerProfileModelBody?
}

// MARK: - Body
struct SellerProfileModelBody: Codable {
    let userData: SellerProfileModelUserData?
    let myClosets: [SellerProfileModelMyCloset]?
}

// MARK: - MyCloset
struct SellerProfileModelMyCloset: Codable {
    let id: String?
    let image: [String]?
    let video: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case image, video
    }
}

// MARK: - UserData
struct SellerProfileModelUserData: Codable {
    let id, name: String?
    let idVerification: Int?
    let image, bio, termAndCondition: String?
    let isVerified, subscriberCount: Int?
    let rating: String?
    let subscribeStatus: Bool?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, idVerification, image, bio, isVerified, subscriberCount, subscribeStatus, rating, termAndCondition
    }
}


// MARK: - Subscribe
struct Subscribe: Codable {
    let success: Bool?
    let code: Int?
    let message: String?
    let body: SubscribeBody?
}

// MARK: - Body
struct SubscribeBody: Codable {
    let id, subscribeBy, subscribeTo: String?
    let isSubscribe: Bool?
    let createdAt, updatedAt: String?
    let v: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case subscribeBy, subscribeTo, isSubscribe, createdAt, updatedAt
        case v = "__v"
    }
}
