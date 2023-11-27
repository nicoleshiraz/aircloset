//
//  TermsPopUp.swift
//  AirCloset
//
//  Created by cqlios3 on 20/09/23.
//

import UIKit
import Foundation
import IQKeyboardManagerSwift

class TermsPopUp : UIViewController {
    
    @IBOutlet weak var txtTerms: IQTextView!
    var vwModel = AuthViewModel()
    
    var comesFrom = String()
    var termsData = String()
    
    //------------------------------------------------------
    
    //MARK: Memory Management Method
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //------------------------------------------------------
    
    //MARK: Custome
    
    func setData() {
        if comesFrom == "Terms" {
            self.txtTerms.text = termsData
        } else {
            getProfileInfoApi()
        }
        txtTerms.isEditable = false
    }
    
    //MARK: - Api Func
    func getProfileInfoApi(){
        vwModel.getProfileDetailapi()
        vwModel.onSuccess = { [weak self]  in
            Singletone.shared.clothsTermsAndCon = self?.vwModel.profileModel?.body?.termAndCondition ?? ""
            if self?.vwModel.profileModel?.body?.termAndCondition ?? "" == "" {
                self?.txtTerms.placeholder = "No terms and condition added."
            } else {
                self?.txtTerms.text = Singletone.shared.clothsTermsAndCon
            }

        }
    }
    
    //------------------------------------------------------
    
    deinit { //same like dealloc in ObjectiveC
        
    }
    
    //------------------------------------------------------
    
    //MARK: Action
    
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    //------------------------------------------------------
    
    //MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
    }
    
    //------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //------------------------------------------------------
}
