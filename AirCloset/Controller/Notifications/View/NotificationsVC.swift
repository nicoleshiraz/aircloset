//
//  NotificationsVC.swift
//  AirCloset
//
//  Created by cql105 on 04/04/23.
//

import UIKit

class NotificationsVC: UIViewController {
    
    //MARK: -> Outlets & Variables
    
    @IBOutlet weak var notTableVw: UITableView!
    
    var notificationVM = NotificationVM()
    var notTitleAry = ["John Marker","Robert","Rubika Maker"]
    var notDescAry = ["You have to deliver Ladies Top today is delivery date.",
                      "Your request has been submmited successfully",
                      "You have received booking request for this product."]
    
    //MARK: -> View Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notTableVw.delegate = self
        notTableVw.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        notTableVw.separatorStyle = .none
        getNotification()
    }
}

//MARK: -> DelegatesDatasource

extension NotificationsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notTableVw.setEmptyData(msg: "No data found.", rowCount: notificationVM.notifData?.count ?? 0)
        return notificationVM.notifData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = notTableVw.dequeueReusableCell(withIdentifier: "NotificationsTVCell", for: indexPath) as! NotificationsTVCell
        if notificationVM.notifData?.count ?? 0 > 0 {
            cell.notifData(notifData: (notificationVM.notifData?[indexPath.row])!)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReturnBookingDetailsVC") as! ReturnBookingDetailsVC
//        isTab = "Notification"
//        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: -> Api Call

extension NotificationsVC {
    
    private func getNotification() {
        notificationVM.getNotif {
            self.notTableVw.reloadData()
        }
    }
    
}
