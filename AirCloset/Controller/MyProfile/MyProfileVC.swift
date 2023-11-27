//
//  MyProfileVC.swift
//  AirCloset
//
//  Created by cqlnitin on 15/04/23.
//

import UIKit
import SwiftMessages
import SDWebImage

class MyProfileVC: UIViewController {

    @IBOutlet weak var lblTerms: UILabel!
    @IBOutlet weak var idVerificationBtn: UIButton!
    @IBOutlet weak var verifiedImgVw: UIImageView!
    @IBOutlet weak var editprofileBtn: UIButton!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var nameTxtFld: UITextField!
    @IBOutlet weak var emailTxtFld: UITextField!
    @IBOutlet weak var cntryCodeLbl: UILabel!
    @IBOutlet weak var phoneNumberTxtFLd: UITextField!
    @IBOutlet weak var bioDescLbl: UILabel!
    var vwModel = AuthViewModel()
    var comesFrom = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false

        if isTab == "IdVerificationAfterCheckOut"{
            //idVerificationBtn.setTitle("ID Verification", for: .normal)
           // verifiedImgVw.isHidden = true
            editprofileBtn.isHidden = true
            getProfileInfoApi()
        }
        else if isTab == "IdVerificationAfterMyCloset"{
           // idVerificationBtn.setTitle("", for: .normal)
            //idVerificationBtn.setTitle("ID Verification", for: .normal)
            //verifiedImgVw.isHidden = true
//            verifiedImgVw.isHidden = false
            editprofileBtn.isHidden = false
            getProfileInfoApi()
        }
    }
    
    //MARK: - Api Func
    func getProfileInfoApi(){
        vwModel.getProfileDetailapi()
        vwModel.onSuccess = { [weak self]  in
            
            self?.profileImg.sd_setImage(with: URL.init(string: imageURL + (self?.vwModel.profileModel?.body?.image ?? "")), placeholderImage: UIImage(named: "profileIcon"))
            self?.nameTxtFld.text = self?.vwModel.profileModel?.body?.name ?? ""
            self?.emailTxtFld.text = self?.vwModel.profileModel?.body?.email ?? ""
            self?.cntryCodeLbl.text = self?.vwModel.profileModel?.body?.countryCode ?? ""
            self?.phoneNumberTxtFLd.text = "\(self?.vwModel.profileModel?.body?.phoneNumber ?? 0)"
            self?.lblTerms.text = self?.vwModel.profileModel?.body?.termAndCondition ?? ""
            self?.bioDescLbl.text = self?.vwModel.profileModel?.body?.bio ?? ""
            if self?.vwModel.profileModel?.body?.idVerification == 1 {
                self?.verifiedImgVw.isHidden = false
                self?.idVerificationBtn.setTitle("", for: .normal)

            }else{
                self?.idVerificationBtn.setTitle("ID Verification", for: .normal)

                self?.verifiedImgVw.isHidden = true
            }
            NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: nil, userInfo: nil)
            print(Store.userDetails?.body?.idVerification)
        }
    }

    //Mark:--> Actions
    @IBAction func tapBackBtn(_ sender: UIButton) {
        if comesFrom != "Profile" {
            isTab = "ComingFromEnterDetails"
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapEditProfileBtn(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EditProfileVC") as! EditProfileVC
        vc.profileModel = vwModel.profileModel
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func viewProfilePicBtnTapped(_ sender: UIButton) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "ViewProfileImgVC") as! ViewProfileImgVC
        vc.profileImg = profileImg.image
        navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func tapIdVerificationBtn(_ sender: UIButton) {
        if self.vwModel.profileModel?.body?.idVerification != 1 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "UploadProofVC") as! UploadProofVC
            vc.comesFrom = comesFrom
            vc.callBack = { [self] in
                getProfileInfoApi()
            }
            isTab = "IdVerification"
            comesFromGlobal = "Verify"
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

}
