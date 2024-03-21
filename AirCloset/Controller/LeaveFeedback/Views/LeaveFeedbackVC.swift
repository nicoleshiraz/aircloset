//
//  LeaveFeedbackVC.swift
//  AirCloset
//
//  Created by cql105 on 04/04/23.
//

import UIKit
import Cosmos
import IQKeyboardManagerSwift

class LeaveFeedbackVC: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var desLbl: UILabel!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var feedBackTxtVw: IQTextView!
    @IBOutlet weak var feedbackView: CustomView!
    
    var rateVM = FeedbackViewModel()
    var bookingID = String()
    var userDetails: ErID?
    var productId = String()
    var feedbackStatus = Int()
    var userID = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        feedBackTxtVw.delegate = self
        
        if isTab == "FromReturn" {
            setup()
        } else {
            if feedbackStatus == 1 {
                getRatting(paramss: ["productId": productId])
            }
        }
        getDetailss(sellerParam: ["id": userID])
        ratingView.rating = 0
    }
        
    func setup() {
        userImage.roundedImage()
        userImage.imageLoad(imageUrl: "\(imageURL)\(userDetails?.image ?? "")")
        userNameLbl.text = userDetails?.name ?? ""
    }
    
//    func textViewDidBeginEditing(_ textView: UITextView) {
//        if feedBackTxtVw.text == "Type.." {
//            feedBackTxtVw.text = ""
//        } else {
//
//        }
//    }
    
    
    //MARK: -> Actions
    
    @IBAction func tapBackBtn(_ sender: UIButton) {
        listUpdateCallBack?()
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapGvFeedBackBtn(_ sender: UIButton) {
        
        if feedBackTxtVw.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            CommonUtilities.shared.showSwiftAlert(message: "Please add feedback review.", isSuccess: .error)
        } else {
            createRate(rateParam: ["rating": ratingView.rating,"message": feedBackTxtVw.text ?? "","productId":productId,"review":"","orderId": bookingID])
        }
    }
}

extension LeaveFeedbackVC {
    
    private func createRate(rateParam: [String:Any]) {
        rateVM.addRating(params: rateParam) {
            if isTab == "ComingFromReturnPolicy" || isTab == "AirClosetOrders"{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
                vc.selectedIndex = 2
                self.navigationController?.pushViewController(vc, animated: false)
            } else if isTab == "GiveRate&ReviewAfterReceived" {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
                vc.selectedIndex = 4
                self.navigationController?.pushViewController(vc, animated: false)
            }else if isTab == "Notification" {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
                vc.selectedIndex = 3
                self.navigationController?.pushViewController(vc, animated: false)
            }else{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
                vc.selectedIndex = 2
                self.navigationController?.pushViewController(vc, animated: false)
            }
        }
    }
    
    private func getDetailss(sellerParam: [String:Any]) {
        rateVM.getdetails(params: sellerParam) { [weak self] in
            self?.userImage.roundedImage()
            self?.userImage.imageLoad(imageUrl: "\(imageURL)\(self?.rateVM.sellerProfileNew?.image ?? "")")
            self?.userNameLbl.text = self?.rateVM.sellerProfileNew?.name ?? ""
        }
    }
    
    private func getRatting(paramss: [String:Any]) {
        rateVM.getRatting(params: paramss) {
            if self.rateVM.ratingData?.count ?? 0 > 0 {
                self.feedbackView.isHidden = true
                self.ratingView.rating = Double(self.rateVM.ratingData?.first?.rating ?? 0) ?? 0.0
                self.feedBackTxtVw.text = self.rateVM.ratingData?.first?.message ?? ""
            }
        }
    }
    
}

