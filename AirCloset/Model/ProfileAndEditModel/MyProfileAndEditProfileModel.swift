//
//  MyProfileModel.swift
//  AirCloset
//
//  Created by cql200 on 09/05/23.
//

import Foundation

struct MyProfileAndEditProfileModel : Codable {
    var success : Bool?
    var code : Int?
    var message : String?
    var body : MyProfileInfo?
}

struct MyProfileInfo : Codable{
    var id : String?
    var name : String?
    var email : String?
    var phoneNumber : Int?
    var countryCode : String?
    var countryCodeAndPhoneNumber : String?
    var password : String?
    var idVerification : Int?
    var role : Int?
    var image : String?
    var isAdmin : Bool?
    var loginTime : Int?
    var securityKey : String?
    var token : String?
    var bio : String?
    var isNotification : Int?
    var createdAt : String?
    var updatedAt : String?
    var v : Int?
    var otp : Int?
    var forgotPasswordToken : String?
    var otpVerified : Int?
    var ranToken : String?
    var deviceToken : String?
    var termAndCondition: String?
    var referal_code: String?
    enum CodingKeys : String , CodingKey{
        case id = "_id"
        case name,email
        case phoneNumber
        case countryCode
        case countryCodeAndPhoneNumber = "countryCode_phonenumber"
        case password
        case idVerification,role
        case image
        case isAdmin
        case loginTime = "login_time"
        case securityKey = "security_key"
        case token,bio
        case isNotification
        case createdAt,updatedAt
        case v = "__v"
        case otp
        case forgotPasswordToken
        case otpVerified
        case ranToken,deviceToken
        case termAndCondition
        case referal_code
        
    }
    init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try values.decodeIfPresent(String.self, forKey: .id)
            self.name = try values.decodeIfPresent(String.self, forKey: .name)
            self.email = try values.decodeIfPresent(String.self, forKey: .email)
            self.phoneNumber = try values.decodeIfPresent(Int.self, forKey: .phoneNumber)
            self.countryCode = try values.decodeIfPresent(String.self, forKey: .countryCode)
            self.countryCodeAndPhoneNumber = try values.decodeIfPresent(String.self, forKey: .countryCodeAndPhoneNumber)
            self.password = try values.decodeIfPresent(String.self, forKey: .password)
            self.idVerification = try values.decodeIfPresent(Int.self, forKey: .idVerification)
            self.role = try values.decodeIfPresent(Int.self, forKey: .role)
            self.image = try values.decodeIfPresent(String.self, forKey: .image)
            self.isAdmin = try values.decodeIfPresent(Bool.self, forKey: .isAdmin)
            self.loginTime = try values.decodeIfPresent(Int.self, forKey: .loginTime)
            self.securityKey = try values.decodeIfPresent(String.self, forKey: .securityKey)
            self.token = try values.decodeIfPresent(String.self, forKey: .token)
            self.bio = try values.decodeIfPresent(String.self, forKey: .bio)
            self.isNotification = try values.decodeIfPresent(Int.self, forKey: .isNotification)
            self.createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
            self.updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
            self.v = try values.decodeIfPresent(Int.self, forKey: .v)
            self.otp = try values.decodeIfPresent(Int.self, forKey: .otp)
            self.forgotPasswordToken = try values.decodeIfPresent(String.self, forKey: .forgotPasswordToken)
            self.otpVerified = try values.decodeIfPresent(Int.self, forKey: .otpVerified)
            self.ranToken = try values.decodeIfPresent(String.self, forKey: .ranToken)
            self.deviceToken = try values.decodeIfPresent(String.self, forKey: .deviceToken)
            self.termAndCondition = try values.decodeIfPresent(String.self, forKey: .termAndCondition)
            self.referal_code = try values.decodeIfPresent(String.self, forKey: .referal_code)
        }
        catch {
            debugPrint(error.localizedDescription)
        }
        
    }
    
    
    
    
    
    
}
