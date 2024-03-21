//
//  ViewProofImage.swift
//  AirCloset
//
//  Created by cqlios3 on 16/10/23.
//

import UIKit
import SDWebImage
import Foundation

class ViewProofImage : UIViewController {
    
    @IBOutlet weak var btnStackVerify: UIStackView!
    @IBOutlet weak var showImage: UIImageView!
    @IBOutlet weak var btnHeight: NSLayoutConstraint!
    
    var proofImage = String()
    var vwModel = ProductVwModel()
    var orderIDd = String()
    var status = String()
    var callBack: (()->())?
        
    //------------------------------------------------------
    
    //MARK: Memory Management Method
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //------------------------------------------------------
    
    deinit { //same like dealloc in ObjectiveC
        
    }
    
    //------------------------------------------------------
    
    //MARK: Action
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func btnProof(_ sender: Any) {
        
        let deleteAccountAlert = UIAlertController(title: "Return Proof", message: "Can you confirm that the returned closet is in excellent condition?", preferredStyle: UIAlertController.Style.alert)
        deleteAccountAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { [self] (action: UIAlertAction!) in
            returnProofCloth(pickupParams: ["orderId":orderIDd,"type":1]) {
                self.dismiss(animated: true) {
                    self.callBack?()
                }
            }
        }))
        
        deleteAccountAlert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { [self] (action: UIAlertAction!) in
            deleteAccountAlert .dismiss(animated: true, completion: nil)
            returnProofCloth(pickupParams: ["orderId":orderIDd,"type":2]) {
                self.dismiss(animated: true) {
                    self.callBack?()
                }
            }
        }))
        present(deleteAccountAlert, animated: true, completion: nil)
        

    }
    //------------------------------------------------------
    
    //MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isTab == "AirClosetOrders" {
            btnStackVerify.isHidden = true
            btnHeight.constant = 0
        } else {
            if status == "0" {
                btnHeight.constant = 50
                btnStackVerify.isHidden = false
            } else {
                btnHeight.constant = 0
                btnStackVerify.isHidden = true
            }
        }
        showImage.sd_setImage(with: URL.init(string: proofImage),placeholderImage: UIImage(named: "iconPlaceHolder"))
    }
    
    //------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //------------------------------------------------------
}


extension ViewProofImage {
    
    private func returnProofCloth(pickupParams: [String:Any], onSuccessApi: @escaping (()->())) {
        vwModel.returnProofCloth(paramss: pickupParams) { [self] in
            onSuccessApi()
        }
    }
    
}
