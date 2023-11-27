//
//  SellerProfileVC.swift
//  AirCloset
//
//  Created by cql105 on 25/04/23.
//

import UIKit
import Cosmos

class SellerProfileVC: UIViewController {
    
    //MARK: -> Outlets & Variables
    
    @IBOutlet weak var sellerProfileColVw: UICollectionView!
    @IBOutlet weak var subscribeNowBtn: UIButton!
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var heightSuscribe: NSLayoutConstraint!
    @IBOutlet weak var suscribeView: CustomView!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var btnSuscribe: UIButton!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var suscriberlbl: UILabel!
    @IBOutlet weak var imgVerify: UIImageView!
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var imgLike: UIImageView!
    @IBOutlet weak var sellerImage: UIImageView!
    @IBOutlet weak var sellerProfile: UIImageView!
    var userDetails = UserID()
    var productID = String()
    var sellerImgAry = ["image1","image2","image3","image4",
                        "image5","image6","image7","image8",
                        "image9","image10","image11","image12"]
    
    var sellerVideoCamImgAry = ["imgIcon","videoIcon","imgIcon","videoIcon",
                                "imgIcon","videoIcon","imgIcon","videoIcon",
                                "imgIcon","videoIcon","imgIcon","videoIcon"]
    var sellerVM = SellerViewModel()
    var userID = String()
    var callBack: ((String)->())?
    var comesFrom = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ratingView.settings.fillMode = .precise
        ratingView.isUserInteractionEnabled = false
        sellerProfileColVw.delegate = self
        sellerProfileColVw.dataSource = self
        sellerProfileDetails(profileParams: ["userId": userID])
        if userID == Store.userDetails?.body?.id ?? ""{
            suscribeView.isHidden = true
            heightSuscribe.constant = 0
        }
        
    }
    
    @IBAction func btnTerms(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "TermsPopUp") as! TermsPopUp
        vc.modalPresentationStyle = .overFullScreen
        vc.comesFrom = "Terms"
        vc.termsData = self.sellerVM.sellerData?.userData?.termAndCondition ?? ""
        self.navigationController?.present(vc, animated: true)
    }
    
    @IBAction func tapBackBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func viewProfilePicBtnTapped(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ViewProfileImgVC") as! ViewProfileImgVC
        vc.profileImg = sellerProfile.image
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func btnTapSuscribe(_ sender: Any) {
        
    }
    
    @IBAction func tapRatingBtn(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReviewVC") as! ReviewVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func tapShareBtn(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReferVC") as! ReferVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tapSubscribeNowBtn(_ sender: UIButton) {
            if self.sellerVM.sellerData?.userData?.subscribeStatus == false {
                suscribeUser(suscribeParam: ["subscribeTo":userID]) { [self] in
                    sellerProfileDetails(profileParams: ["userId": userID])
                }
            } else {
                suscribeUser(suscribeParam: ["subscribeTo":userID]) { [self] in
                    sellerProfileDetails(profileParams: ["userId": userID])
                }
            }
        }
//    }
}

//MARK: -> DelegatesDatasources
extension SellerProfileVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sellerProfileColVw.setEmptyData(msg: "No data found.", rowCount: sellerVM.sellerData?.myClosets?.count ?? 0)
        return sellerVM.sellerData?.myClosets?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = sellerProfileColVw.dequeueReusableCell(withReuseIdentifier: "SellerProfileCVC", for: indexPath) as! SellerProfileCVC
        
        cell.sellerProfileImgVw.sd_setImage(with: URL.init(string: productImageUrl +  (self.sellerVM.sellerData?.myClosets?[indexPath.row].image?.first ?? "")), placeholderImage: UIImage(named: "profileIcon"))
        cell.sellerVideoImgVw.image = UIImage(named: self.sellerVM.sellerData?.myClosets?[indexPath.row].video ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/3 - 1, height: collectionView.frame.height/3 - 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if comesFrom == "Chat" {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "BookingDetailsVC") as! BookingDetailsVC
            vc.comesFrom = "SellerProfile" 
            vc.productID = sellerVM.sellerData?.myClosets?[indexPath.row].id ?? ""
            vc.getsingleOrderID = sellerVM.sellerData?.myClosets?[indexPath.row].id ?? ""
            isTab = "Explore"
            self.navigationController?.pushViewController(vc, animated: true)
        }
//        else if comesFrom == "subscribed" {
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "BookingDetailsVC") as! BookingDetailsVC
//            vc.comesFrom = "SellerProfile"
//            vc.productID = sellerVM.sellerData?.myClosets?[indexPath.row].id ?? ""
//            vc.getsingleOrderID = sellerVM.sellerData?.myClosets?[indexPath.row].id ?? ""
//            isTab = "Explore"
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
        else{
            callBack?(self.sellerVM.sellerData?.myClosets?[indexPath.row].id ?? "")
            self.navigationController?.popViewController(animated: true)

        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}


extension SellerProfileVC {
    
    private func sellerProfileDetails(profileParams: [String:Any]) {
        sellerVM.sellerProfile(params: profileParams) { [weak self] in
            self?.sellerImage.imageLoad(imageUrl: "\(imageURL)\(self?.sellerVM.sellerData?.userData?.image ?? "")")
            self?.sellerImage.roundedImage()
            self?.ratingView.rating = Double(self?.sellerVM.sellerData?.userData?.rating ?? "") ?? 0.0
            self?.ratingView.text = "\(self?.sellerVM.sellerData?.userData?.rating ?? "")"
            self?.suscriberlbl.text = "\(self?.sellerVM.sellerData?.userData?.subscriberCount ?? 0) Subscriber"
            self?.descriptionLbl.text = self?.sellerVM.sellerData?.userData?.bio ?? ""
            self?.lblName.text = self?.sellerVM.sellerData?.userData?.name
            if self?.sellerVM.sellerData?.userData?.subscribeStatus == true {
                self?.subscribeNowBtn.setTitle("Subscribed", for: .normal)
            } else {
                self?.subscribeNowBtn.setTitle("Subscribe Now", for: .normal)

            }
            if self?.sellerVM.sellerData?.userData?.isVerified == 0 {
                self?.imgVerify.isHidden = true
            } else {
                self?.imgVerify.isHidden = false
            }
            self?.sellerProfileColVw.reloadData()
            print("")
        }
    }
    
    private func suscribeUser(suscribeParam: [String:Any],onSuccess: @escaping(()->())) {
        sellerVM.suscribeUser(params: suscribeParam) { [weak self] in
            onSuccess()
        }
    }
}
