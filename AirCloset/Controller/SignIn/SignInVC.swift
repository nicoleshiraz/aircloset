//
//  SignInVC.swift
//  AirCloset
//
//  Created by cql105 on 30/03/23.
//

import UIKit
import SwiftMessages
import FBSDKLoginKit
import AuthenticationServices
import CoreLocation
import SocketIO

class SignInVC: UIViewController {
    //Mark:--> Outlets
    @IBOutlet weak var signInVw: UIView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var pwdTF: UITextField!
    
    var vwModel = AuthViewModel()
    var imgVw = UIImageView()
    let locationManager = CLLocationManager()
    var latitude:Double?
    var longitude:Double?
    
    var appleLogInButton : ASAuthorizationAppleIDButton = {
        let button = ASAuthorizationAppleIDButton()
        button.addTarget(self, action: #selector(logInWithAppleBtnTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    //Mark :--> View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        signInVw.layer.cornerRadius = 50
        signInVw.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        print(latitude)
        print(longitude)
        
        locationManager.requestWhenInUseAuthorization()
        // Set the delegate
        locationManager.delegate = self
        // Set desired accuracy
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // Start updating location
        locationManager.startUpdatingLocation()
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            
        }else{
            openSettings()
        }
    }
    
    func openSettings(){
        if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url){
            UIApplication.shared.open(url)
        }
    }
    //    override func viewWillLayoutSubviews() {
    //            if !hasLocationPermission() {
    //                let alertController = UIAlertController(title: "Location Permission Required", message: "Please enable location permissions in settings.", preferredStyle: .alert)
    //
    //                let okAction = UIAlertAction(title: "Settings", style: .default, handler: {(cAlertAction) in
    //
    //                    UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
    //                })
    //
    //                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {(cnclAction) in
    //
    //                    self.navigationController?.popViewController(animated: true)
    //                })
    //                alertController.addAction(cancelAction)
    //
    //                alertController.addAction(okAction)
    //
    //                self.present(alertController, animated: true, completion: nil)
    //            }
    //        }
    
    func hasLocationPermission() -> Bool {
        var hasPermission = false
        // let manager = CLLocationManager()
        
        if CLLocationManager.locationServicesEnabled() {
            if #available(iOS 14.0, *) {
                switch locationManager.authorizationStatus {
                case .notDetermined, .restricted, .denied:
                    hasPermission = false
                case .authorizedAlways, .authorizedWhenInUse:
                    hasPermission = true
                    //getArea()
                @unknown default:
                    break
                }
            } else {
                // Fallback on earlier versions
            }
        } else {
            hasPermission = false
        }
        
        return hasPermission
    }
    
    //Mark:--> Actions
    @IBAction func tapBackBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func eyeBtnTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            pwdTF.isSecureTextEntry = false
        }
        else{
            pwdTF.isSecureTextEntry = true
        }
    }
    
    @IBAction func tapForgotPwdBtn(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordVC") as! ForgotPasswordVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tapSignInBtn(_ sender: UIButton) {
        if CheckValidation.checkLoginDetails(email: emailTF, password: pwdTF){
            vwModel.loginApi(email: emailTF.text ?? "", password: pwdTF.text ?? "",latitude: "\(Store.lat ?? 0.0)",longitude: "\(Store.lat ?? 0.0)",deviceTokenn: DeviceToken ,deviceTypee: "2")
            vwModel.onSuccess = { [weak self] in
                
                if !SocketIOManager.sharedInstance.isConnected(){
                    SocketIOManager.sharedInstance.updateAuthToken(Store.authKey ?? "")
                    SocketIOManager.sharedInstance.establishConnection()
                }
                
                if Store.userDetails?.body?.otpVerified == 1 {
                    
                    let vc = self?.storyboard?.instantiateViewController(identifier: "TabBarVC") as! TabBarVC
                    Store.autoLogin = true
                    let nav1 = UINavigationController()
                    nav1.navigationBar.isHidden = true
                    nav1.viewControllers = [vc]
                    CommonUtilities.shared.showSwiftAlert(message: "Login Success", isSuccess: .success)
                    self?.view.window?.rootViewController = nav1
                }
                
                else if Store.userDetails?.body?.otpVerified == 0 {
                    let vc = self?.storyboard?.instantiateViewController(withIdentifier: "VerificationVC") as! VerificationVC
                    CommonUtilities.shared.showSwiftAlert(message: "Please verify otp", isSuccess: .error)
                    CommonUtilities.shared.showSwiftAlert(message: "Use 1111 as a static OTP", isSuccess: .success)
                    self?.navigationController?.pushViewController(vc, animated: true)
                    
                }
            }
        }
    }
    
    @IBAction func logInWithGoogleBtnTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func logInWithFbBtnTapped(_ sender: UIButton) {
        
        let loginManager = LoginManager()
        
        loginManager.logIn(permissions: ["public_profile", "email"], from: self, handler: { result, error in
            if error != nil {
                print("ERROR: Trying to get login results")
            } else if result?.isCancelled != nil {
                print("The token is \(result?.token?.tokenString ?? "")")
                if result?.token?.tokenString != nil {
                    print("Logged in")
                    self.getUserProfile(token: result?.token, userId: result?.token?.userID)
                } else {
                    print("Cancelled")
                }
            }
        })
        
    }
    
    func isLoggedIn() -> Bool {
        let accessToken = AccessToken.current
        let isLoggedIn = accessToken != nil && !(accessToken?.isExpired ?? false)
        return isLoggedIn
    }
    @IBAction func logInWithAppleBtnTapped(_ sender: UIButton) {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.performRequests()
        
        //        AppleLoginManager.shared.setup { (userData) in
        //            print(userData)
        //
        //            self.vwModel.socialLoginApi(image: UIImageView(), email: "", name: userData.name, socialId: userData.id, socialType: 3, deviceType: 1)
        //
        //            self.vwModel.onSuccess = { [weak self] in
        //                Store.autoLogin =  true
        //                let vc = self?.storyboard?.instantiateViewController(identifier: "TabBarVC") as! TabBarVC
        //                Store.autoLogin = true
        //                let nav1 = UINavigationController()
        //                            nav1.navigationBar.isHidden = true
        //                            nav1.viewControllers = [vc]
        //                CommonUtilities.shared.showSwiftAlert(message: "Login Success", isSuccess: .success)
        //                self?.view.window?.rootViewController = nav1
        //
        //
        //            }
        //
        //
        ////            let request = ASAuthorizationAppleIDProvider().createRequest()
        ////            request.requestedScopes = [.fullName, .email]
        ////            let controller = ASAuthorizationController(authorizationRequests: [request])
        ////            controller.delegate = self
        ////            controller.presentationContextProvider = self
        ////            controller.performRequests()
        //        }
    }
    
    @IBAction func tapSignUpBtn(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension SignInVC {
    
    func getUserProfile(token: AccessToken?, userId: String?) {
        
        let graphRequest : GraphRequest = GraphRequest(graphPath: "me", parameters: ["fields":"id, name, first_name, last_name, email, picture.type(large)"])
        graphRequest.start(completionHandler: { (connection, result, error) -> Void in
            if ((error) != nil) {
                // Process error
                print("\n\n Error: \(error ?? "error" as! Error)")
            } else {
                let resultDic = result as! NSDictionary
                let id = resultDic.value(forKey:"id") as? String
                let userEmail = resultDic.value(forKey:"email") as? String
                let first_name = resultDic.value(forKey:"first_name") as? String
                let picture = resultDic.value(forKey:"picture") as? NSDictionary
                let dataImg = picture?["data"] as? NSDictionary
                let pic = dataImg?["url"] as? String
                print(result as! NSDictionary)
                self.imgVw.sd_setImage(with: URL.init(string: pic ?? ""))
                print(result as! NSDictionary)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.vwModel.socialLoginApi(image: self.imgVw, email: userEmail ?? "" , name: first_name ?? "", socialId: id ?? "", socialType: 2, deviceType: 1)
                    //    CommonUtilities.shared.showAlert(message: "Login Successfull", isSuccess: .success)
                    Store.socialLogin = true
                    self.vwModel.onSuccess = { [weak self] in
                        let vc = self?.storyboard?.instantiateViewController(identifier: "TabBarVC") as! TabBarVC
                        Store.autoLogin = true
                        let nav1 = UINavigationController()
                        nav1.navigationBar.isHidden = true
                        nav1.viewControllers = [vc]
                        CommonUtilities.shared.showSwiftAlert(message: "Login Success", isSuccess: .success)
                        self?.view.window?.rootViewController = nav1
                    }
                }
            }
        })
    }
}

extension SignInVC:ASAuthorizationControllerDelegate{
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as?  ASAuthorizationAppleIDCredential {
            let userIdentifier = appleIDCredential.user
            let givenName = appleIDCredential.fullName?.givenName
            let familyName = appleIDCredential.fullName?.familyName
            let email = appleIDCredential.email
            
            print("User id is \(userIdentifier) \n first Name is \(givenName ?? "") \n last name is \( familyName ?? "")  \n Email id is \( email ?? "")")
            Store.socialLogin = true
            self.vwModel.onSuccess = { [weak self] in
                let vc = self?.storyboard?.instantiateViewController(identifier: "TabBarVC") as! TabBarVC
                Store.autoLogin = true
                let nav1 = UINavigationController()
                nav1.navigationBar.isHidden = true
                nav1.viewControllers = [vc]
                CommonUtilities.shared.showSwiftAlert(message: "Login Success", isSuccess: .success)
                self?.view.window?.rootViewController = nav1
                
            }
            
        }
        
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
    }
}

// MARK: - Extension For Current location
extension SignInVC : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        Store.lat = location.coordinate.latitude
        Store.long = location.coordinate.longitude
        
        
        latitude = Store.lat
        longitude = Store.long
        // Use the latitude and longitude values as needed
        print("Latitude: \(latitude ?? 0.0)")
        print("Longitude: \(longitude ?? 0.0)")
        
        // Stop updating location if needed
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get location updates: \(error.localizedDescription)")
    }
}
