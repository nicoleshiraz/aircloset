//
//  UploadProofVC.swift
//  AirCloset
//
//  Created by cql105 on 04/04/23.
//

import UIKit

var comesFromGlobal = String()

class UploadProofVC: UIViewController {
    
    //MARK: -> Outlets
    
    @IBOutlet weak var uploadImgVw: UIImageView!
    @IBOutlet weak var uploadProofLbl: UILabel!
    @IBOutlet weak var idVerificationLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var proofLbl: UILabel!
    @IBOutlet weak var cameraImgVw: UIImageView!
    @IBOutlet weak var uploadBtn: UIButton!
    @IBOutlet weak var uploadProofTop: NSLayoutConstraint!
    @IBOutlet weak var descLblTop: NSLayoutConstraint!
    
    var cardListVwModel = AddNewCardvwModel()
    var vwModell = ProductVwModel()
    var comesFrom = String()
    var profileImage = UIImage()
    var callBack: (()->())?
    var orderID = String()
    
    
    //MARK: -> View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        if Store.userDetails?.body?.idVerification == 1 {
            if isTab != "Return" {
                idVerificationLbl.isHidden = true
                descLblTop.constant = 0
                proofLbl.text = "Let’s upload your ID:"
                descLbl.text = "Please upload a valid Australian government issued ID for verification. This could be a drivers license or a passport."
                uploadBtn.setTitle("ADD AN ID", for: .normal)
                idVerificationData()
            } else {
                idVerificationLbl.isHidden = true
                descLblTop.constant = 0
                proofLbl.text = "Please upload proof of drop off or tracking number:"
                descLbl.text = "Please attach proof of tracking. If sending via Australia post please send using the express envelope. Please note: all late returns incur a $10 late fee per day."
                uploadBtn.setTitle("UPLOAD", for: .normal)
            }
        } else {
            
            if isTab == "UploadProof"{
                idVerificationLbl.isHidden = true
                descLblTop.constant = 0
            } else if isTab == "IdVerification"{
                uploadProofLbl.text = "ID Verification"
                idVerificationLbl.isHidden = false
                descLbl.text = "Please upload a valid Australian government issued ID for verification. This could be a drivers license or a passport."
                proofLbl.text = "Let’s upload your ID:"
                uploadBtn.setTitle("ADD AN ID", for: .normal)
                uploadProofTop.constant = 30
                descLblTop.constant = 10
                cameraImgVw.image = UIImage(named: "idCamera")
            } else if isTab == "Return" {
                idVerificationLbl.isHidden = true
                descLblTop.constant = 0
            }
        }
    }
    
    //MARK: -> Actions
    @IBAction func tapBackBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapCameraBtn(_ sender: UIButton) {
        ImagePickerManager().pickImage(self) { (image) in
            self.uploadImgVw.image = image
            self.profileImage = image
            Singletone.shared.idProofImg?.image = image
        }
    }
    
    @IBAction func tapUploadBtn(_ sender: UIButton) {
        if comesFrom == "Profile" {
            if (imageIsNullOrNot(imageName: profileImage)) {
                let getImage = getImageData2(selectedImage: profileImage)
                idVerification(params: ["image":getImage])
             } else {
                 CommonUtilities.shared.showSwiftAlert(message: "Please upload image.", isSuccess: .error)
             }
        } else if comesFrom == "Return" {
            if (imageIsNullOrNot(imageName: profileImage)) {
                let getImage = getImageData2(selectedImage: profileImage)
                idVerificationReturn(params: ["image":getImage, "order_id":self.orderID])
             } else {
                 CommonUtilities.shared.showSwiftAlert(message: "Please upload order return image.", isSuccess: .error)
             }
        } else {
            
            if (imageIsNullOrNot(imageName: profileImage)) {
                let getImage = getImageData2(selectedImage: profileImage)
                idVerificationn(params: ["image":getImage]) { [self] in
                    if isTab == "IdVerificationAfterCheckOut" || isTab == "IdVerification"{
                        cardListVwModel.payNowApi(amount: Singletone.shared.amount ?? 0, cardId: Singletone.shared.cardId ?? "", productId: Singletone.shared.productId ?? "")
                        cardListVwModel.onSuccess = { [weak self] in
                            let vc = self?.storyboard?.instantiateViewController(withIdentifier: "DeliverPopUpVC") as! DeliverPopUpVC
                            vc.deliverObj = self
                            vc.callBack = { (dataa,value) in
                                if dataa == 1 {
                                    let vc = self?.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
                                    vc.selectedIndex = 2
                                    selectedType = 1
                                    self?.navigationController?.pushViewController(vc, animated: true)
                                } else {
                                    let vc = self?.storyboard?.instantiateViewController(withIdentifier: "ViewReceiptVC") as! ViewReceiptVC
                                    isTab = "ViewReceipt"
                                    self?.navigationController?.pushViewController(vc, animated: false)
                                }
                            }
                            isTab = "UploadProof"
                            self?.navigationController?.present(vc, animated: true)
                        }
                    } else {
                        cardListVwModel.payNowApi(amount: Singletone.shared.amount ?? 0, cardId: Singletone.shared.cardId ?? "", productId: Singletone.shared.productId ?? "")
                        cardListVwModel.onSuccess = { [weak self] in
                            let vc = self?.storyboard?.instantiateViewController(withIdentifier: "DeliverPopUpVC") as! DeliverPopUpVC
                            vc.deliverObj = self
                            vc.callBack = { (dataa,value) in
                                if dataa == 1 {
                                    let vc = self?.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
                                    vc.selectedIndex = 2
                                    selectedType = 1
                                    self?.navigationController?.pushViewController(vc, animated: true)
                                } else {
                                    let vc = self?.storyboard?.instantiateViewController(withIdentifier: "ViewReceiptVC") as! ViewReceiptVC
                                    isTab = "ViewReceipt"
                                    self?.navigationController?.pushViewController(vc, animated: false)
                                }
                            }
                            isTab = "IdVerification"
                            self?.navigationController?.present(vc, animated: true)
                        }
                    }
                }
             } else {
                 CommonUtilities.shared.showSwiftAlert(message: "Please upload image.", isSuccess: .error)
             }
        }
    }
    
    func imageIsNullOrNot(imageName : UIImage)-> Bool {
       let size = CGSize(width: 0, height: 0)
       if (imageName.size.width == size.width){
            return false
        } else{
            return true
        }
    }
    
}

//MARK: -> Extension Protocols
extension UploadProofVC: DeliverProtocol{
    func removeDeliverPop(address: Int) {
        if isTab == "IdVerification"{
            if address == 1{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
                vc.selectedIndex = 2
                self.navigationController?.pushViewController(vc, animated: true)
            } else if address == 2{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "LeaveFeedbackVC") as! LeaveFeedbackVC
                isTab = "ComingFromReturnPolicy"
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        else if isTab == "UploadProof"{
            if address == 1{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
                vc.selectedIndex = 0
                self.navigationController?.pushViewController(vc, animated: false)
            }else if address == 2{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewReceiptVC") as! ViewReceiptVC
                isTab = "ViewReceipt"
                self.navigationController?.pushViewController(vc, animated: false)
            }
        } else if isTab == "ComingFromReturnPolicy" || isTab == "AirClosetOrders"{
            if address == 1{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
                vc.selectedIndex = 2
                selectedType = 1
                self.navigationController?.pushViewController(vc, animated: false)
            }else if address == 2{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "LeaveFeedbackVC") as! LeaveFeedbackVC
                self.navigationController?.pushViewController(vc, animated: false)
            }
        }else if isTab == "Notification"{
            if address == 1{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
                vc.selectedIndex = 3
                self.navigationController?.pushViewController(vc, animated: true)
            } else if address == 2{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "LeaveFeedbackVC") as! LeaveFeedbackVC
//                isTab = "GiveRate&Review"
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}


extension UploadProofVC {
    
    private func pickOrder(pickupParams: [String:Any], onSuccessApi: @escaping (()->())) {
        vwModell.pickOrder(paramss: pickupParams) {
            onSuccessApi()
        }
    }
    
    private func idVerification(params: [String:Any]) {
        cardListVwModel.idVerification(params: params) {
            self.callBack?()
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func idVerificationReturn(params: [String:Any]) {
        cardListVwModel.idVerificationReturn(params: params) {
            self.callBack?()
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func idVerificationData() {
        cardListVwModel.idVerificationDetails() {
            self.uploadImgVw.imageLoad(imageUrl: "\(verification)\(self.cardListVwModel.verificationData?.image ?? "")")
            let url = URL(string:"\(verification)\(self.cardListVwModel.verificationData?.image ?? "")")
            if let data = try? Data(contentsOf: url!) {
                self.profileImage = UIImage(data: data) ?? UIImage()
            }
        }
    }
    
    private func idVerificationn(params: [String:Any], onSuccessApi: @escaping (()->())) {
        cardListVwModel.idVerification(params: params) {
            onSuccessApi()
        }
    }
    
}
