//
//  Constant.swift
//  SCA
//
//  Created by cqlapple on 11/08/21.
//

import Foundation
import UIKit
import AVFoundation
import AVKit
import SwiftUI


//MARK:  Base URL

//http://192.168.1.222:1434


//let baseURL                             = "http://192.168.1.236:1434/"
//let imageURL                            = "http://192.168.1.236:1434/Image/userImage/"
//let homeImageUrl                        = "http://192.168.1.236:1434/Image/homeProfileImage/"
//let productImageUrl                     = "http://192.168.1.236:1434/Image/productImage/"
//let videoUrl                            = "http://192.168.1.236:1434/"
//let videoURLS                           = "http://192.168.1.236:1434/"
//let videoThumbnail                      = "http://192.168.1.236:1434/"
//let verification                        = "http://192.168.1.236:1434/Image/idVerification/"
//let returnImage                         = "http://192.168.1.236:1434/Image/orders/"
//MARK:  Live URL

let baseURL                             = "http://65.2.68.95:1434/"
let imageURL                            = "http://65.2.68.95:1434/Image/userImage/"
let homeImageUrl                        = "http://65.2.68.95:1434/Image/homeProfileImage/"
let productImageUrl                     = "http://65.2.68.95:1434/Image/productImage/"
let videoUrl                            = "http://65.2.68.95:1434/"
let videoURLS                           = "http://65.2.68.95:1434/"
let videoThumbnail                      = "http://65.2.68.95:1434/"
let verification                        = "http://65.2.68.95:1434/Image/idVerification/"
let returnImage                         = "http://65.2.68.95:1434/Image/orders/"

let securityKey                         = "Bbz3G9AwLNqKuG5OSn5GriwXvw=="
let publishKey                          = "U0Kvc4Wzg6AYZMbx29m2eJHa3g=="
var noInternetConnection                = "No Internet Connection Available"
var appName                             = "Air Closet"
var DeviceToken                         = "abc"

public typealias parameter =  [String:Any]
let imagePickerSources = ImagePickerClass()
public typealias parameters = [String:Any]
let window = UIApplication.shared.windows.first
typealias successResponse = (()->())
var isSocialLogin = Bool()

//MARK:- StoryBoard
enum AppStoryboard: String {
    case Main = "Main"
    var instance: UIStoryboard{
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
}

//STORE FILE
enum DefaultKeys: String{
    case isSocial
    case authKey
    case userDetails
    case autoLogin
    case deviceToken
    case startDate
    case phoneNumber
    case countryCode
    case lat
    case long
    case id
    case walkThrough

}

//MARK: API - SERVICES
enum Services: String
{
    case get                            = "GET"
    case post                           = "POST"
    case put                            = "PUT"
    case delete                         = "DELETE"
}

//MARK: API - ENUM
enum API: String
{
   case signup                          = "user/createUsers"
    case logIn                          = "user/userLogin"
    case otp                            = "user/verifyRegisterUserOtp"
    case forgotPass                     = "user/forgotPassword"
    case resendOtp                      = "user/resendOtp"
    case logOut                         = "user/userLogout"
    case userProfile                    = "user/userProfile"
    case editProfile                    = "user/editProfile"
    case changePassword                 = "user/changeUserPassword"
    case cms                            = "user/cmsClosetGetForUser"
    case notificationStatus             = "user/notificationStatus"
    case socialLogin                    = "user/social"
    case homeData                       = "user/getForHome"
    case deleteAccount                  = "user/deleteUserAccount"
    case addFavorite                    = "user/addFavouritess"
    case productDetail                  = "user/getSingleProduct"
    case catagory                       = "scc/categoryGetAll"
    case condition                      = "scc/conditionGetAll"
    case colorList                      = "scc/colorGetAll"
    case styleList                      = "scc/styleGetAll"
    case brandList                      = "scc/brandGetAll"
    case sizeList                       = "scc/sizeGetAll"
    case productCreate                  = "user/productCreate"
    case createOrder                    = "user/orderCreate"
    case addNewCard                     = "user/createCardDetail"
    case cardListDetail                 = "user/getCardDetail"
    case setDefaultCard                 = "user/setDefaultCard"
    case payNow                         = "user/payNow"
    case addNewBank                     = "user/createBankDetail"
    case bankListdetail                 = "user/getBankDetail"
    case setDefaultBank                 = "user/setDefaultBank"
    case deletebank                     = "user/deleteBank"
    case getclosetListing               = "user/getClosetListing"
    case getMyClosetDetail              = "user/getMyClosetProfile"
    case getSingleOrderDeatil           = "user/getSingleOrder"
    case acceptRejectBooking            = "user/acceptRejectBooking"
    case cancelBooking                  = "user/cancelBooking"
    case pickOrder                      = "user/pickUpOrder"
    case getPaymentRecepe               = "user/getPaymentRecepe"
    case getBlockUser                   = "user/getBlockedUser"
    case deleteProduct                  = "user/deleteProduct"
    case addRateReview                  = "user/ratingReviewCreate"
    case sellerProfile                  = "user/getSellerProfile"
    case suscribe                       = "user/subscribeUser"
    case sellerProfilee                 = "user/getSellerRatingProfile"
    case rateReview                     = "user/getRatingReview"
    case deleteCard                     = "user/deleteCard"
    case walletData                     = "user/wallet_list"
    case withdrawlFromWallet            = "user/withdrawlFromWallet"
    case addPaymentToWalet              = "user/addPaymentToWalet"
    case idVerificationCreate           = "user/idVerificationCreate"
    case ratingReviews                  = "user/myProductsReview"
    case getSingleProductReview         = "user/getSigleProductRevies"

    case notifications                  = "user/getNotification"
    case rating                         = "user/rating"
    case returnClothes                  = "user/returnClothes"
    case verificationData               = "user/getVerification"
    case contactUss                     = "user/contactSupportCreate"
    case uploadReturnProof              = "user/orderImageUpload"
}

enum dateFormat: String {
    case fullDate                       = "MM_dd_yy_HH:mm:ss.SS"
    case MonthDayYear                   = "MMM d, yyyy"
    case MonthDay                       = "MMM dd EEE"
    case DateAndTime                    = "dd/M/yyyy hh:mm a"
    case TimeWithAMorPMandMonthDay      = "hh:mm a MMM dd EEE"
    case TimeWithAMorPMandDate          = "hh:mm a MMM d, yyyy"
    case dateTimeFormat                 = "yyyy-MM-dd'T'HH:mm:ssZ"
    case yearMonthFormat                = "yyyy-MM-dd"
    case slashDate                      = "dd/MM/yyyy"
    case timeAmPm                       = "hh:mm a"
    case BackEndFormat                  = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"

    
}

//MARK: REGEX - MESSAGE
enum RegexMessage: String {
    case invalidBlnkEmail               = "Please enter email"
}

var rootVC: UIViewController?{
    get{
        return UIApplication.shared.windows.first?.rootViewController
    }
    set{
        UIApplication.shared.windows.first?.rootViewController = newValue
    }
}

func createThumbnailOfVideoFromFileURL(videoURL: URL) -> UIImage? {
       let asset = AVAsset(url: videoURL)
       let assetImgGenerate = AVAssetImageGenerator(asset: asset)
       assetImgGenerate.appliesPreferredTrackTransform = true
       let time = CMTimeMakeWithSeconds(Float64(1), preferredTimescale: 100)
       do {
           let img = try assetImgGenerate.copyCGImage(at: time, actualTime: nil)
           let thumbnail = UIImage(cgImage: img)
           return thumbnail
       } catch {
           return UIImage(named: "music")
       }
   }
