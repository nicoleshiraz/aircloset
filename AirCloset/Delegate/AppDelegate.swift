//
//  AppDelegate.swift
//  AirCloset
//
//  Created by cql105 on 28/03/23.
//

import UIKit
import IQKeyboardManagerSwift
import FacebookCore
import UserNotifications

var isChatOpen = false

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        SocketIOManager.sharedInstance.socket.connect()
        // ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        registerForPushNotifications()
        sleep(2)
        checkLogin()
        selectedType = 0
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    //    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    //
    //        let FBHandle = ApplicationDelegate.shared.application(app, open: url, options: options)
    //        return FBHandle
    //    }
}

extension AppDelegate:UNUserNotificationCenterDelegate {
    
    class var sharedDelegate:AppDelegate {
        return (UIApplication.shared.delegate as? AppDelegate)!
    }
    //MARK:- register for push notifications
    
    func registerForPushNotifications() {
        UIApplication.shared.applicationIconBadgeNumber = 0
        // UIApplication.shared.cancelAllLocalNotifications()
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
            (granted, error) in
            print("Permission granted: \(granted)")
            // 1. Check if permission granted
            guard granted else { return }
            // 2. Attempt registration for remote notifications on the main thread
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
    
    func badge(_ application: UIApplication,didReceiveRemoteNotification userInfo: [AnyHashable : Any],fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        let badgeNumber = UIApplication.shared.applicationIconBadgeNumber + 1
        UIApplication.shared.applicationIconBadgeNumber = badgeNumber
    }
    
    //MARK:- Notification work and device token
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data -> String in
            return String(format: "%02.2hhx", data)
        }
        let token = tokenParts.joined()
        // 2. Print device token to use for PNs payloads
        print("Device Token: \(token)")
        DeviceToken = token
        Store.deviceToken = token
        UserDefaults.standard.set(deviceToken, forKey: "deviceToken")
        UserDefaults.standard.synchronize()
        
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register for remote notifications with error: \(error)")
        Store.deviceToken = "simulator/error"
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        if !isChatOpen {
            completionHandler([.sound, .alert, .badge])
        } else {
            completionHandler([])
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,   didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if let userInfo = response.notification.request.content.userInfo as? [String:Any] {
            print("**********************")
            print(userInfo["data"] as? [String: Any] ?? [:])
            let userInfofData = userInfo["data"] as? [String: Any] ?? [:]
            NotificationRedirections.shared.fetchUserInfoData(data: userInfofData)
            print(userInfofData)
        }
    }
}




//   MARK: Chek User Auto login

extension AppDelegate {
    
    func checkLogin() {
        if Store.autoLogin == true {
            if Store.userDetails?.body?.otpVerified == 1 {
                let homeStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
                let vc = homeStoryboard.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
                let nav = UINavigationController.init(rootViewController: vc)
                nav.isNavigationBarHidden = true
                nav.interactivePopGestureRecognizer?.isEnabled = false
                UIApplication.shared.windows.first?.rootViewController = nav
            }
            else if Store.userDetails?.body?.otpVerified == 0 {
                let storyb = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyb.instantiateViewController(withIdentifier: "VerificationVC") as! VerificationVC
                let nav = UINavigationController.init(rootViewController: vc)
                nav.isNavigationBarHidden = true
                nav.interactivePopGestureRecognizer?.isEnabled = false
                UIApplication.shared.windows.first?.rootViewController = nav
            }
        } else {
            
            if Store.walkThrough == true {
                let storyb = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyb.instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
                let nav = UINavigationController.init(rootViewController: vc)
                nav.isNavigationBarHidden = true
                nav.interactivePopGestureRecognizer?.isEnabled = false
                UIApplication.shared.windows.first?.rootViewController = nav
            } else {
                let storyb = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyb.instantiateViewController(withIdentifier: "WalkThroughVC") as! WalkThroughVC
                let nav = UINavigationController.init(rootViewController: vc)
                nav.isNavigationBarHidden = true
                nav.interactivePopGestureRecognizer?.isEnabled = false
                UIApplication.shared.windows.first?.rootViewController = nav
            }
            

            
           
        }
    }
}
