//
//  TransactionPopUpVC.swift
//  AirCloset
//
//  Created by cqlnitin on 14/04/23.
//

import UIKit

//MARK: -> Protocol

protocol TransactionProtocol{
    func removeTransactionPop(address : Int)
}

class TransactionPopUpVC: UIViewController {
    
    //MARK: -> Outlets & Variables
    
    @IBOutlet weak var transLbl: UILabel!
    
    var transObj : TransactionProtocol?
    var callBack: (()->())?
    var ammount = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isTab == "Transaction" {
            transLbl.text = "Your withdrawal request as been sent. Please allow 24-48 hours for funds to arrive into your account."
        } else if isTab == "Wallet"{
            transLbl.text = "You have added successfully $\(ammount) in your wallet."
        }
    }
    
    //MARK: -> Actions
    
    @IBAction func tapOkBtn(_ sender: UIButton) {
        callBack?()
        self.dismiss(animated: true, completion: {
        })
    }
}
