// MARK: Reference Guide for Facebook Login
// Setup for Application setting on https://developers.facebook.com
// https://developers.facebook.com/apps/707421783097001/fb-login/quickstart/

/*
 // Add Below info in AppDelegate.swift
 
 import FBSDKCoreKit
 
 func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
     // Override point for customization after application launch.
     
     ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
 
     return true
 }
 
 func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
     
     let FBHandle = ApplicationDelegate.shared.application(app, open: url, options: options)
     return FBHandle
 }
*/

import Foundation
import FBSDKLoginKit
import FBSDKCoreKit
import SwiftUI

class FacebookLoginManager: NSObject {
    static let shared = FacebookLoginManager()
    private override init() {}
    
    typealias COMPLETION_HANDLER = (FBModel)->Void
    private var completionHandler: COMPLETION_HANDLER?
    private let fbLoginManager : LoginManager = LoginManager()

    func setup(_ viewController: UIViewController, completion: @escaping COMPLETION_HANDLER) {
        
        self.completionHandler = completion
        fbLoginManager.logIn(permissions: ["email","public_profile"], from: viewController) { (result, error) -> Void in
          if (error == nil){
            let fbloginresult : LoginManagerLoginResult = result!
            // if user cancel the login
            if (result?.isCancelled)!{
                return
            }
            if(fbloginresult.grantedPermissions.contains("email"))
            {
                self.getFBUserData()
            }
          }
        }
    }
    
    func getFBUserData(){
        if((AccessToken.current) != nil){
            GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    let dict: NSDictionary = result as! NSDictionary
                    let model = FBModel()
//                    var userID = parameters["id"] as! Int
//                    var facebookProfileUrl = "http://graph.facebook.com/\(userID)/picture?type=large"
//                    let facebookurl = "https://platform-lookaside.fbsbx.com/platform"
//
                    guard let userInfo = result as? [String: Any] else { return } //handle the error

                    if let imageURL = ((userInfo["picture"] as? [String: Any])?["data"] as? [String: Any])?["url"] as? String {
                        //Download image from imageURL
                        
                        let fileUrl = URL(string: imageURL)

                        let imageData = NSData(contentsOf: fileUrl! )
                        var image = UIImage(data: imageData! as Data)
                         
                         model.handleData(dict: dict)
                         self.fbLoginManager.logOut()
                         if self.completionHandler != nil {
                             self.completionHandler!(model)
                         }
                    }


                    
                    
                }
            })
        }
    }
    
    func logOutFacebook(){
        self.fbLoginManager.logOut()
    }
    
}

// MARK:- Fetch User Information from Facebook

class FBModel{
    var token, name, firstName, lastName, id, email, picture: String!
    
    func handleData(dict: NSDictionary) {
        if let token = AccessToken.current?.tokenString {
            self.token = token
        }
        
        if let name  = dict["name"] as? String {
            self.name = name
        }
        
        if let firstName  = dict["first_name"] as? String {
            self.firstName = firstName
        }
        
        if let lastName  = dict["last_name"] as? String {
            self.lastName = lastName
        }
        
        if let id = dict["id"] as? String {
            self.id = id
        }
        
        if let email = dict["email"] as? String {
            self.email = email
        }
        
        if let picture = dict["picture"] as? NSDictionary {
            if let data = picture["data"] as? NSDictionary {
                if let imageURL = data["url"] as? String {
                    self.picture = imageURL
                }
            }
        }
    }
}


