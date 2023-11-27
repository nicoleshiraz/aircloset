//
//  MyClosetVC.swift
//  AirCloset
//
//  Created by cql105 on 31/03/23.
//

import UIKit
import Cosmos
import SDWebImage

class MyClosetVC: UIViewController {
    
    //MARK: -> Outlets & Variables
    
    @IBOutlet weak var lblterms: UILabel!
    @IBOutlet weak var bioLbl: UILabel!
    @IBOutlet weak var myClosetColVw: UICollectionView!
    @IBOutlet weak var stackVw: UIStackView!
    @IBOutlet weak var myProfileImgVw: UIImageView!
    @IBOutlet weak var profileBtn: UIButton!
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var subscriberLbl: UILabel!
    @IBOutlet weak var isVerifiedImg: UIImageView!
    @IBOutlet weak var ratingVw: CosmosView!
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var isVerifiedWidthCons: NSLayoutConstraint!
    
    var imageView: UIImageView!
    var vwModel = AuthViewModel()
    var closetVwModel = MyClosetVwModel()
    var myClosetModel : MyClosetModel?
    
    var myclosetImgAry = ["image1","image2","image3","image4",
                          "image5","image6","image7","image8",
                          "image9","image10","image11","image12"]
    
    var videoCamImgAry = ["imgIcon","videoIcon","imgIcon","videoIcon",
                          "imgIcon","videoIcon","imgIcon","videoIcon",
                          "imgIcon","videoIcon","imgIcon","videoIcon"]
    
    //MARK: -> View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ratingVw.settings.fillMode = .precise
        myProfileImgVw.layer.cornerRadius = 42.5
        myClosetColVw.delegate = self
        myClosetColVw.dataSource = self
        isVerifiedWidthCons.constant = 0
        self.getProfileInfoApi()
        updateProfileData = {
            self.getProfileInfoApi()
        }
        ratingVw.isUserInteractionEnabled = false
    }
    
    func getMyClosetApi(){
        closetVwModel.getMyClosetApi()
        closetVwModel.onSuccess = { [weak self] in
            self?.myClosetModel = self?.closetVwModel.myClosetInfo
            self?.myProfileImgVw.sd_setImage(with: URL.init(string: imageURL + (self?.closetVwModel.myClosetInfo?.body?.userData?.image ?? "")), placeholderImage: UIImage(named: "profileIcon"))
            self?.nameLbl.text = self?.closetVwModel.myClosetInfo?.body?.userData?.name ?? ""
            if let rating = self?.closetVwModel.myClosetInfo?.body?.userData?.rating{
//                if rating != "" &&  rating != "NaN"{
                if rating != "" {
                    self?.ratingVw.rating = Double(rating) ?? 0.0
                    self?.ratingVw.text = "\(rating)"
                }
//                else if rating == "NaN"{
//                    self?.ratingVw.rating = 0.0
//                    self?.ratingVw.text = "0.0"
//                }
            }
            
            self?.subscriberLbl.text = "\(self?.closetVwModel.myClosetInfo?.body?.userData?.subscriberCount ?? 0) Subscriber"
            if self?.closetVwModel.myClosetInfo?.body?.userData?.isVerified == 0{
                self?.isVerifiedImg.isHidden = true
                self?.isVerifiedWidthCons.constant = 0
            }
            else{
                self?.isVerifiedImg.isHidden = false
                self?.isVerifiedWidthCons.constant = 20
            }
            self?.lblterms.text = self?.vwModel.profileModel?.body?.termAndCondition ?? ""
            self?.myClosetColVw.reloadData()
        }
    }
    
    //MARK: - Api Func
    func getProfileInfoApi(){
        vwModel.getProfileDetailapi()
        vwModel.onSuccess = { [weak self]  in
            self?.bioLbl.text = self?.vwModel.profileModel?.body?.bio ?? ""
            Singletone.shared.clothsTermsAndCon = self?.vwModel.profileModel?.body?.termAndCondition ?? ""
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getMyClosetApi()
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)
        
    }
    
    @objc func methodOfReceivedNotification(notification: Notification) {
    }
    
    //MARK: -> Actions
    
    
    @IBAction func btnProfileTerms(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "TermsPopUp") as! TermsPopUp
        vc.modalPresentationStyle = .overFullScreen
        self.navigationController?.present(vc, animated: true)
    }
    
    @IBAction func tapWithdrawBtn(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "WithdrawVC") as! WithdrawVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tapSettingsBtn(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SettingsVC") as! SettingsVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tapProfileBtn(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MyProfileVC") as! MyProfileVC
        isTab = "IdVerificationAfterMyCloset"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tapShareBtn(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReferVC") as! ReferVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tapRatingBtn(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReviewVC") as! ReviewVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func tapPlusBtn(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddClosetVC") as! AddClosetVC
        isTab = "Explore"
        vc.isSet = 0
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: -> DelegatesDataSources

extension MyClosetVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let celll = UICollectionViewCell()
        myClosetColVw.setEmptyData(msg: "No data found.", rowCount: closetVwModel.myClosetInfo?.body?.myClosets?.count ?? 0)
        return closetVwModel.myClosetInfo?.body?.myClosets?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myClosetColVw.dequeueReusableCell(withReuseIdentifier: "MyClosetCVCell", for: indexPath) as! MyClosetCVCell
        cell.myClosImgVw.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.myClosImgVw.sd_setImage(with: URL.init(string: productImageUrl +  (self.closetVwModel.myClosetInfo?.body?.myClosets?[indexPath.row].image?.first ?? "")), placeholderImage: UIImage(named: "iconPlaceHolder"))
        cell.requestVw.isHidden = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "BookingDetailsVC") as! BookingDetailsVC
        callBackMyCloset = {
            self.getMyClosetApi()
        }
        isTab = "MyClosetZeroIndex"
        vc.productID = self.closetVwModel.myClosetInfo?.body?.myClosets?[indexPath.row].id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/3 - 1, height: collectionView.frame.height/3 - 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}

extension UICollectionViewCell {
    func createCenteredImageView(image: UIImage?, width: CGFloat, height: CGFloat) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: width),
            imageView.heightAnchor.constraint(equalToConstant: height)
        ])
        
        return imageView
    }
}
