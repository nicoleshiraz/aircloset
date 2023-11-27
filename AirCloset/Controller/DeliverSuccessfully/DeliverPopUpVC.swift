//
//  DeliverPopUpVC.swift
//  AirCloset
//
//  Created by cql105 on 04/04/23.
//

import UIKit

//Mark:--> Protocol
protocol DeliverProtocol{
    func removeDeliverPop(address : Int)
}

class DeliverPopUpVC: UIViewController {
    //Mark:--> Outlets & Variables
    @IBOutlet weak var successfulLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var giveRateBtn: UIButton!
    @IBOutlet weak var successfullTop: NSLayoutConstraint!
    @IBOutlet weak var descLblTop: NSLayoutConstraint!
    var deliverObj : DeliverProtocol?
    var callBack: ((Int,String)->())?
    
    //Mark:--> View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        if isTab == "IdVerification" {
            successfulLbl.isHidden = true
            let str = NSAttributedString(string: "Give Rate & Review",attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue])
            giveRateBtn.setAttributedTitle(str, for: .normal)
            successfullTop.constant = 0
            descLblTop.constant = 0
        }
        else if isTab == "UploadProof"{
            successfulLbl.isHidden = false
            let str = NSAttributedString(string: "View Receipt",attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue])
            giveRateBtn.setAttributedTitle(str, for: .normal)
            descLbl.text = "Your payment has been done successfully"
         }
    }
    
    //Mark:--> Actions
    @IBAction func tapOkBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: {
//            let homeStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
//            let vc = homeStoryboard.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
//            selectedType = 1
//            vc.selectedIndex = 0
//            let nav = UINavigationController.init(rootViewController: vc)
//            nav.isNavigationBarHidden = true
//            UIApplication.shared.windows.first?.rootViewController = nav
            
            self.callBack?(1,"vvvvv")
            
//            if Store.userDetails?.body?.idVerification == 1 {
//                self.callBack?(1,"vvvvv")
//            } else {
//                self.deliverObj?.removeDeliverPop(address: 1)
//            }
        })
    }
    
    @IBAction func tapRateReviewBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: {
            if Store.userDetails?.body?.idVerification == 1 {
                self.callBack?(2,"vvvvv")
            } else {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewReceiptVC") as! ViewReceiptVC
                isTab = "ViewReceipt"
                self.navigationController?.pushViewController(vc, animated: false)
            }
        })
    }
}
