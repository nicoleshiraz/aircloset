//
//  SignUpVC.swift
//  AirCloset
//
//  Created by cql105 on 31/03/23.
//

import UIKit
import CountryPickerView

class SignUpVC: UIViewController,UITextFieldDelegate{
    
   //Mark:--> Outlets
    
    @IBOutlet weak var txtRefferal: UITextField!
    @IBOutlet weak var signUpVw: UIView!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var countryCodeTF: UITextField!
    @IBOutlet weak var countryCodeBtn: UIButton!
    @IBOutlet weak var pwdTF: UITextField!
    @IBOutlet weak var confirmPwdTF: UITextField!
    @IBOutlet weak var signUpImgVw: UIImageView!
    var countryPickerView = CountryPickerView()
    var signUpVwModel = AuthViewModel()
    
    var userLat : Double?
    var userLong : Double?
    
    //Mark :--> View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        countryPickerView.delegate = self
        signUpVw.layer.cornerRadius = 50
        signUpVw.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
  //      phoneTF.delegate = self
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        let attributedPlaceholder = NSAttributedString(string: "+61", attributes: attributes)
        countryCodeTF.attributedPlaceholder = attributedPlaceholder
 
    }
 
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//           if let pasteboardString = UIPasteboard.general.string, string.isEmpty {
//               // Only allow typed text, not pasted text
//               return true
//           }
//           return false
//       }

    //Mark:--> Actions
    @IBAction func tapBackBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func eyeBtnTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
       
       if sender.isSelected {
           pwdTF.isSecureTextEntry = false
       }
       else{
           pwdTF.isSecureTextEntry = true
       }
    }
    
    @IBAction func cnfrmEyeBtnTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
       
       if sender.isSelected {
           confirmPwdTF.isSecureTextEntry = false
       }
       else{
           confirmPwdTF.isSecureTextEntry = true
       }
        
    }
    
    @IBAction func tapCamSignUpBtn(_ sender: UIButton) {
        ImagePickerManager().pickImage(self) { (image) in
            self.signUpImgVw.image = image
        }
    }
    
    @IBAction func tapCountryBtn(_ sender: UIButton) {
        countryPickerView.showCountriesList(from: self)
    }
    
    @IBAction func tapNextBtn(_ sender: UIButton) {
        if CheckValidation.checkSignUpDetails(profileImg: signUpImgVw, name: nameTF, email: emailTF, countryCd: countryCodeTF, phoneNumber: phoneTF, password: pwdTF, confirmPassword: confirmPwdTF, role: 1){

            signUpVwModel.signUpApi(img: signUpImgVw, name: nameTF.text ?? "", email: emailTF.text ?? "", countryCode: countryCodeTF.text ?? "", phoneNumber: phoneTF.text ?? "", password: pwdTF.text ?? "", role: 1,latitude: "\(Store.lat ?? 0.0)", longitude: "\(Store.long ?? 0.0)",deviceTokenn: DeviceToken ,deviceTypee: "2", referal: txtRefferal.text ?? "")
                signUpVwModel.onSuccess = { [weak self] in
                    if !SocketIOManager.sharedInstance.isConnected(){
                        SocketIOManager.sharedInstance.updateAuthToken(Store.authKey ?? "")
                        SocketIOManager.sharedInstance.establishConnection()
                    }
                    let vc = self?.storyboard?.instantiateViewController(withIdentifier: "VerificationVC") as! VerificationVC
                    self?.navigationController?.pushViewController(vc, animated: true)
                    CommonUtilities.shared.showSwiftAlert(message: "Use 1111 as a static OTP", isSuccess: .success)
                }
        }
    }
    
    @IBAction func tap_SignInBtn(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK:-->  DelegateDataSources
extension SignUpVC: CountryPickerViewDelegate {
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        let title = "Selected Country"
        let message = "Name: \(country.name) \nCode: \(country.code) \nPhone: \(country.phoneCode) \nPhone: \(country.flag)"
        self.countryCodeTF.text = country.phoneCode
    }
}
