//
//  SettingsVC.swift
//  AirCloset
//
//  Created by cql105 on 07/04/23.
//

import UIKit
import SocketIO

class SettingsVC: UIViewController {
    //Mark :--> Outlets & Variables
    @IBOutlet weak var settingsTableVw: UITableView!
    var settingsImgAry = ["notification","account", "account", "referFrnd",
                          "airClos","contact","changePwd","Group 9370",
                          "aboutUs","termsCond","privacy","deleteAcc","logout"]
//
    var settingsLblAry = ["Notifications","My Profile","Account","Refer a friend",
                          "How Aircloset works?","Contact Support","Change Password",
                          "Contact Us","About Us","Terms and Conditions","Privacy Policy",
                          "Delete My Account", "Logout"]
    
//    var settingsImgAry = ["notification","account", "account", "referFrnd",
//                          "airClos","contact","changePwd",
//                          "aboutUs","termsCond","privacy","deleteAcc","logout"]
//
//    var settingsLblAry = ["Notifications","My Profile","Account","Refer a friend",
//                          "How Aircloset works?","Contact Support","Change Password",
//                          "About Us","Terms and Conditions","Privacy Policy",
//                          "Delete My Account", "Logout"]
    
    var selectedBtn = false
    var vwModel = AuthViewModel()
    
    //Mark:--> View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsTableVw.delegate = self
        settingsTableVw.dataSource = self
    }
    
    @objc func notificationStuts(sender:UIButton){
        sender.isSelected = !sender.isSelected
        let cell = settingsTableVw.cellForRow(at: IndexPath.init(row: 0, section: 0)) as! SettingsTVCell
        if cell.toggleBtn.isSelected {
            self.setData()
        }else {
            self.setData()
            
        }
    }
    
    func setData() {
        let notification = Store.userDetails?.body?.isNotification == 1 ? 0 : 1
        vwModel.isNotificationnApi(isNotification: notification)
        vwModel.onSuccess = {
            [weak self] in
            Store.userDetails?.body?.isNotification =  self?.vwModel.notificationStatusModel?.body?.isNotification ?? 0
        }
        
        
    }
    
    //Mark:--> Actions
    @IBAction func tapBackBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

//Mark:--> DelegatesDataSources
extension SettingsVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsLblAry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = settingsTableVw.dequeueReusableCell(withIdentifier: "SettingsTVCell", for: indexPath) as! SettingsTVCell
        cell.settingsImgVw.image = UIImage(named:settingsImgAry[indexPath.row])
        cell.settingsLbl.text = settingsLblAry[indexPath.row]
        cell.toggleBtn.isHidden  = true
        
        if indexPath.row == 0 {
            cell.toggleBtn.isHidden  = false
            cell.notifyNextBtn.isHidden = true
            
        } else if indexPath.row == 1 {
            cell.toggleBtn.isHidden  = true
            cell.notifyNextBtn.isHidden = false
        }
        
        if indexPath.row == 3{
            cell.referVw.isHidden  = false
        }else {
            cell.referVw.isHidden  = true
        }
        cell.toggleBtn.tag = indexPath.row
        cell.toggleBtn.addTarget(self, action: #selector(notificationStuts), for: .touchUpInside)
        
        switch  Store.userDetails?.body?.isNotification {
        case 1 :
            cell.toggleBtn.isSelected = true
        default:
            cell.toggleBtn.isSelected = false
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyProfileVC") as! MyProfileVC
            isTab = "IdVerificationAfterMyCloset"
            vc.comesFrom = "Profile"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        else if indexPath.row == 2 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AccountVC") as! AccountVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        else if indexPath.row == 3 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReferVC") as! ReferVC
            self.navigationController?.pushViewController(vc, animated: true)

        }
        
        else if indexPath.row == 4 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AirClosetWorksVC") as! AirClosetWorksVC
            vc.isComeFrom = 0
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        else if indexPath.row == 5 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AirClosetWorksVC") as! AirClosetWorksVC
            vc.isComeFrom = 1
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        else if indexPath.row == 6 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChangePwdVC") as! ChangePwdVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        else if indexPath.row == 7 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ContactUsVC") as! ContactUsVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        else if indexPath.row == 8 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AirClosetWorksVC") as! AirClosetWorksVC
            vc.isComeFrom = 2
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        else if indexPath.row == 9 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AirClosetWorksVC") as! AirClosetWorksVC
            vc.isComeFrom = 3
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        else if indexPath.row == 10 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AirClosetWorksVC") as! AirClosetWorksVC
            vc.isComeFrom = 4
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        else if indexPath.row == 11{
            let deleteAccountAlert = UIAlertController(title: "Delete Account", message: "Are you sure you want to Delete Account?", preferredStyle: UIAlertController.Style.alert)
            deleteAccountAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
                self.vwModel.deleteAccount(id: Store.userDetails?.body?.id ?? "")
                self.vwModel.onSuccess = { [weak self] in
                    let stry = UIStoryboard(name: "Main", bundle: nil)
                    Store.autoLogin = false
                    Store.userDetails = nil
                    Store.authKey = nil
                    Store.deviceToken = nil
                    userList2.removeAll()
                    SocketIOManager.sharedInstance.closeConnection()
                    SocketIOManager.sharedInstance.manager = SocketManager(socketURL: URL(string:SocketKeys.socketBaseUrl.instance)!, config: [.log(true),.compress,.extraHeaders(["authorization": Store.authKey ?? ""])])
                    SocketIOManager.sharedInstance.updateAuthToken("")
                    let vc = stry.instantiateViewController(identifier: "SignInVC") as! SignInVC
                    let nav1 = UINavigationController()
                    nav1.navigationBar.isHidden = true
                    nav1.viewControllers = [vc]
                    self!.view.window?.rootViewController = nav1
                }
            }))
            
            deleteAccountAlert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (action: UIAlertAction!) in
                deleteAccountAlert .dismiss(animated: true, completion: nil)
            }))
            present(deleteAccountAlert, animated: true, completion: nil)
            
        }
        
        else if indexPath.row == 12 {
            let deleteAccountAlert = UIAlertController(title: "Logout", message: "Are you sure you want to logout?", preferredStyle: UIAlertController.Style.alert)
            deleteAccountAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
                self.vwModel.logOutApi()
                self.vwModel.onSuccess = { [weak self] in
                    let stry = UIStoryboard(name: "Main", bundle: nil)
                    Store.autoLogin = false
                    Store.userDetails = nil
                    Store.authKey = nil
                    userList2.removeAll()
                    Store.deviceToken = nil
                    SocketIOManager.sharedInstance.updateAuthToken("")
                    let vc = stry.instantiateViewController(identifier: "SignInVC") as! SignInVC
                    let nav1 = UINavigationController()
                    nav1.navigationBar.isHidden = true
                    nav1.viewControllers = [vc]
                    self!.view.window?.rootViewController = nav1
                }
            }))
            
            deleteAccountAlert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (action: UIAlertAction!) in
                deleteAccountAlert .dismiss(animated: true, completion: nil)
            }))
            present(deleteAccountAlert, animated: true, completion: nil)
        }
    }
}
