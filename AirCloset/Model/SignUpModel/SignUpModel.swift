//
//  SignUpModel.swift
//  AirCloset
//
//  Created by cql200 on 05/05/23.
//

import Foundation

//struct SignUpModel : Codable {
//    var success : Bool?
//    var code : Int?
//    var message : String?
//    var body : SignUpBody?
//}
//
//struct SignUpBody : Codable {
//    var id : String?
//    var name : String?
//    var email : String?
//    var phoneNumber : Int?
//    var countryCode : String?
//    var phoneNoWithCntryCd : String?
//    var password : String?
//    var idVerification : Int?
//    var role : Int?
//    var image : String?
//    var isAdmin : Bool?
//    var loginTime : Int?
//    var securityKey : String?
//    var token : String?
//    var bio : String?
//    var isNotification : Int?
//    var createdAt : String?
//    var updatedAt : String?
//    var v : Int?
//    var otp : Int?
//    var otpVerified : Int?
//
//    enum CodingKeys : String,CodingKey{
//        case id = "_id"
//        case name
//        case email
//        case phoneNumber
//        case countryCode
//        case phoneNoWithCntryCd = "countryCode_phonenumber"
//        case password
//        case idVerification
//        case role
//        case image
//        case isAdmin
//        case loginTime = "login_time"
//        case securityKey = "security_key"
//        case token
//        case bio
//        case isNotification
//        case createdAt
//        case updatedAt
//        case v = "__v"
//        case otp
//        case otpVerified
//}

//    init(from decoder: Decoder) throws {
//                  do {
//                      let values = try decoder.container(keyedBy: CodingKeys.self)
//                      self.id = try values.decodeIfPresent(String.self, forKey: .id)
//                      self.name = try values.decodeIfPresent(String.self, forKey: .name)
//                      self.email = try values.decodeIfPresent(String.self, forKey: .email)
//                      self.phoneNumber = try values.decodeIfPresent(Int.self, forKey: .phoneNumber)
//                      self.countryCode = try values.decodeIfPresent(String.self, forKey: .countryCode)
//                      self.phoneNoWithCntryCd = try values.decodeIfPresent(String.self, forKey: .phoneNoWithCntryCd)
//                      self.password = try values.decodeIfPresent(String.self, forKey: .password)
//                      self.idVerification = try values.decodeIfPresent(Int.self, forKey: .idVerification)
//                      self.role = try values.decodeIfPresent(Int.self, forKey: .role)
//                      self.image = try values.decodeIfPresent(String.self, forKey: .image)
//                      self.isAdmin = try values.decodeIfPresent(Bool.self, forKey: .isAdmin)
//                      self.loginTime = try values.decodeIfPresent(Int.self, forKey: .loginTime)
//                      self.securityKey = try values.decodeIfPresent(String.self, forKey: .securityKey)
//                      self.token = try values.decodeIfPresent(String.self, forKey: .token)
//                      self.bio = try values.decodeIfPresent(String.self, forKey: .bio)
//                      self.isNotification = try values.decodeIfPresent(Int.self, forKey: .isNotification)
//                      self.createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
//                      self.updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
//                      self.v = try values.decodeIfPresent(Int.self, forKey: .v)
//                      self.otp = try values.decodeIfPresent(Int.self, forKey: .otp)
//                      self.otpVerified = try values.decodeIfPresent(Int.self, forKey: .otpVerified)
//
//              }
//        catch {
//                  debugPrint(error.localizedDescription)
//              }
//
//      }
//}

///MARK: _ Model 2

//struct SignUpModel: Codable {
//    var success: Bool?
//    var code: Int?
//    var message: String?
//    var body: SignUpBody?
//}
//
//// MARK: - Body
//struct SignUpBody: Codable {
//    var id, name, email: String?
//    var phoneNumber: Int?
//    var countryCode, countryCodePhonenumber, password: String?
//    var idVerification, role: Int?
//    var image: String?
//    var isAdmin: Bool?
//    var loginTime: Int?
//    var securityKey: String?
//    var otp, otpVerified: Int?
//    var token, bio, ranToken: String?
//    var isVerified, isNotification: Int?
//    var customerID, termAndCondition, stripeAccountID: String?
//    var wallet: String?
//    var createdAt, updatedAt: String?
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
//        case termAndCondition
//        case stripeAccountID = "stripeAccountId"
//        case wallet, createdAt, updatedAt
//    }
//}

//struct SignUpModel: Codable {
//    var success: Bool?
//    var code: Int?
//    var message: String?
//    var body: SignUpBody?
//}
//
//// MARK: - Body
//struct SignUpBody: Codable {
//    var id, name, email: String?
//    var phoneNumber: Int?
//    var countryCode, countryCodePhonenumber, password: String?
//    var idVerification, role: Int?
//    var image: String?
//    var isAdmin: Bool?
//    var loginTime: Int?
//    var securityKey: String?
//    var otp, otpVerified: Int?
//    var token, bio, ranToken: String?
//    var isVerified, isNotification: Int?
//    var customerID, termAndCondition, stripeAccountID: String?
//    var wallet: String?
//    var createdAt, updatedAt: String?
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
//        case termAndCondition
//        case stripeAccountID = "stripeAccountId"
//        case wallet, createdAt, updatedAt
//    }
//}

struct SignUpModel: Codable {
    var success: Bool?
    var code: Int?
    var message: String?
    var body: SignUpBody?
}

// MARK: - Body
struct SignUpBody: Codable {
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
    var createdAt, updatedAt, referal_code: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, email, phoneNumber, countryCode, referal_code
        case countryCodePhonenumber = "countryCode_phonenumber"
        case password, idVerification, role, latitude, longitude, image, isAdmin
        case loginTime = "login_time"
        case securityKey = "security_key"
        case otp, otpVerified, token, bio, ranToken, isVerified, isNotification
        case customerID = "customerId"
        case termAndCondition
        case stripeAccountID = "stripeAccountId"
        case wallet, createdAt, updatedAt
    }
}
