//
//  CancelBuyingPopUpVC.swift
//  AirCloset
//
//  Created by cql105 on 24/04/23.
//

import UIKit
//Mark:--> Protocol
protocol CancelBuyingProtocol{
    func removeCancelPop(address : Int)
}
class CancelBuyingPopUpVC: UIViewController {
    //Mark:--> Variables
    var removeCancelObj : CancelBuyingProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
 //Mark:--> Actions
    @IBAction func tapYesBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: {
            self.removeCancelObj?.removeCancelPop(address: 1)
        })
    }
    
    @IBAction func tapNoBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
