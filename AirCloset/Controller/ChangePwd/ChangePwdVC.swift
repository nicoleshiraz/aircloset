//
//  ChangePwdVC.swift
//  AirCloset
//
//  Created by cqlnitin on 13/04/23.
//

import UIKit

class ChangePwdVC: UIViewController {
    
    //Mark:--> Outlets
    @IBOutlet weak var oldPwdTF: UITextField!
    @IBOutlet weak var newPwdTF: UITextField!
    @IBOutlet weak var confirmPwdTF: UITextField!
    
    var vwModel = AuthViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Mark:--> Actions
    @IBAction func tapBackBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func oldPassEyeBtnTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
       
       if sender.isSelected {
           oldPwdTF.isSecureTextEntry = false
       }
       else{
           oldPwdTF.isSecureTextEntry = true
       }

        
    }
    
    @IBAction func newPassEyeBtnTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
       
       if sender.isSelected {
           newPwdTF.isSecureTextEntry = false
       }
       else{
           newPwdTF.isSecureTextEntry = true
       }

    }
    

    @IBAction func cnfrmPassEyeBtnTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
       
       if sender.isSelected {
           confirmPwdTF.isSecureTextEntry = false
       }
       else{
           confirmPwdTF.isSecureTextEntry = true
       }

        
        
    }
    
    @IBAction func tapSubmitBtn(_ sender: UIButton) {
        
        if CheckValidation.checkChangePass(oldPassword: oldPwdTF, newPassword: newPwdTF, confirmPassword: confirmPwdTF){
            vwModel.changePassApi(oldPass: oldPwdTF.text ?? " ", newPass: newPwdTF.text ?? " ", confirmPass: confirmPwdTF.text ?? " ")
            vwModel.onSuccess = { [weak self] in
                let vc = self?.storyboard?.instantiateViewController(withIdentifier: "SettingsVC") as! SettingsVC
                self?.navigationController?.pushViewController(vc, animated: false)
                
            }
        }
       
    }
}
