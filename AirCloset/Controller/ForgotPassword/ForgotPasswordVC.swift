//
//  ForgotPasswordVC.swift
//  AirCloset
//
//  Created by cql105 on 31/03/23.
//

import UIKit

class ForgotPasswordVC: UIViewController {
    
    //Mark:--> Outlets
    @IBOutlet weak var frgPwdVw: UIView!
    @IBOutlet weak var emailTxtFld: UITextField!
    var vwModel = AuthViewModel()
    
    //Mark :--> View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        frgPwdVw.layer.cornerRadius = 50
        frgPwdVw.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    //Mark:--> Actions
    @IBAction func tapBackBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapSubmitBtn(_ sender: UIButton) {
        if CheckValidation.checkforgotPassEmail(email: emailTxtFld){
            vwModel.forgotPassApi(email: emailTxtFld.text ?? "")
            vwModel.onSuccess = { [weak self] in
                let vc = self?.storyboard?.instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
                self?.navigationController?.pushViewController(vc, animated: false)
            }
        }
    }
}
