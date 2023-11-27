//
//  DeletePopUpVC.swift
//  AirCloset
//
//  Created by cqlnitin on 14/04/23.
//

import UIKit
//Mark:--> Protocol
protocol DeleteProtocol{
    func removeDeletePop(address : Bool)
}
class DeletePopUpVC: UIViewController {
    //Mark:--> Variables
    var deleteObj : DeleteProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Mark:--> Actions
    @IBAction func tapYesBtn(_ sender: UIButton) {
        deleteObj?.removeDeletePop(address: true)
       // deleteObj?.removeDeletePop(address: <#T##Int#>)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapNoBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
