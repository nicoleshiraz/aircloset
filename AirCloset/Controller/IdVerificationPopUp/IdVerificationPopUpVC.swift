//
//  IdVerificationPopUpVC.swift
//  AirCloset
//
//  Created by cql105 on 05/04/23.
//

import UIKit
//Mark:--> Protocol
protocol IdVerificationProtocol{
    func removeVerificationPop(address : Int)
}
class IdVerificationPopUpVC: UIViewController {
    //Mark:--> Variables
    var verifyObj : IdVerificationProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //Mark:--> Actions
    @IBAction func tapIdVerificationBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: {
            self.verifyObj?.removeVerificationPop(address: 1)
        })
    }
}
