//
//  VerificationVC.swift
//  AirCloset
//
//  Created by cql105 on 31/03/23.
//

import UIKit

class VerificationVC: UIViewController {
    
    //Mark:--> Outlets
    @IBOutlet weak var verifyVw: UIView!
    @IBOutlet weak var firstTF: UITextField!
    @IBOutlet weak var secondTF: UITextField!
    @IBOutlet weak var thirdTF: UITextField!
    @IBOutlet weak var fourthTF: UITextField!
    @IBOutlet weak var emailIdLbl: UILabel!
    
    var vwModel = AuthViewModel()
   
    //Mark :--> View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        firstTF.delegate = self
        secondTF.delegate = self
        thirdTF.delegate = self
        fourthTF.delegate = self
       // textFieldTargetAction()
        verifyVw.layer.cornerRadius = 50
        verifyVw.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        Store.newAccount = true
        Store.newAccountPopUp = true
        emailIdLbl.text = Store.userDetails?.body?.email
    }
    
    //Mark:--> Actions
    @IBAction func tapBackBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapVerifyBtn(_ sender: UIButton) {
        
        let otp = "\(firstTF.text ?? "")\(secondTF.text ?? "")\(thirdTF.text ?? "")\(fourthTF.text ?? "")"
        if CheckValidation.checkingOtpVerification(otp: otp) {
            vwModel.otpVerifyApi(phoneNumber:"\(Store.userDetails?.body?.phoneNumber ?? 0)" , otp: otp)
            vwModel.onSuccess = { [weak self] in

                let vc = self?.storyboard?.instantiateViewController(identifier: "TabBarVC") as! TabBarVC
                Store.autoLogin = true
                SocketIOManager.sharedInstance.updateAuthToken("")
                let nav1 = UINavigationController()
                            nav1.navigationBar.isHidden = true
                            nav1.viewControllers = [vc]
                self?.view.window?.rootViewController = nav1
                

//                let vc = self?.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
//                self?.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    @IBAction func sendAgainBtnTapped(_ sender: UIButton) {
        vwModel.resendOtp(phoneNo: "\(Store.userDetails?.body?.phoneNumber ?? 0)")
        vwModel.onSuccess = { [weak self] in
           
        }
    }
}

//Mark:--> Delegates
extension VerificationVC : UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range:NSRange, replacementString string: String) -> Bool {
        // Range.length == 1 means,clicking backspace
        if (range.length == 0){
            if textField == firstTF {
                secondTF?.becomeFirstResponder()
            }
            if textField == secondTF {
                thirdTF?.becomeFirstResponder()
            }
            if textField == thirdTF {
                fourthTF?.becomeFirstResponder()
            }
            if textField == fourthTF {
                fourthTF?.resignFirstResponder()
                       }
            textField.text? = string
            return false
        }else if (range.length == 1) {
            
            if textField == fourthTF {
                thirdTF?.becomeFirstResponder()
            }
            if textField == thirdTF {
                secondTF?.becomeFirstResponder()
            }
            if textField == secondTF {
                firstTF?.becomeFirstResponder()
            }
            if textField == firstTF {
                firstTF?.resignFirstResponder()
            }
            textField.text? = ""
            return false
        }
        return true
    }
    
}
