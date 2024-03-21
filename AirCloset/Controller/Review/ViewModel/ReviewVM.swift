//
//  ReviewVM.swift
//  AirCloset
//
//  Created by cqlios3 on 31/07/23.
//

import Foundation

class ReviewVM {
    
    //MARK: Api Call
    
    var reviewData: [ReviewModelBody]?
    var reviewSingleData: [SignleProductReviewBody]?
    
    func getRatingData(params: [String:Any],onSuccess: @escaping(()->())) {
        WebService.service(.ratingReviews ,param: params, service: .post) { (modelData : ReviewModel, data, json) in
            if let data = modelData.body {
                self.reviewData = data
            }
            onSuccess()
        }
    }
    
    func getSingleProductReview(params: [String:Any],onSuccess: @escaping(()->())) {
        WebService.service(.getSingleProductReview ,param: params, service: .post) { (modelData : SignleProductReview, data, json) in
            if let data = modelData.body {
                self.reviewSingleData = data
            }
            onSuccess()
        }
    }
    
}


struct SignleProductReview: Codable {
    var success: Bool?
    var code: Int?
    var message: String?
    var body: [SignleProductReviewBody]?
}

// MARK: - Body
struct SignleProductReviewBody: Codable {
    var id: String?
    var rating: Int?
    var review, message: String?
    var productID: SignleProductReviewProductID?
    var providerID: String?
    var userID: SignleProductReviewUserID?
    var createdAt, updatedAt: String?
    var v: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case rating, review, message
        case productID = "productId"
        case providerID = "providerId"
        case userID = "userId"
        case createdAt, updatedAt
        case v = "__v"
    }
}

// MARK: - ProductID
struct SignleProductReviewProductID: Codable {
    var location: SignleProductReviewLocation?
    var id, name: String?
    var price: Int?
    var image: [String]?
    var video, thumbnail, description: String?
    var deposit: Int?
    var facilities: String?
    var shipping: Int?
    var locationName: String?
    var lat, long: Double?
    var isFavourite, isAvailable: Int?
    var brandID, sizeID, categoryID, styleID: String?
    var colorID, serviceCharge, userID: String?
    var rating: Int?
    var createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case location
        case id = "_id"
        case name, price, image, video, thumbnail, description, deposit, facilities, shipping, locationName, lat, long, isFavourite, isAvailable
        case brandID = "brandId"
        case sizeID = "sizeId"
        case categoryID = "categoryId"
        case styleID = "styleId"
        case colorID = "colorId"
        case serviceCharge
        case userID = "userId"
        case rating, createdAt, updatedAt
    }
}

// MARK: - Location
struct SignleProductReviewLocation: Codable {
    var type: String?
    var coordinates: [Double]?
    var name: String?
}

// MARK: - UserID
struct SignleProductReviewUserID: Codable {
    var id, name, email: String?
    var phoneNumber: Int?
    var countryCode, countryCodePhonenumber, password: String?
    var idVerification, role: Int?
    var latitude, longitude, image: String?
    var isAdmin: Bool?
    var loginTime, deviceType, otp, otpVerified: Int?
    var deviceToken, token, bio, ranToken: String?
    var isVerified, isNotification: Int?
    var customerID, termAndCondition, stripeAccountID: String?
    var wallet: Double?
    var referalCode: String?
    var referalPoint: Int?
    var createdAt, updatedAt: String?
    var isDelete: Bool?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, email, phoneNumber, countryCode
        case countryCodePhonenumber = "countryCode_phonenumber"
        case password, idVerification, role, latitude, longitude, image, isAdmin
        case loginTime = "login_time"
        case deviceType, otp, otpVerified, deviceToken, token, bio, ranToken, isVerified, isNotification
        case customerID = "customerId"
        case termAndCondition
        case stripeAccountID = "stripeAccountId"
        case wallet
        case referalCode = "referal_code"
        case referalPoint = "referal_point"
        case createdAt, updatedAt, isDelete
    }
}

