//
//  EditProfileVC.swift
//  AirCloset
//
//  Created by cqlnitin on 15/04/23.
//

import UIKit
import IQKeyboardManagerSwift
import CountryPickerView

var updateProfileData: (()->())?

class EditProfileVC: UIViewController, UITextViewDelegate {
    //Mark:--> Outlets
    @IBOutlet weak var editProfileImgVw: UIImageView!
    @IBOutlet weak var nameTxtFld: UITextField!
    @IBOutlet weak var emailTxtFld: UITextField!
    @IBOutlet weak var phoneNoTxtFld: UITextField!
    @IBOutlet weak var bioDescrpTxtVw: UITextView!
    @IBOutlet weak var btnTermsOutlet: UIButton!
    @IBOutlet weak var cntryCdLbl: UILabel!
    
    var countryPickerView = CountryPickerView()
    var profileModel : MyProfileAndEditProfileModel?
    var vmModel = AuthViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countryPickerView.delegate = self
        editProfileImgVw.layer.cornerRadius = 89
        //bioDescrpTxtVw.delegate = self
        bioDescrpTxtVw.delegate = self
        setProfileDATa()
    }
    
    func setProfileDATa(){
        editProfileImgVw.sd_setImage(with: URL.init(string: imageURL + (profileModel?.body?.image ?? "")), placeholderImage: UIImage(named: "profileIcon"))
        nameTxtFld.text = profileModel?.body?.name
        emailTxtFld.text = profileModel?.body?.email
        phoneNoTxtFld.text = "\(String(describing: profileModel?.body?.phoneNumber ?? 0))"
        bioDescrpTxtVw.text = profileModel?.body?.bio
        cntryCdLbl.text = profileModel?.body?.countryCode
        Singletone.shared.clothsTermsAndCon = profileModel?.body?.termAndCondition ?? ""
        }
    
    //Mark:--> Actions
    @IBAction func tapBackBtn(_ sender: UIButton) {
        Singletone.shared.clothsTermsAndCon = nil
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapCameraBtn(_ sender: UIButton) {
        ImagePickerManager().pickImage(self) { (image) in
            self.editProfileImgVw.image = image
        }
    }

    @IBAction func btnTerms(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TermsConditionsVC") as! TermsConditionsVC
        vc.type = "post"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func viewProfilePicBtnTapped(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ViewProfileImgVC") as! ViewProfileImgVC
        vc.profileImg = editProfileImgVw.image
        navigationController?.pushViewController(vc, animated: true)

    }
    
    @IBAction func cntryCdBtnTapped(_ sender: UIButton) {
        countryPickerView.showCountriesList(from: self)
        
    }
    
    @IBAction func tapUpdateProfileBtn(_ sender: UIButton) {
        if CheckValidation.checkEditProfile(name: nameTxtFld, phoneno: phoneNoTxtFld, terms: Singletone.shared.clothsTermsAndCon ?? ""){
            vmModel.editProfileApi(name: nameTxtFld.text ?? "", phoneNumber: phoneNoTxtFld.text ?? "", imagee: editProfileImgVw,  bio: bioDescrpTxtVw.text ?? "", terms: Singletone.shared.clothsTermsAndCon ?? "")
            vmModel.onSuccess = { [weak self] in
                Singletone.shared.clothsTermsAndCon = nil
                updateProfileData?()
                NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: nil, userInfo: nil)
                let vc = self?.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
                vc.selectedIndex = 4
                self?.navigationController?.pushViewController(vc, animated: false)
            }
        }
    }
}

extension EditProfileVC: CountryPickerViewDelegate {
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        self.cntryCdLbl.text = country.phoneCode
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let rangeOfTextToReplace = Range(range, in: textView.text) else {
            return false
        }
        let substringToReplace = textView.text[rangeOfTextToReplace]
        let count = textView.text.count - substringToReplace.count + text.count
        return count <= 250
    }
}


