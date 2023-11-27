//
//  AuthViewModel.swift
//  AirCloset
//
//  Created by cql200 on 05/05/23.
//

import Foundation
import UIKit

class AuthViewModel : NSObject{
    var onSuccess : successResponse?
    var profileModel:MyProfileAndEditProfileModel?
    var cmsModel : CMSModel?
    var notificationStatusModel : NotificationStatus?
    
    //MARK: - SignUP
    func signUpApi(img : UIImageView?, name : String,email : String, countryCode : String, phoneNumber : String,password : String, role : Int, latitude : String,longitude : String, deviceTokenn: String , deviceTypee: String, referal: String){
        
        let IdImageInfo : ImageStructInfo
        
        IdImageInfo = ImageStructInfo.init(fileName: "Img\(img).jpeg", type: "jpeg", data: (img?.image?.toData())! , key: "image")
         
        var param = ["image":IdImageInfo,"name":name, "email":email, "countryCode":countryCode, "phoneNumber":phoneNumber, "password" : password , "role" : role,"bio":"","deviceToken": deviceTokenn , "deviceType": deviceTypee,"referal_code":referal] as [String : Any]

        if latitude != "0.0"{
        param["latitude"] = latitude
        }
        if longitude != "0.0"{
            param["longitude"] = longitude
        }
        
        WebService.service(API.signup,param: param, service: .post, showHud: true) { (userData : SignUpModel , data, json) in
            Store.authKey = userData.body?.token
            Store.userDetails = userData
            print(userData)
            //CommonUtilities.shared.showSwiftAlert(message: userData.message ?? "", isSuccess: .success)
            self.onSuccess?()
        }
    }
    
    //MARK: - OTP
    func otpVerifyApi(phoneNumber : String, otp : String){
        let param = ["phoneNumber": phoneNumber,"otp" : otp]
        WebService.service(.otp,param: param, service: .post, showHud: true) { (verificationData : CommonModel, data,json) in
           // CommonUtilities.shared.showSwiftAlert(message: verificationData.message ?? "", isSuccess: .success)
            Store.userDetails?.body?.otpVerified = 1
            self.onSuccess?()
        }
    }
    
    //MARK: - Login
    func loginApi(email: String, password : String, latitude : String, longitude : String, deviceTokenn: String , deviceTypee: String){
        var param = ["email" : email,"password": password,"deviceToken": deviceTokenn , "deviceType": deviceTypee]
        if latitude != "0.0"{
            param["latitude"] = latitude
        }
        if longitude != "0.0"{
            param["longitude"] = longitude
        }

        WebService.service(.logIn,param: param , service: .post, showHud: true) { (userDATA : SignUpModel, data, json) in
           // CommonUtilities.shared.showSwiftAlert(message: userDATA.message ?? "", isSuccess: .success)
            print(param)
            Store.authKey = userDATA.body?.token ?? ""
            Store.autoLogin = true
            Store.userDetails = userDATA
            print(userDATA)
            self.onSuccess?()
        }
    }
    
    //MARK: - ForgetPassword
    func forgotPassApi(email : String){
        let param = ["email" : email]
        WebService.service(.forgotPass,param: param, service: .post, showHud: true) { (forgotUserDATA : CommonModel, data, json) in
            CommonUtilities.shared.showSwiftAlert(message: forgotUserDATA.message ?? "", isSuccess: .success)
            self.onSuccess?()
        }
    }
    
    //MARK: - ResendOtp
    func resendOtp(phoneNo : String){
        let param = ["phoneNumber" : phoneNo]
        WebService.service(.resendOtp, param: param, service: .post, showHud: true) { (resendOtpUserData : CommonModel, data, json) in
            CommonUtilities.shared.showSwiftAlert(message: ("\(resendOtpUserData.message ?? "")  Use 1111 as static OTP"), isSuccess: .success)
            self.onSuccess?()
        }
    }

    //MARK: - LogOut
    func logOutApi(){
        WebService.service(.logOut,service: .post, showHud: true) { (logOutData : CommonModel, data, json) in
            CommonUtilities.shared.showSwiftAlert(message: logOutData.message ?? "", isSuccess: .success)
            self.onSuccess?()
        }
    }

    //MARK: - GetProfile
    func getProfileDetailapi(){
        WebService.service(.userProfile,service: .get, showHud: true) { (myProfileData : MyProfileAndEditProfileModel, data, json) in
            self.profileModel = myProfileData
            Store.userDetails?.body?.referal_code = myProfileData.body?.referal_code
            Store.userDetails?.body?.image = myProfileData.body?.image
            Store.userDetails?.body?.name = myProfileData.body?.name
            Store.userDetails?.body?.idVerification = myProfileData.body?.idVerification
             print(myProfileData)
            self.onSuccess?()
        }
    }
    
    //MARK: - EditProfile
    func editProfileApi(name : String, phoneNumber : String,imagee : UIImageView, bio: String,terms: String){
        let IdImageInfo : ImageStructInfo
        IdImageInfo = ImageStructInfo.init(fileName: "Img\(imagee).jpeg", type: "jpeg", data: (imagee.image?.toData())! , key: "image")
        let param = ["name" : name,"phoneNumber" : phoneNumber, "image" : IdImageInfo,"bio" : bio,"termAndCondition":terms] as [String : Any]
       
        WebService.service(.editProfile, param: param, service: .put, showHud: true) { (myProfileData : MyProfileAndEditProfileModel, data, json) in
            CommonUtilities.shared.showSwiftAlert(message: myProfileData.message ?? "", isSuccess: .success)
            self.onSuccess?()
        }
    }
    
    //MARK: - ChangePass
    func changePassApi(oldPass : String, newPass : String, confirmPass : String){
        let param = ["oldPassword" : oldPass, "newPassword" : newPass,"confirmPassword" : confirmPass]
        WebService.service(.changePassword, param: param, service: .post, showHud: true) {(changePassData : CommonModel, data, json) in
            CommonUtilities.shared.showSwiftAlert(message: changePassData.message ?? "", isSuccess: .success)
            self.onSuccess?()
        }
    }
    
    //MARK: - CMS
    func cmsApi(type : String){
        let param = ["type" : type]
        WebService.service(.cms, param: param, service: .post, showHud: false) { (cmsData : CMSModel,data,json) in
            self.cmsModel = cmsData
            self.onSuccess?()
        }
    }
    
    //MARK: - Notification
    func isNotificationnApi(isNotification : Int){
        let param = ["isNotification" : isNotification]
        WebService.service(.notificationStatus, param: param, service: .post, showHud: false) {(notificationStatus : NotificationStatus, data, json) in
            self.notificationStatusModel = notificationStatus
            self.onSuccess?()
        }
    }
    
    //MARK: - SocialLogin
    func socialLoginApi(image : UIImageView ,email : String,name : String, socialId : String, socialType : Int, deviceType : Int ){
                
        var IdImageInfo: ImageStructInfo = ImageStructInfo(fileName: "", type: "", data: Data(), key: "")
        IdImageInfo = ImageStructInfo.init(fileName: "Img\(image).jpeg", type: "jpeg", data: (image.image?.toData())! , key: "image")
        let param = ["image" : IdImageInfo,"email":email, "name":name, "socialId" : socialId, "socialType" : socialType, "deviceType" : deviceType ,"deviceToken": DeviceToken ] as [String : Any]
        WebService.service(.socialLogin, param: param, service: .post, showHud: true) { (socialData : SignUpModel, data, json) in
            
            Store.authKey = socialData.body?.token
            Store.userDetails = socialData
            Store.autoLogin = true
            self.onSuccess?()
        }
    }
    
    func deleteAccount(id : String){
        let param = ["_id" : id]
        WebService.service(.deleteAccount, param: param, service: .delete, showHud: true) { (DeletedAccData : DeleteAccountModel , data, json) in
            CommonUtilities.shared.showSwiftAlert(message: DeletedAccData.message ?? "", isSuccess: .success)
            self.onSuccess?()
        }
   
    }
    
}

