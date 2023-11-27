//
//  CheckValidation.swift
//  AirCloset
//
//  Created by cql200 on 05/05/23.
//

import Foundation
import UIKit

class CheckValidation{
    
    class func checkSignUpDetails(profileImg:UIImageView?, name:UITextField, email:UITextField, countryCd:UITextField, phoneNumber:UITextField, password: UITextField, confirmPassword: UITextField, role: Int) -> Bool{
        if (profileImg?.image?.isEqualToImage(image:UIImage(named: "profileCenter")!))! {
            CommonUtilities.shared.showSwiftAlert(message: "Please upload profile Image", isSuccess: .error)
            return false
        }
        else if name.text!.isBlank{
            CommonUtilities.shared.showSwiftAlert(message: "Please enter your Name", isSuccess: .error)
            return false
        }
        else if email.text!.isBlank{
            CommonUtilities.shared.showSwiftAlert(message: "Please enter your Email ID", isSuccess: .error)
            return false
        }
        else if !email.text!.isValidEmail{
            CommonUtilities.shared.showSwiftAlert(message: "Please enter a valid Email ID", isSuccess: .error)
            return false
        }
        else if countryCd.text!.isBlank{
            CommonUtilities.shared.showSwiftAlert(message: "Please select country Code", isSuccess: .error)
            return false
        }
        else if phoneNumber.text!.isBlank{
            CommonUtilities.shared.showSwiftAlert(message: "Please enter your Phone Number", isSuccess: .error)
            return false
        }
        else if phoneNumber.text!.count < 6 || phoneNumber.text!.count > 13 {
            
            CommonUtilities.shared.showSwiftAlert(message: "Please enter your valid Number", isSuccess: .error)
            return false
        }
        else if password.text!.isBlank{
            CommonUtilities.shared.showSwiftAlert(message: "Please enter Password", isSuccess: .error)
            return false
            
        }
        else if password.text!.count < 8 {
            CommonUtilities.shared.showSwiftAlert(message: "Minimum password length should be 8", isSuccess: .error)
            return false
        }
        else if confirmPassword.text!.isBlank{
            CommonUtilities.shared.showSwiftAlert(message: "Please enter Confirm Password", isSuccess: .error)
            return false
        }

        else if confirmPassword.text! != password.text!{
            CommonUtilities.shared.showSwiftAlert(message: "Password and Confirm Password does not match ", isSuccess: .error)
            return false
        }

        return true
    }

    class func checkingOtpVerification(otp : String) -> Bool{
          
        if otp.count == 0 {
            CommonUtilities.shared.showSwiftAlert(message: "Please enter OTP", isSuccess: .error)
            return false
            
        }else if otp.count < 4 {
            CommonUtilities.shared.showSwiftAlert(message: "Please enter valid OTP", isSuccess: .error)
            return false
        }
          return true
      }
    
    
    class func checkLoginDetails(email : UITextField, password : UITextField) -> Bool{
        if email.text!.isBlank {
            CommonUtilities.shared.showSwiftAlert(message: "Please enter your Email ID", isSuccess: .error)
            return false
        }
        
        else if !email.text!.isValidEmail {
            CommonUtilities.shared.showSwiftAlert(message: "Please enter a valid Email ID", isSuccess: .error)
            return false
        }
       
        else if password.text!.isBlank{
            CommonUtilities.shared.showSwiftAlert(message: "Please enter your Password", isSuccess: .error)
            return false
        }
        return true
    }
    
    class func checkforgotPassEmail(email : UITextField) -> Bool{
        if email.text!.isBlank {
            CommonUtilities.shared.showSwiftAlert(message: "Please enter your Email ID", isSuccess: .error)
            return false
        }
        else if !email.text!.isValidEmail {
            CommonUtilities.shared.showSwiftAlert(message: "Please enter a valid Email ID", isSuccess: .error)
            return false
        }
        return true
    }

    class func checkEditProfile(name : UITextField, phoneno : UITextField, terms: String) -> Bool{
        if name.text!.isBlank {
            CommonUtilities.shared.showSwiftAlert(message: "Please enter your Name", isSuccess: .error)
            return false
        }
        else if phoneno.text.self!.trimmingCharacters(in: .whitespaces).isEmpty == true{
            return true
        }
        else if phoneno.text!.count < 8 || phoneno.text!.count > 13 {
            CommonUtilities.shared.showSwiftAlert(message: "Please enter your valid Number", isSuccess: .error)
            return false
        }
//        else if terms.isBlank{
//            CommonUtilities.shared.showSwiftAlert(message: "Please enter terms And Conditions", isSuccess: .error)
//            return false
//        }
        
        return true
    }
 
    class func checkChangePass(oldPassword : UITextField,newPassword : UITextField,confirmPassword : UITextField ) -> Bool{
        
        if oldPassword.text!.isBlank{
            CommonUtilities.shared.showSwiftAlert(message: "Please enter your old Password", isSuccess: .error)
            return false
        }
        else if oldPassword.text!.count < 8 {
            CommonUtilities.shared.showSwiftAlert(message: "Minimum password length should be 8", isSuccess: .error)
            return false
        }
        
        else if newPassword.text!.isBlank{
            CommonUtilities.shared.showSwiftAlert(message: "Please enter your new Password", isSuccess: .error)
            return false
        }
        else if newPassword.text!.count < 8 {
            CommonUtilities.shared.showSwiftAlert(message: "Minimum password length should be 8", isSuccess: .error)
            return false
        }
        else if confirmPassword.text!.isBlank{
            CommonUtilities.shared.showSwiftAlert(message: "Please enter Confirm Password", isSuccess: .error)
            return false
        }

        else if confirmPassword.text! != newPassword.text!{
            CommonUtilities.shared.showSwiftAlert(message: "Password and Confirm Password does not match ", isSuccess: .error)
            return false
        }

        return true
    }

    class func checkCreateProductData(image : [UIImageView],description : String,categoryId : String,brandId : String,sizeId: String,conditionId: String,price : Int,deposit: Int,colorId : String,styleId : String, shipping : Int,locationName : String, name: String ,facilities : Bool) -> Bool{
        
        if image.count == 0 {
            CommonUtilities.shared.showSwiftAlert(message: "Please select atleast 1 image", isSuccess: .error)
            return false
        }
        
        else if name.isBlank {
            CommonUtilities.shared.showSwiftAlert(message: "Please enter product name.", isSuccess: .error)
            return false
        }
        else if description.isBlank {
            CommonUtilities.shared.showSwiftAlert(message: "Please enter description", isSuccess: .error)
            return false
        }

        else if categoryId.isBlank {
            CommonUtilities.shared.showSwiftAlert(message: "Please select category", isSuccess: .error)
            return false
        }
        else if brandId.isBlank{
            CommonUtilities.shared.showSwiftAlert(message: "Please select brand", isSuccess: .error)
            return false
        }
        else if sizeId.isBlank{
            CommonUtilities.shared.showSwiftAlert(message: "Please select size", isSuccess: .error)
            return false
        }
        else if conditionId.isBlank{
            CommonUtilities.shared.showSwiftAlert(message: "Please select condition", isSuccess: .error)
            return false
        }
        else if price <= 0{
            CommonUtilities.shared.showSwiftAlert(message: "Please enter rent amount", isSuccess: .error)
            return false
        }
        
        else if facilities == false{
            CommonUtilities.shared.showSwiftAlert(message: "Please select facilities.", isSuccess: .error)
            return false
        }
        
        else if deposit <= 0{
            CommonUtilities.shared.showSwiftAlert(message: "Please enter deposit amount", isSuccess: .error)
            return false
        }
        else if shipping <= 0{
            CommonUtilities.shared.showSwiftAlert(message: "Please enter shipping amount", isSuccess: .error)
            return false
        }
        else if locationName.isBlank{
            CommonUtilities.shared.showSwiftAlert(message: "Please select location", isSuccess: .error)
            return false
        }
        return true

    }

    class func checkCreateOrderData(productId : String,startDate : String,countryCode : String,phoneNumber : String,endDate : String,address : String, numberOfNights : Int) -> Bool{
        
        if productId.isBlank {
            CommonUtilities.shared.showSwiftAlert(message: "Not Valid Product", isSuccess: .error)
            return false
        }
        
        else if startDate.isBlank {
            CommonUtilities.shared.showSwiftAlert(message: "Please enter Pickup Date", isSuccess: .error)
            return false
        }
        else if countryCode == "+1"{
            CommonUtilities.shared.showSwiftAlert(message: "Please select country Code", isSuccess: .error)
            return false
        }
        
        else if phoneNumber.isBlank{
            CommonUtilities.shared.showSwiftAlert(message: "Please enter your Phone Number", isSuccess: .error)
            return false
        }
        
        else if phoneNumber.count < 8 || phoneNumber.count > 13 {
            CommonUtilities.shared.showSwiftAlert(message: "Please enter your valid Number", isSuccess: .error)
            return false
        }
        else if numberOfNights < 1 {
            CommonUtilities.shared.showSwiftAlert(message: "Please enter the total Nights", isSuccess: .error)
            return false
        }
        
        else if address.isBlank{
            CommonUtilities.shared.showSwiftAlert(message: "Please enter your delivery Address", isSuccess: .error)
            return false
        }
        return true
    
}
    
    class func checkAddNewCardData(holderName : String,cardnumber : String,expMonth : String, expYear : String,cvv : String ) -> Bool{
        
        if holderName.isBlank {
            CommonUtilities.shared.showSwiftAlert(message: "Please Enter Card Holder Name", isSuccess: .error)
            return false
        }
       
        else if cardnumber.isBlank {
            CommonUtilities.shared.showSwiftAlert(message: "Please Enter Your Card Number", isSuccess: .error)
            return false
        }
        else if cardnumber.count < 16 || cardnumber.count > 16{
            CommonUtilities.shared.showSwiftAlert(message: "Please Enter Your Valid Card Number", isSuccess: .error)
            return false
        }
        else if expMonth.isBlank {
            CommonUtilities.shared.showSwiftAlert(message: "Please Rnter Expiry Of Your Card", isSuccess: .error)
            return false
        }
        else if cvv.isBlank{
            CommonUtilities.shared.showSwiftAlert(message: "Please Enter Your CVV Number", isSuccess: .error)
            return false
        }
        else if cvv.count != 3{
            CommonUtilities.shared.showSwiftAlert(message: "Please Enter Your Valid CVV Number", isSuccess: .error)
            return false
        }
        
        return true
    }
 
    class func checkAddBankDetailData(accountHolderName : String,bankName : String,accountNumber : String,confirmAccNo : String, ifscCode : String) -> Bool{
        if accountHolderName.isBlank{
            CommonUtilities.shared.showSwiftAlert(message: "Please Enter Account Holder Name", isSuccess: .error)
            return false
        }
        else if bankName.isBlank{
            CommonUtilities.shared.showSwiftAlert(message: "Please Enter Bank Name", isSuccess: .error)
            return false
        }
        else if accountNumber.isBlank{
            CommonUtilities.shared.showSwiftAlert(message: "Please Enter Account Number", isSuccess: .error)
            return false
        }
        else if accountNumber.count < 6 || accountNumber.count > 20{
            CommonUtilities.shared.showSwiftAlert(message: "Please Enter a Valid Account Number", isSuccess: .error)
            return false
        }
        else if confirmAccNo.isBlank{
            CommonUtilities.shared.showSwiftAlert(message: "Please Confirm Your Account Number", isSuccess: .error)
            return false
        }
        else if confirmAccNo != accountNumber {
            CommonUtilities.shared.showSwiftAlert(message: "Confirm Account Number does not match ", isSuccess: .error)
            return false
        }
        else if ifscCode.isBlank {
            CommonUtilities.shared.showSwiftAlert(message: "Please Enter BSB Number ", isSuccess: .error)
            return false
        }
             
return true
    }
}
