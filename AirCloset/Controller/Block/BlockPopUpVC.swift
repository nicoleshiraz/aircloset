//
//  BlockPopUpVC.swift
//  AirCloset
//
//  Created by cql105 on 03/04/23.
//

import UIKit

//MARK: -> Protocol

protocol BlockProtocol{
    func removeBlockPop(address : Int)
}
class BlockPopUpVC: UIViewController {
    
    //MARK: -> Variables
    
    @IBOutlet weak var nameLbl: UILabel!
    
    var blockObj : BlockProtocol?
    var callBack: ((Bool)->())?
    var blockStatus = Bool()
    var name = String()
    
    override func viewDidLoad() {
        nameLbl.text = blockStatus == true ? "Are you sure you want to unblock \(name)" : "Are you sure you want to block \(name)"
        super.viewDidLoad()
    }
    
    //MARK: -> Actions
    
    @IBAction func tapYesBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: {
            self.callBack?(true)
            self.blockObj?.removeBlockPop(address: 1)
        })
    }
    
    @IBAction func tapNoBtn(_ sender: UIButton) {
        callBack?(false)
        self.dismiss(animated: true, completion: nil)
    }
}
