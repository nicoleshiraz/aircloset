//
//  ReturnBookingDetailsVC.swift
//  AirCloset
//
//  Created by cql105 on 25/04/23.
//

import UIKit
import Cosmos
import AVKit
import AVFoundation

var listUpdateCallBack: (()->())?
var productIdBooking : String?

class ReturnBookingDetailsVC: UIViewController {
    
    @IBOutlet weak var returnBookingColVw: UICollectionView!
    @IBOutlet weak var returnBookingPageController: UIPageControl!

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var sellerName: UILabel!
    @IBOutlet weak var cosmosVw: CosmosView!
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    
    @IBOutlet weak var catagoryLbl: UILabel!
    @IBOutlet weak var brandLbl: UILabel!
    @IBOutlet weak var sizeLbl: UILabel!
    @IBOutlet weak var rentLbl: UILabel!
    @IBOutlet weak var depositLbl: UILabel!
    @IBOutlet weak var conditionLbl: UILabel!
    @IBOutlet weak var descriptionlbl: UILabel!
    @IBOutlet weak var colorLbl: UILabel!
    @IBOutlet weak var styleLbl: UILabel!
    
    @IBOutlet weak var dryCleaningVw: UIView!
    @IBOutlet weak var pickUpVw: UIView!
    @IBOutlet weak var expressShippingVw: UIView!
    @IBOutlet weak var locationlbl: UILabel!
    @IBOutlet weak var priceAndNightCountLbl: UILabel!
    @IBOutlet weak var totalRentLbl: UILabel!
    @IBOutlet weak var serviceChargeLbl: UILabel!
    @IBOutlet weak var pickUpDate: UILabel!
    @IBOutlet weak var returnDate: UILabel!
    @IBOutlet weak var totalPricewithServiceChrgeLbl: UILabel!
    
    @IBOutlet weak var verifiedUserImg: UIImageView!
    
    @IBOutlet weak var returnView: CustomView!
    @IBOutlet weak var btnReturn: UIButton!
    var productId : String?
    var status : String?
    var productData : ProductDetailModel?
    var vwModel = GetSingleOrderVwModel()
    var orderDataModel : GetSingleOrderModel?
    let playerController = AVPlayerViewController()
    var vwModell = ProductVwModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        returnBookingColVw.delegate = self
        returnBookingColVw.dataSource = self
        //returnBookingPageController.numberOfPages = 3
        print(productId)
        getProductDetailApii()
    }

    func getProductDetailApii(){
        
        vwModel.getSingleOrderApi(id: productId ?? "")
        vwModel.onSuccess = { [weak self] in
            self?.orderDataModel = self?.vwModel.getSingleOrderModelInfo
            self?.profileImg.roundedImage()
            self?.profileImg.sd_setImage(with: URL.init(string: imageURL + (self?.vwModel.getSingleOrderModelInfo?.body?.productID?.userID?.image ?? "")),placeholderImage: UIImage(named: "profileIcon"))
            
            self?.sellerName.text = self?.vwModel.getSingleOrderModelInfo?.body?.productID?.userID?.name ?? ""
            self?.ratingLbl.text = "\(self?.vwModel.getSingleOrderModelInfo?.body?.productID?.rating ?? 0)"
            
            var rate = String(format:"%.2f", self?.vwModel.getSingleOrderModelInfo?.body?.productID?.rating ?? 0.0)
            self?.ratingLbl.isHidden = true
            self?.cosmosVw.text = rate
            
            self?.cosmosVw.rating = Double(Float(self?.vwModel.getSingleOrderModelInfo?.body?.productID?.rating ?? 0.0))
            if self?.vwModel.getSingleOrderModelInfo?.body?.deleiveryStatus == 0{
                self?.statusLbl.text = "Status: Pending"
            }
            else if self?.vwModel.getSingleOrderModelInfo?.body?.deleiveryStatus == 1{
                self?.statusLbl.text = "Status: Picked Up"
            }
            else if self?.vwModel.getSingleOrderModelInfo?.body?.deleiveryStatus == 2{
                self?.statusLbl.text = "Status: Delivered"
            }
            else if self?.vwModel.getSingleOrderModelInfo?.body?.deleiveryStatus == 3{
                self?.statusLbl.text = "Status: Returned"
                self?.btnReturn.isHidden = false
                self?.btnReturn.setTitle("Feedback", for: .normal)
                self?.returnView.isHidden = false
            }
            else if self?.vwModel.getSingleOrderModelInfo?.body?.deleiveryStatus == 4{
                self?.statusLbl.text = "Status: Returned"
                self?.btnReturn.isHidden = false
                self?.btnReturn.setTitle("Feedback", for: .normal)
                self?.returnView.isHidden = false
            }
            
            if self?.vwModel.getSingleOrderModelInfo?.body?.orderType == 1 {
                if self?.vwModel.getSingleOrderModelInfo?.body?.orderStatus == 0 {
                    self?.btnReturn.setTitle("Cancel", for: .normal)
                } else if self?.vwModel.getSingleOrderModelInfo?.body?.orderStatus == 1 {
                    self?.btnReturn.setTitle("Order Accepted", for: .normal)
                } else if self?.vwModel.getSingleOrderModelInfo?.body?.orderStatus == 2 {
                    self?.btnReturn.setTitle("Order Return", for: .normal)
                } else if self?.vwModel.getSingleOrderModelInfo?.body?.orderStatus == 3 {
                    self?.btnReturn.setTitle("Feedback", for: .normal)
                } else if self?.vwModel.getSingleOrderModelInfo?.body?.orderStatus == 4 {
                    self?.btnReturn.setTitle("Feedback", for: .normal)
                } else if self?.vwModel.getSingleOrderModelInfo?.body?.orderStatus == 5 {
                    self?.btnReturn.setTitle("Order Cancelled", for: .normal)
                }
            }
            self?.catagoryLbl.text = self?.vwModel.getSingleOrderModelInfo?.body?.productID?.categoryID?.name ?? ""
            self?.sizeLbl.text = "Size:  \(self?.vwModel.getSingleOrderModelInfo?.body?.productID?.sizeID?.name ?? "")"
            self?.conditionLbl.text = "Condition:  \(self?.vwModel.getSingleOrderModelInfo?.body?.productID?.conditionID?.name ?? "")"
            self?.colorLbl.text = "Color:  \(self?.vwModel.getSingleOrderModelInfo?.body?.productID?.colorID?.name ?? "")"
            self?.colorLbl.text = "Style:  \(self?.vwModel.getSingleOrderModelInfo?.body?.productID?.styleID?.name ?? "")"
            if self?.vwModel.getSingleOrderModelInfo?.body?.productID?.facilities?.drycleaning == 0{
                self?.dryCleaningVw.isHidden = true
            } else{
                self?.dryCleaningVw.isHidden = false
            }
            if self?.vwModel.getSingleOrderModelInfo?.body?.productID?.facilities?.pickup == 0{
                self?.pickUpVw.isHidden = true
            } else {
                self?.pickUpVw.isHidden = false
            }
            if self?.vwModel.getSingleOrderModelInfo?.body?.productID?.facilities?.deleivery == 0 {
                self?.expressShippingVw.isHidden = true
            } else{
                self?.expressShippingVw.isHidden = false
            }
            self?.rentLbl.text = "Rent: $\(self?.vwModel.getSingleOrderModelInfo?.body?.productPrice ?? 0) /Night"
            self?.depositLbl.text = "Deposit: $\(self?.vwModel.getSingleOrderModelInfo?.body?.productID?.deposit ?? 0)"
            self?.descriptionlbl.text = self?.vwModel.getSingleOrderModelInfo?.body?.productID?.description ?? ""
            self?.locationlbl.text = "Location: \(self?.vwModel.getSingleOrderModelInfo?.body?.productID?.location?.name ?? "")"
            self?.priceAndNightCountLbl.text = "$\(self?.vwModel.getSingleOrderModelInfo?.body?.productPrice ?? 0)" + " x \(self?.vwModel.getSingleOrderModelInfo?.body?.totalDays ?? 0) Nights"
            self?.totalRentLbl.text = "$\(self?.vwModel.getSingleOrderModelInfo?.body?.totalPrice ?? 0)"
            self?.serviceChargeLbl.text = "$\(self?.vwModel.getSingleOrderModelInfo?.body?.serviceCharge ?? "") "
            self?.pickUpDate.text = self?.vwModel.getSingleOrderModelInfo?.body?.startDate ?? ""
            self?.returnDate.text = self?.vwModel.getSingleOrderModelInfo?.body?.endDate ?? ""
            self?.totalPricewithServiceChrgeLbl.text = "$\(self?.vwModel.getSingleOrderModelInfo?.body?.totalPrice ?? 0)"
            if self?.vwModel.getSingleOrderModelInfo?.body?.productID?.userID?.idVerification == 1{
                self?.verifiedUserImg.isHidden = false
            } else{
                self?.verifiedUserImg.isHidden = true
            }
            self?.returnBookingColVw.reloadData()
        }
    }

    @IBAction func tapBackBtn(_ sender: UIButton) {
        listUpdateCallBack?()
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapReviewBtn(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReviewVC") as! ReviewVC
        SocketIOManager.sharedInstance.createChat(receiverID: self.vwModel.getSingleOrderModelInfo?.body?.productID?.userID?.id ?? "")
        self.navigationController?.pushViewController(vc, animated: false)
    }

    @IBAction func tapEditMsgBtn(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChatVC") as! ChatVC
        vc.receiverId = self.vwModel.getSingleOrderModelInfo?.body?.productID?.userID?.id ?? ""
        SocketIOManager.sharedInstance.createChat(receiverID: self.vwModel.getSingleOrderModelInfo?.body?.productID?.userID?.id ?? "")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tapSellerBtn(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SellerProfileVC") as! SellerProfileVC
        vc.userID = vwModel.getSingleOrderModelInfo?.body?.productID?.userID?.id ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tapShareBtn(_ sender: UIButton) {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SharePopUpVC") as! SharePopUpVC
//        isTab = "Share"
//        self.navigationController?.present(vc, animated: true)
//        if let urlStr = NSURL(string: "https://apps.apple.com/us/app/idxxxxxxxx?ls=1&mt=8") {
//            let objectsToShare = [urlStr]
//            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
//
//            if UIDevice.current.userInterfaceIdiom == .pad {
//                if let popup = activityVC.popoverPresentationController {
//                    popup.sourceView = self.view
//                    popup.sourceRect = CGRect(x: self.view.frame.size.width / 2, y: self.view.frame.size.height / 4, width: 0, height: 0)
//                }
//            }
//
//            self.present(activityVC, animated: true, completion: nil)
//        }
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReferVC") as! ReferVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tapReadMoreBtn(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TermsConditionsVC") as! TermsConditionsVC
        vc.termAndCondTxt = vwModel.getSingleOrderModelInfo?.body?.productID?.termAddCondition ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tapReturnBtn(_ sender: UIButton) {
        
        
        if vwModel.getSingleOrderModelInfo?.body?.orderType == 1 {
            if btnReturn.titleLabel?.text == "Feedback" {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "LeaveFeedbackVC") as! LeaveFeedbackVC
                if vwModel.getSingleOrderModelInfo?.body?.productID?.userID?.name != "" {
                    vc.userDetails = (vwModel.getSingleOrderModelInfo?.body?.productID?.userID)!
                }
                isTab = "FromReturn"
                vc.bookingID = vwModel.getSingleOrderModelInfo?.body?.id ?? ""
                vc.productId = vwModel.getSingleOrderModelInfo?.body?.productID?.id ?? ""
                self.navigationController?.pushViewController(vc, animated: true)
            } else if btnReturn.titleLabel?.text == "Order Accepted"{
                self.btnReturn.isUserInteractionEnabled = false
            } else if btnReturn.titleLabel?.text == "Order Delivered"{
                pickOrder(pickupParams: ["orderId":vwModel.getSingleOrderModelInfo?.body?.id ?? "","status":"3","orderType": vwModel.getSingleOrderModelInfo?.body?.orderType ?? 0]) { [self] in
                    callBackMyCloset?()
                    getProductDetailApii()
                }
            } else if btnReturn.titleLabel?.text == "Order Return"{
                pickOrder(pickupParams: ["orderId":vwModel.getSingleOrderModelInfo?.body?.id ?? "","status":"4","orderType": vwModel.getSingleOrderModelInfo?.body?.orderType ?? 0]) { [self] in
                    callBackMyCloset?()
                    getProductDetailApii()
                }
            } else if btnReturn.titleLabel?.text == "Order Cancelled"{
            }
        } else {
            if btnReturn.titleLabel?.text == "Feedback" {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "LeaveFeedbackVC") as! LeaveFeedbackVC
                if vwModel.getSingleOrderModelInfo?.body?.productID?.userID?.name != "" {
                    vc.userDetails = (vwModel.getSingleOrderModelInfo?.body?.productID?.userID)!
                }
                isTab = "FromReturn"
                vc.bookingID = vwModel.getSingleOrderModelInfo?.body?.id ?? ""
                vc.productId = vwModel.getSingleOrderModelInfo?.body?.productID?.id ?? ""
                self.navigationController?.pushViewController(vc, animated: true)
            }  else {
                let isSmaller = isDateSmallerThanCurrent(dateString: vwModel.getSingleOrderModelInfo?.body?.endDate ?? "")
                if isSmaller == true {
                    pickOrder(pickupParams: ["orderId":vwModel.getSingleOrderModelInfo?.body?.id ?? "","status":"3","orderType": vwModel.getSingleOrderModelInfo?.body?.orderType ?? 0]) { [self] in
                        callBackMyCloset?()
                        getProductDetailApii()
                    }
                } else {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReturnPolicyPopUpVC") as! ReturnPolicyPopUpVC
                    vc.removeReturnPolicyObj = self
                    vc.productData = productData
                    Singletone.shared.productId = productId
                    self.navigationController?.present(vc, animated: true)
                }
            }
        }
    }
    
    //Mark:--> Did Scroll
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width - (scrollView.contentInset.left*2)
        let index = scrollView.contentOffset.x / width
        let roundedIndex = round( index )
        returnBookingPageController.currentPage = Int(roundedIndex)
    }
}

//Mark:--> DelegatesDataSources
extension ReturnBookingDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var imageCount = vwModel.getSingleOrderModelInfo?.body?.productID?.image?.count ?? 0
        returnBookingPageController.numberOfPages = imageCount + 1
        return imageCount + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = returnBookingColVw.dequeueReusableCell(withReuseIdentifier: "ReturnBookingCVC", for: indexPath) as! ReturnBookingCVC
 
        if indexPath.row < vwModel.getSingleOrderModelInfo?.body?.productID?.image?.count ?? 0{
            cell.bannerImagVw.sd_setImage(with: URL.init(string: productImageUrl + (self.vwModel.getSingleOrderModelInfo?.body?.productID?.image?[indexPath.row] ?? "")),placeholderImage: UIImage(named: "profileIcon"))
        }
        if indexPath.row == vwModel.getSingleOrderModelInfo?.body?.productID?.image?.count{
                var player = AVPlayer(url: URL(string: (videoUrl )+(self.vwModel.getSingleOrderModelInfo?.body?.productID?.video ?? ""))!)
    //          playerController.player = player
                var avpController = AVPlayerViewController()
                let playerLayer = AVPlayerLayer(player: player)
                avpController.player = player
                cell.bannerImagVw.addSubview(avpController.view)
                avpController.view.frame = cell.bannerImagVw.bounds
                cell.bannerImagVw.layer.addSublayer(playerLayer)
            
            }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == self.vwModel.getSingleOrderModelInfo?.body?.productID?.image?.count{
            var player = AVPlayer(url: URL(string: (videoUrl )+(self.vwModel.getSingleOrderModelInfo?.body?.productID?.video ?? ""))!)
//            playerController.player = player
            var avpController = AVPlayerViewController()
            let playerLayer = AVPlayerLayer(player: player)
            avpController.player = player
                player.play()
                present(avpController, animated: true, completion: nil)
        }
    }
}

//Mark:--> Extension Protocols

extension ReturnBookingDetailsVC: ReturnPolicyProtocol {
    func removeReturnPolicyPop(address: Int, productData: ProductDetailModel?) {
        if address == 1{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "CheckOutVC") as! CheckOutVC
            isTab = "ComingFromReturnPolicy"
            productDataa = vwModel.getSingleOrderModelInfo
            self.navigationController?.pushViewController(vc, animated: true)
        } else if address == 2{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AirClosetWorksVC") as! AirClosetWorksVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension ReturnBookingDetailsVC {
    
    private func pickOrder(pickupParams: [String:Any], onSuccessApi: @escaping (()->())) {
        vwModell.pickOrder(paramss: pickupParams) { [self] in
            self.getProductDetailApii()
            onSuccessApi()
        }
    }
    
    func isDateSmallerThanCurrent(dateString: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
        if let date = dateFormatter.date(from: dateString) {
            let currentDate = Date()
            return date >= currentDate
        }
        return false // Return false in case the conversion fails
    }
}
