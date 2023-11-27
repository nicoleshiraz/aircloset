//
//  UnblockPopUpVC.swift
//  AirCloset
//
//  Created by cql105 on 26/04/23.
//

import UIKit

class UnblockPopUpVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    @IBAction func tapYesBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapNoBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
