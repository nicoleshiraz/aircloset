//
//  AccountVC.swift
//  AirCloset
//
//  Created by cqlnitin on 14/04/23.
//

import UIKit

class AccountVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //------------------------------------------------------
    
    //MARK: Actions
    
    @IBAction func tapBackBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnTerms(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AirClosetWorksVC") as! AirClosetWorksVC
        vc.isComeFrom = 3
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tapGetStartedBtn(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SettingsVC") as! SettingsVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
}
