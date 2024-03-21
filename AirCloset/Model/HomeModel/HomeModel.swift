//
//  HomeModel.swift
//  AirCloset
//
//  Created by cql200 on 18/05/23.
//

import Foundation

// MARK: - HomeModel
struct HomeModel: Codable {
    var success: Bool?
    var code: Int?
    var message: String?
    var body: HomeBody?
}

// MARK: - Body
struct HomeBody: Codable {
    var basedOnLikes: [BasedOnLike]?
    var suggestion: [Suggestion]?
    var subscribedUsers: [SubscribedUser]?

    enum CodingKeys: String, CodingKey {
        case basedOnLikes = "BasedOnLikes"
        case suggestion, subscribedUsers
    }
}

// MARK: - BasedOnLike
struct BasedOnLike: Codable {
    var id: String?
    var type: Int?
    var productID: ProductID?
    var userID: UserIDD?
    var createdAt, updatedAt: String?
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
struct ProductID: Codable {
    var id: String?
    var price: Int?
    var image: [String]?
    var isFavourite: Int?
    var sizeID: SizeID?
    var userID: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case price, image, isFavourite
        case sizeID = "sizeId"
        case userID = "userId"
    }
}

// MARK: - UserID
struct UserIDD: Codable {
    let id, name, email: String?
    let phoneNumber: Int?
    let countryCode, countryCodePhonenumber, password: String?
    let idVerification, role: Int?
    let latitude, longitude, image: String?
    let isAdmin: Bool?
    let loginTime: Int?
    let securityKey: String?
    let otp, otpVerified: Int?
    let token: String?
    let bio: String?
    let ranToken: String?
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

// MARK: - Suggestion
struct Suggestion: Codable {
    var id: String?
    var price: Int?
    var image: [String]?
    var isFavourite: Int?
    var name: String?
    var sizeID: SizeID?
    var userID: UserID?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case price, image, isFavourite, name
        case sizeID = "sizeId"
        case userID = "userId"
    }
}

// MARK: - SizeID
struct SizeID: Codable {
    var id, name, createdAt, updatedAt: String?
    var v: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, createdAt, updatedAt
        case v = "__v"
    }
}
// MARK: - SubscribedUser
//struct SubscribedUser: Codable {
//    var id: String?
//    var subscribeBy: UserID?
//    var subscribeTo: String?
//    var isSubscribe: Bool?
//    var createdAt, updatedAt: String?
//    var v: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case id = "_id"
//        case subscribeBy, subscribeTo, isSubscribe, createdAt, updatedAt
//        case v = "__v"
//    }
//}

struct SubscribedUser: Codable {
    var id, subscribeBy: String?
    var subscribeTo: SubscribeTo?
    var isSubscribe: Bool?
    var createdAt, updatedAt: String?
    var v: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case subscribeBy, subscribeTo, isSubscribe, createdAt, updatedAt
        case v = "__v"
    }
}
// MARK: - SubscribeTo
struct SubscribeTo: Codable {
    var id, name, image: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, image
    }
}

//
//import Foundation
//
//// MARK: - GetRatingForSalon
//struct GetRatingForSalon: Codable {
//    var success: Bool?
//    var code: Int?
//    var message: String?
//    var body: Body?
//}
//
//// MARK: - Body
//struct Body: Codable {
//    var basedOnLikes: [BasedOnLike]?
//    var suggestion: [Suggestion]?
//    var subscribedUsers: [SubscribedUser]?
//
//    enum CodingKeys: String, CodingKey {
//        case basedOnLikes = "BasedOnLikes"
//        case suggestion, subscribedUsers
//    }
//}
//
//// MARK: - BasedOnLike
//struct BasedOnLike: Codable {
//    var id: String?
//    var type: Int?
//    var productID: ProductID?
//    var userID: UserID?
//    var createdAt, updatedAt: String?
//    var v: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case id = "_id"
//        case type
//        case productID = "productId"
//        case userID = "userId"
//        case createdAt, updatedAt
//        case v = "__v"
//    }
//}
//
//// MARK: - ProductID
//struct ProductID: Codable {
//    var id, name: String?
//    var price: Int?
//    var image: [String]?
//    var isFavourite: Int?
//    var sizeID: SizeID?
//    var userID: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id = "_id"
//        case name, price, image, isFavourite
//        case sizeID = "sizeId"
//        case userID = "userId"
//    }
//}
//
//// MARK: - SizeID
//struct SizeID: Codable {
//    var id: ID?
//    var name: Name?
//    var createdAt: CreatedAt?
//    var updatedAt: UpdatedAt?
//    var v: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case id = "_id"
//        case name, createdAt, updatedAt
//        case v = "__v"
//    }
//}
//
//enum CreatedAt: String, Codable {
//    case the20230616T052835430Z = "2023-06-16T05:28:35.430Z"
//    case the20230616T052843456Z = "2023-06-16T05:28:43.456Z"
//    case the20230616T052848365Z = "2023-06-16T05:28:48.365Z"
//    case the20230804T091301109Z = "2023-08-04T09:13:01.109Z"
//    case the20230912T180901859Z = "2023-09-12T18:09:01.859Z"
//}
//
//enum ID: String, Codable {
//    case the648Bf3037277B330F73C5Abc = "648bf3037277b330f73c5abc"
//    case the648Bf30B7277B330F73C5Abf = "648bf30b7277b330f73c5abf"
//    case the648Bf3107277B330F73C5Ac2 = "648bf3107277b330f73c5ac2"
//    case the64Ccc11Db72Dc99992Eb00C5 = "64ccc11db72dc99992eb00c5"
//    case the6500A93De47C075Ac61Ca418 = "6500a93de47c075ac61ca418"
//}
//
//enum Name: String, Codable {
//    case l = "L"
//    case m = "M"
//    case s = "S"
//    case xs = "XS"
//    case xxs = "XXS"
//}
//
//enum UpdatedAt: String, Codable {
//    case the20230616T052848365Z = "2023-06-16T05:28:48.365Z"
//    case the20230912T180839039Z = "2023-09-12T18:08:39.039Z"
//    case the20230912T180846842Z = "2023-09-12T18:08:46.842Z"
//    case the20230912T180851235Z = "2023-09-12T18:08:51.235Z"
//    case the20230912T180909508Z = "2023-09-12T18:09:09.508Z"
//}
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
//    var securityKey: JSONNull?
//    var deviceType, otp, otpVerified: Int?
//    var deviceToken: String?
//    var token: String?
//    var bio, ranToken: String?
//    var isVerified, isNotification: Int?
//    var customerID: String?
//    var termAndCondition: TermAndCondition?
//    var stripeAccountID: String?
//    var wallet: Int?
//    var referalCode: ReferalCode?
//    var referalPoint: Int?
//    var createdAt, updatedAt: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id = "_id"
//        case name, email, phoneNumber, countryCode
//        case countryCodePhonenumber = "countryCode_phonenumber"
//        case password, idVerification, role, latitude, longitude, image, isAdmin
//        case loginTime = "login_time"
//        case securityKey = "security_key"
//        case deviceType, otp, otpVerified, deviceToken, token, bio, ranToken, isVerified, isNotification
//        case customerID = "customerId"
//        case termAndCondition
//        case stripeAccountID = "stripeAccountId"
//        case wallet
//        case referalCode = "referal_code"
//        case referalPoint = "referal_point"
//        case createdAt, updatedAt
//    }
//}
//
//enum ReferalCode: String, Codable {
//    case empty = ""
//    case mycloset90055586 = "MYCLOSET90055586"
//}
//
//enum TermAndCondition: String, Codable {
//    case empty = ""
//    case hiiNdjdDjdjdDjdD = "Hii ndjd djdjd djd d"
//    case onlyFor3Days = "Only for 3 days "
//    case sdfsdfsdf = "Sdfsdfsdf"
//    case test = "Test"
//}
//
//// MARK: - SubscribedUser
//struct SubscribedUser: Codable {
//    var id: String?
//    var subscribeBy: UserID?
//    var subscribeTo: String?
//    var isSubscribe: Bool?
//    var createdAt, updatedAt: String?
//    var v: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case id = "_id"
//        case subscribeBy, subscribeTo, isSubscribe, createdAt, updatedAt
//        case v = "__v"
//    }
//}
//
//// MARK: - Suggestion
//struct Suggestion: Codable {
//    var id, name: String?
//    var price: Int?
//    var image: [String]?
//    var isFavourite: Int?
//    var sizeID: SizeID?
//    var userID: UserID?
//
//    enum CodingKeys: String, CodingKey {
//        case id = "_id"
//        case name, price, image, isFavourite
//        case sizeID = "sizeId"
//        case userID = "userId"
//    }
//}
//
//// MARK: - Encode/decode helpers
//
//class JSONNull: Codable, Hashable {
//
//    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
//        return true
//    }
//
//    public var hashValue: Int {
//        return 0
//    }
//
//    public init() {}
//
//    public required init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if !container.decodeNil() {
//            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
//        }
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        try container.encodeNil()
//    }
//}
//\
