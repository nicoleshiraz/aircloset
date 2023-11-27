//
//  ContactUsVC.swift
//  AirCloset
//
//  Created by cqlios3 on 13/09/23.
//

import UIKit
import Foundation
import CountryPickerView
import IQKeyboardManagerSwift

class ContactUsVC : UIViewController, UICollectionViewDelegate , UICollectionViewDataSource {
    
    //------------------------------------------------------
    
    //MARK: Varibles and outlets
    
    @IBOutlet weak var lblCountryCode: UILabel!
    @IBOutlet weak var txtVwMessagew: IQTextView!
    @IBOutlet weak var txtMessage: UITextField!
    @IBOutlet weak var txtSubject: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var tblAttachment: UICollectionView!
    
    var showImage = ["Group 9417"]
//    var showImage = ["upload"]
    var arrImageUpload = [imageUpload]()
    var viewModel = ContactVM()
    var finalArr = [UIImage]()
    var countryPickerView = CountryPickerView()
    var comesFrom = String()
    
    //------------------------------------------------------
    
    //MARK: Memory Management Method
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //------------------------------------------------------
    
    deinit { //same like dealloc in ObjectiveC
        
    }
    
    //------------------------------------------------------
    
    //MARK: Actions
    
    @IBAction func btnBack(_ sender: UIButton) {
        if comesFrom == "ViewRecipet" {
            self.navigationController?.popViewController(animated: true)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func btnCountryPicker(_ sender: UIButton) {
        countryPickerView.showCountriesList(from: self)
    }
    
    @IBAction func btnSave(_ sender: UIButton) {
        
        if txtName.text?.isBlank == true {
            CommonUtilities.shared.showSwiftAlert(message: "Please enter name.", isSuccess: .error)
        } else if txtEmail.text?.isBlank == true {
            CommonUtilities.shared.showSwiftAlert(message: "Please enter email.", isSuccess: .error)
        } else if txtEmail.text?.isValidEmail == false{
            CommonUtilities.shared.showSwiftAlert(message: "Please enter a valid Email ID", isSuccess: .error)
        }  else if lblCountryCode.text?.isBlank == true {
            CommonUtilities.shared.showSwiftAlert(message: "Please select country code.", isSuccess: .error)
        } else if txtPhone.text?.isBlank == true {
            CommonUtilities.shared.showSwiftAlert(message: "Please enter phone number.", isSuccess: .error)
        } else if txtPhone.text?.count ?? 0 < 7 || txtPhone.text?.count ?? 0 > 16 {
            CommonUtilities.shared.showSwiftAlert(message: "Please enter your valid number", isSuccess: .error)
        } else if txtSubject.text?.isBlank == true {
            CommonUtilities.shared.showSwiftAlert(message: "Please enter subject.", isSuccess: .error)
        } else if txtVwMessagew.text?.isBlank == true {
            CommonUtilities.shared.showSwiftAlert(message: "Please enter message.", isSuccess: .error)
        } else if arrImageUpload.count == 0 {
            CommonUtilities.shared.showSwiftAlert(message: "Please add attachment.", isSuccess: .error)
        } else {
            finalArr.removeAll()
            for i in 0..<arrImageUpload.count {
                if (!arrImageUpload[i].image.isEqualToImage(image:UIImage(named: "Rectangle 17779")!)) {
                    self.finalArr.append(arrImageUpload[i].image)
                }
            }
            let imageViews = finalArr.map { UIImageView(image: $0) }
            addFormDetails(contactParam: ["message":txtVwMessagew.text ?? "","name":txtName.text ?? "","email":txtEmail.text ?? "","phone":"\(lblCountryCode.text ?? "")\(txtPhone.text ?? "")","company":"","website": "","subject":txtSubject.text ?? "","image":imageViews])
        }
    }
    
    func verifyUrl(urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = URL(string: urlString) {
                return UIApplication.shared.canOpenURL(url)
            }
        }
        return false
    }
    
    //------------------------------------------------------
    
    //MARK: Collection View delegate and datasource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (arrImageUpload.count) + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AttachmentImages", for: indexPath) as! AttachmentImages
        if indexPath.row == 0{
            cell.imageAdd.image = UIImage(named: showImage[indexPath.row])
            cell.btnDelete.isHidden = true
            cell.imageAdd.layer.cornerRadius = 10
            cell.cmaeraImage.isHidden = true
            cell.imgView.layer.cornerRadius = 10
        }else{
            let image = arrImageUpload[indexPath.row - 1].image
            cell.imageAdd.image = image
            cell.cmaeraImage.isHidden = true
            cell.btnDelete.tag = indexPath.row - 1
            cell.btnDelete.isHidden = false
            cell.imgView.layer.cornerRadius = 10
            cell.imageAdd.layer.cornerRadius = 10
            cell.btnDelete.addTarget(self, action: #selector(deleteImgBtnTapped(sender:)), for: .touchUpInside)
        }
        return cell
    }
    
    //MARK: -> Custom Function DropDown
    @objc func deleteImgBtnTapped(sender : UIButton){
        arrImageUpload.remove(at: sender.tag)
        tblAttachment.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if self.arrImageUpload.count > 5 {
                CommonUtilities.shared.showSwiftAlert(message: "You can add only 5 images.", isSuccess: .error)
            } else {
                ImagePickerManager().pickImage(self) { image in
                    self.arrImageUpload.append(imageUpload(image: image))
                    self.tblAttachment.reloadData()
                }
            }
        }
    }
    
    //------------------------------------------------------
    
    //MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countryPickerView.delegate = self
    }
    
    //------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //------------------------------------------------------
}

extension ContactUsVC {
    
    private func addFormDetails(contactParam: [String:Any]) {
        viewModel.addDetails(params: contactParam) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}


class AttachmentImages : UICollectionViewCell {
    
    @IBOutlet weak var imgView: CustomView!
    @IBOutlet weak var imageAdd: UIImageView!
    @IBOutlet weak var cmaeraImage: UIImageView!
    @IBOutlet weak var btnDelete: UIButton!
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(imageUrl: UIImage?) {
        imageAdd.image = imageUrl
    }
    
}

//------------------------------------------------------

//MARK: DelegateDataSources

extension ContactUsVC: CountryPickerViewDelegate {
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        let title = "Selected Country"
        let message = "Name: \(country.name) \nCode: \(country.code) \nPhone: \(country.phoneCode) \nPhone: \(country.flag)"
        self.lblCountryCode.text = country.phoneCode
    }
}
