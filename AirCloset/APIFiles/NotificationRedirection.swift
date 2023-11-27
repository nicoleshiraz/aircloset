//
//  NotificationRedirection.swift
//  AirCloset
//
//  Created by cqlios3 on 07/08/23.
//

import UIKit
import Foundation

//MARK: - When user tap on notification

class NotificationRedirections{
    static let shared = NotificationRedirections()
    func fetchUserInfoData(data: [String: Any]){
        if Store.autoLogin == true{
            
            if data["notificationType"] as? Int ?? 0 == 10 || data["notificationType"] as? Int ?? 0 == 13 {
                nevigateToHome()
            } else if data["notificationType"] as? Int ?? 0 == 12{
                var dataa = data["data"] as? [String:Any]
                nevigateToChat(receiverId: dataa?["_id"] as? String ?? "", reciverName: dataa?["name"] as? String ?? "", receiverImg: dataa?["image"] as? String ?? "")
            } else {
                nevigateToBookingDetails2(bookingid: String(data["booking_id"] as? Int ?? 0), type: data["user_type"] as? String ?? "")
            }
        }
    }
    
    func nevigateToBookingDetails2(bookingid : String, type: String) {
        let homeStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = homeStoryboard.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
        if type == "seller" {
            selectedType = 2
        } else {
            selectedType = 1
        }
        vc.selectedIndex = 2
        let nav = UINavigationController.init(rootViewController: vc)
        nav.isNavigationBarHidden = true
        UIApplication.shared.windows.first?.rootViewController = nav
    }
    
    func nevigateToHome() {
        let homeStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = homeStoryboard.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
        vc.selectedIndex = 0
        let nav = UINavigationController.init(rootViewController: vc)
        nav.isNavigationBarHidden = true
        UIApplication.shared.windows.first?.rootViewController = nav
    }
    
    func nevigateToChat(receiverId: String,reciverName: String , receiverImg: String ) {
        let homeStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = homeStoryboard.instantiateViewController(withIdentifier: "ChatVC") as! ChatVC
        let nav = UINavigationController.init(rootViewController: vc)
        nav.isNavigationBarHidden = true
        vc.comes = "Notif"
        vc.receiverId = receiverId
        vc.reciverName = reciverName
        vc.receiverImg = receiverImg
        UIApplication.shared.windows.first?.rootViewController = nav
    }
 
    var rootController1: UIViewController?{
        if let window =  UIApplication.shared.windows.first(where: { $0.isKeyWindow}){
            return window.rootViewController
        }
        return UIViewController()
    }
}
