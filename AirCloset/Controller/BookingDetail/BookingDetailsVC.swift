//
//  BookingDetailsVC.swift
//  AirCloset
//
//  Created by cql105 on 04/04/23.
//

import UIKit
import Cosmos
import AVKit
import AVFoundation

//MARK: -> Global Variable
var isTab = String()
var callBackMyCloset: (()->())?

var serviceCharge = Double()

class BookingDetailsVC: UIViewController{
    
    //MARK: -> Outlets & Variables
    
    @IBOutlet weak var bondLbl: UILabel!
    @IBOutlet weak var ChatView: UIView!
    @IBOutlet weak var heartVieww: UIView!
    @IBOutlet weak var orderTypeView: UIView!
    @IBOutlet weak var trackVieww: UIView!
    @IBOutlet weak var btnProof: UIButton!
    @IBOutlet weak var btnViewProof: UILabel!
    @IBOutlet weak var exoressShippingView: UIView!
    @IBOutlet weak var expressShippingLbl: UILabel!
    @IBOutlet weak var expressHeight: NSLayoutConstraint!
    @IBOutlet weak var profileHeight: NSLayoutConstraint!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var msgEditImage: UIImageView!
    @IBOutlet weak var bookingDetColVw: UICollectionView!
    @IBOutlet weak var bookingDetLbl: UILabel!
    @IBOutlet weak var customVwHgt: NSLayoutConstraint!
    @IBOutlet weak var pickUpBtn: UIButton!
    @IBOutlet weak var cancelBtn: CustomButton!
    @IBOutlet weak var cancelBtnHgt: NSLayoutConstraint!
    @IBOutlet weak var pickUpVw: CustomView!
    @IBOutlet weak var priceStackVwHgt: NSLayoutConstraint!
    @IBOutlet weak var reviewBtn: UIButton!
    @IBOutlet weak var bookingPageControl: UIPageControl!
    @IBOutlet weak var dotsBtn: UIButton!
    @IBOutlet weak var dotsVw: UIView!
    @IBOutlet weak var expressShippingVw: UIView!
    
    @IBOutlet weak var shippingBottomLabel: UILabel!
    @IBOutlet weak var lblTrack: UILabel!
    @IBOutlet weak var heartLikeBtn: UIButton!
    @IBOutlet weak var catagoryLbl: UILabel!
    @IBOutlet weak var brandLbl: UILabel!
    @IBOutlet weak var sizeLbl: UILabel!
    @IBOutlet weak var rentLbl: UILabel!
    @IBOutlet weak var depositLbl: UILabel!
    @IBOutlet weak var conditionLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var colorLbl: UILabel!
    @IBOutlet weak var styleLbl: UILabel!
    @IBOutlet weak var pickupAddressLbl: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLblNew: UILabel!
    @IBOutlet weak var tickMarkImg: UIImageView!
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var cosmosVw: CosmosView!
    @IBOutlet weak var facilitiesTblVw: UITableView!
    @IBOutlet weak var facilitiesTblVwHeightCons: NSLayoutConstraint!
    @IBOutlet weak var priceANdNightLbl: UILabel!
    
    @IBOutlet weak var lblShipped: UILabel!
    @IBOutlet weak var totalPriceLbl: UILabel!
    @IBOutlet weak var serviceChargeLbl: UILabel!
    @IBOutlet weak var pickupDate: UILabel!
    @IBOutlet weak var returnDate: UILabel!
    
    @IBOutlet weak var totalpriceNSerchaLvl: UILabel!
    var typeNotif = String()
    var getsingleOrderID : String?
    var orderVwModel = GetSingleOrderVwModel()
    var vwModel = ProductVwModel()
    var productID : String?
    var isClickedDots = Int()
    var bannerImage = [""]
    var homeVwModel = HomeVwModel()
    var type:Int?
    let playerController = AVPlayerViewController()
    var videoUrlStr : String?
    var selectedInd : Int?
    var videoImgUrl = String()
    var acceptRejectVwMdl = AcceptRejectVwModel()
    var messageVM = MessageVM()
    var comesFrom = String()
    @IBOutlet weak var pickUpNShippingLbl: UILabel!
    @IBOutlet weak var domesticShippingLbl: UILabel!
    
    //MARK: -> View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getList()
        cosmosVw.isUserInteractionEnabled = false
        profileImage.layer.cornerRadius = 21.5
        view.bringSubviewToFront(expressShippingVw)
        dotsVw.isHidden = true
        cosmosVw.settings.fillMode = .precise
        expressShippingVw.isHidden = true
        bookingDetColVw.delegate = self
        bookingDetColVw.dataSource = self
        ratingLbl.isHidden = true
        btnProof.isHidden = true
        if isTab == "Explore" {
            pickUpBtn.isHidden = false
            cancelBtn.isHidden = true
            pickUpBtn.setTitle("Reserve", for: .normal)
            bookingDetLbl.text = "Details"
            priceStackVwHgt.constant = 0
            reviewBtn.isUserInteractionEnabled = true
//            lblTrack.isHidden = true
//            trackVieww.isHidden = true
            getProductDetail(id: productID ?? "")
            lblShipped.isHidden = true
        } else if isTab == "AirClosetOrders" {
            pickUpBtn.isHidden = false
            cancelBtn.isHidden = false
            getProductDeatilforPickup()
            lblShipped.isHidden = false
            reviewBtn.isUserInteractionEnabled = true
//            lblTrack.isHidden = true
            heartVieww.isHidden = true
//            trackVieww.isHidden = true
        } else if isTab == "MyClosetZeroIndex" {
            pickUpBtn.isHidden = false
            reviewBtn.isUserInteractionEnabled = true
            cancelBtn.isHidden = true
            bookingDetLbl.text = "My Closet Details"
            pickUpBtn.setTitle("Remove", for: .normal)
            priceStackVwHgt.constant = 0
            dotsBtn.isHidden = false
            msgEditImage.isHidden = true
            dotsVw.isHidden = true
            expressShippingVw.isHidden = false
//            lblTrack.isHidden = true
//            trackVieww.isHidden = true
            lblShipped.isHidden = true
            heartLikeBtn.isHidden = true
            heartVieww.isHidden = true
            ChatView.isHidden = true
            getProductDetail(id: productID ?? "")
        } else if isTab == "MyClosetFourthIndex" {
            bookingDetLbl.text = "Received Order"
            pickUpBtn.setTitle("Accept", for: .normal)
//            lblTrack.isHidden = true
//            trackVieww.isHidden = true
            reviewBtn.isUserInteractionEnabled = true
            heartVieww.isHidden = true
            heartLikeBtn.isHidden = true
            lblShipped.isHidden = true
            getOrderDetail()
        } else if isTab == "ReceivedAfterAccept" {
            pickUpBtn.isHidden = false
            cancelBtn.isHidden = true
            pickUpBtn.setTitle("Received", for: .normal)
            bookingDetLbl.text = "Received Order"
//            lblTrack.isHidden = true
            reviewBtn.isUserInteractionEnabled = true
            heartLikeBtn.isHidden = true
//            trackVieww.isHidden = true
            lblShipped.isHidden = true
            heartVieww.isHidden = true
            getOrderDetail()
        } else if isTab == "GiveRate&ReviewAfterReceived" {
            pickUpBtn.isHidden = false
            reviewBtn.isUserInteractionEnabled = true
            cancelBtn.isHidden = true
            bookingDetLbl.text = "Received Order"
            pickUpBtn.setTitle("Give Rate & Review", for: .normal)
//            lblTrack.isHidden = true
//            trackVieww.isHidden = true
            heartVieww.isHidden = true
            lblShipped.isHidden = true
        }
        
        DispatchQueue.main.async {
            SocketIOManager.sharedInstance.connectUser()
        }
    }
        
    //MARK: - APIFunc
    func getProductDetail(id : String){
        vwModel.getProductDetailApi(id: id)
        vwModel.onSuccess = { [weak self] in
            self?.bannerImage.removeAll()
            self?.profileImage.sd_setImage(with: URL.init(string: imageURL + (self?.vwModel.productDetailInfo?.body?.userID?.image ?? "")),placeholderImage: UIImage(named: "profileIcon"))
            self?.nameLbl.text = self?.vwModel.productDetailInfo?.body?.userID?.name?.capitalizeFirstLetter() ?? ""
            self?.nameLblNew.text = "Product Type: \(self?.vwModel.productDetailInfo?.body?.categoryID?.name ?? "")"
            let rate = String(format:"%.1f", self?.vwModel.productDetailInfo?.body?.rating ?? 0.0)
            self?.ratingLbl.isHidden = true
            if rate == "0.1" {
                self?.ratingLbl.text = "0"
                self?.cosmosVw.text = "0"
            } else if rate == "5.1" {
                self?.ratingLbl.text = "5.0"
                self?.cosmosVw.text = "5.0"

            } else if rate == "1.1" {
                self?.ratingLbl.text = "1.0"
                self?.cosmosVw.text = "1.0"

            } else if rate == "2.1" {
                self?.ratingLbl.text = "2.0"
                self?.cosmosVw.text = "2.0"

            } else if rate == "3.1" {
                self?.ratingLbl.text = "3.0"
                self?.cosmosVw.text = "3.0"

            }else if rate == "4.1" {
                self?.ratingLbl.text = "4.0"
                self?.cosmosVw.text = "4.0"

            }else {
                self?.ratingLbl.text = "\(rate)"
                self?.cosmosVw.text = rate
            }
            self?.bondLbl.text = "$ \(self?.vwModel.productDetailInfo?.body?.deposit ?? 0)"
            self?.cosmosVw.rating = self?.vwModel.productDetailInfo?.body?.rating ?? 0.0
            self?.catagoryLbl.text =  self?.vwModel.productDetailInfo?.body?.name?.capitalizeFirstLetter() ?? ""
            self?.brandLbl.text = "Brand: " +  (self?.vwModel.productDetailInfo?.body?.brandID?.name ?? "")
            self?.sizeLbl.text = "Size: " +  (self?.vwModel.productDetailInfo?.body?.sizeID?.name ?? "")
            self?.rentLbl.text = "Rent: " +  "$ \(self?.vwModel.productDetailInfo?.body?.price ?? 0) /Night" + ""
            self?.depositLbl.text = "BOND: " +  "$ \(self?.vwModel.productDetailInfo?.body?.deposit ?? 0)"
            self?.conditionLbl.text = "Used: " +  (self?.vwModel.productDetailInfo?.body?.conditionID?.name ?? "")
            self?.descriptionLbl.text =  self?.vwModel.productDetailInfo?.body?.description ?? ""
            serviceCharge = Double(self?.vwModel.productDetailInfo?.body?.serviceCharge ?? 0.0) ?? 0.0
//            serviceCharge = 3.0

            self?.colorLbl.text = "Color: " +  (self?.vwModel.productDetailInfo?.body?.colorID?.name ?? "")
            self?.styleLbl.text = "Style: " +  (self?.vwModel.productDetailInfo?.body?.styleID?.name ?? "")
            self?.pickupAddressLbl.text = (self?.vwModel.productDetailInfo?.body?.location ?? "")
            self?.pickUpNShippingLbl.text = "Location"
            getAddress(lat: Double(self?.vwModel.productDetailInfo?.body?.long ?? "") ?? 0.0, lng: Double(self?.vwModel.productDetailInfo?.body?.lat ?? "") ?? 0.0) { location in
                print(location)
                self?.pickupAddressLbl.text = location
            }
            self?.bannerImage = self?.vwModel.productDetailInfo?.body?.image ?? [""]
            self?.expressShippingVw.isHidden = true
            if self?.vwModel.productDetailInfo?.body?.thumbnail ?? "" != "" {
                self?.videoImgUrl = self?.vwModel.productDetailInfo?.body?.thumbnail ?? ""
            }
            if self?.vwModel.productDetailInfo?.body?.video ?? "" != "" {
                self?.videoUrlStr = self?.vwModel.productDetailInfo?.body?.video
                self?.bannerImage.append(self?.vwModel.productDetailInfo?.body?.video ?? "")
            }
            if self?.vwModel.productDetailInfo?.body?.isFavourite == 1{
                self?.heartLikeBtn.setImage(UIImage(named: "Group 9395"), for: .normal)
            } else {
                self?.heartLikeBtn.setImage(UIImage(named: "heart"), for: .normal)
            }
            
            if self?.vwModel.productDetailInfo?.body?.userID?.idVerification == 0{
                self?.tickMarkImg.isHidden = true
            } else {
                self?.tickMarkImg.isHidden = false
            }
            self?.bookingDetColVw.reloadData()
            self?.facilitiesTblVw.reloadData()
        }
    }
    
    func getOrderDetail(){
        orderVwModel.getSingleOrderApi(id: getsingleOrderID ?? "")
        orderVwModel.onSuccess = { [weak self] in
            self?.bannerImage.removeAll()
            self?.profileImage.sd_setImage(with: URL.init(string: imageURL + (self?.orderVwModel.getSingleOrderModelInfo?.body?.buyerID?.image ?? "")),placeholderImage: UIImage(named: "profileIcon"))
            
            self?.nameLbl.text = self?.orderVwModel.getSingleOrderModelInfo?.body?.buyerID?.name?.capitalizeFirstLetter() ?? ""
            if self?.orderVwModel.getSingleOrderModelInfo?.body?.buyerID?.idVerification == 0{
                self?.tickMarkImg.isHidden = true
            } else {
                self?.tickMarkImg.isHidden = false
            }
            
            if self?.orderVwModel.getSingleOrderModelInfo?.body?.orderType == 0 {
                self?.orderTypeView.isHidden = true
                self?.shippingBottomLabel.isHidden = true
                self?.pickUpNShippingLbl.text = "Location"
                self?.exoressShippingView.isHidden = true
            } else {
                self?.expressShippingLbl.text = "$\(self?.orderVwModel.getSingleOrderModelInfo?.body?.productID?.shipping ?? 0)"
                self?.exoressShippingView.isHidden = false
                self?.domesticShippingLbl.isHidden = true
                self?.pickUpNShippingLbl.text = "Shipping Details"
                self?.domesticShippingLbl.text = "\(self?.orderVwModel.getSingleOrderModelInfo?.body?.productID?.location?.name ?? "")"
                self?.pickupAddressLbl.text = "\(self?.orderVwModel.getSingleOrderModelInfo?.body?.address ?? "")"
            }
            
//            self?.lblTrack.text = "Tracking ID: \(self?.orderVwModel.getSingleOrderModelInfo?.body?.trackingID ?? "")"
            self?.nameLblNew.text = "Product Type: \(self?.orderVwModel.getSingleOrderModelInfo?.body?.productID?.categoryID?.name ?? "")"
            self?.catagoryLbl.text = self?.orderVwModel.getSingleOrderModelInfo?.body?.productID?.name?.capitalizeFirstLetter() ?? ""
            self?.brandLbl.text = "Brand: \(self?.orderVwModel.getSingleOrderModelInfo?.body?.productID?.brandID?.name ?? "")"
            self?.sizeLbl.text = "Size: \(self?.orderVwModel.getSingleOrderModelInfo?.body?.productID?.sizeID?.name ?? "")"
            self?.rentLbl.text = "Rent: $\(self?.orderVwModel.getSingleOrderModelInfo?.body?.productID?.price ?? 0) /Night"
            self?.depositLbl.text = "BOND: $\(self?.orderVwModel.getSingleOrderModelInfo?.body?.productID?.deposit ?? 0)"
            self?.conditionLbl.text = "Condition: \(self?.orderVwModel.getSingleOrderModelInfo?.body?.productID?.conditionID?.name ?? "")"
            self?.descriptionLbl.text = self?.orderVwModel.getSingleOrderModelInfo?.body?.productID?.description ?? ""
            self?.colorLbl.text = "Color \(self?.orderVwModel.getSingleOrderModelInfo?.body?.productID?.colorID?.name ?? "")"
            self?.styleLbl.text = "Style: \(self?.orderVwModel.getSingleOrderModelInfo?.body?.productID?.styleID?.name ?? "")"
            self?.priceANdNightLbl.text = "$ \(self?.orderVwModel.getSingleOrderModelInfo?.body?.productID?.price ?? 0) x \(self?.orderVwModel.getSingleOrderModelInfo?.body?.totalDays ?? 0) Nights"
            self?.bannerImage = self?.orderVwModel.getSingleOrderModelInfo?.body?.productID?.image ?? []
            
            if self?.vwModel.productDetailInfo?.body?.thumbnail ?? "" != "" {
                self?.videoImgUrl = self?.vwModel.productDetailInfo?.body?.thumbnail ?? ""
            }
            if self?.vwModel.productDetailInfo?.body?.video ?? "" != "" {
                self?.videoUrlStr = self?.vwModel.productDetailInfo?.body?.video
                self?.bannerImage.append(self?.vwModel.productDetailInfo?.body?.video ?? "")
            }
            if "\(self?.orderVwModel.getSingleOrderModelInfo?.body?.productID?.rating ?? 0)" == "0.1" {
                self?.cosmosVw.text = "0"
            } else if "\(self?.orderVwModel.getSingleOrderModelInfo?.body?.productID?.rating ?? 0)" == "5.1"{
                self?.cosmosVw.text = "5.0"
            }else if "\(self?.orderVwModel.getSingleOrderModelInfo?.body?.productID?.rating ?? 0)" == "4.1"{
                self?.cosmosVw.text = "4.0"
            }else if "\(self?.orderVwModel.getSingleOrderModelInfo?.body?.productID?.rating ?? 0)" == "3.1"{
                self?.cosmosVw.text = "3.0"
            }else if "\(self?.orderVwModel.getSingleOrderModelInfo?.body?.productID?.rating ?? 0)" == "2.1"{
                self?.cosmosVw.text = "2.0"
            }else if "\(self?.orderVwModel.getSingleOrderModelInfo?.body?.productID?.rating ?? 0)" == "1.1"{
                self?.cosmosVw.text = "1.0"
            } else {
                self?.cosmosVw.text = "\(self?.orderVwModel.getSingleOrderModelInfo?.body?.productID?.rating ?? 0)"
            }
            self?.cosmosVw.rating = Double(self?.orderVwModel.getSingleOrderModelInfo?.body?.productID?.rating ?? 0)
            self?.cosmosVw.text = "\(self?.orderVwModel.getSingleOrderModelInfo?.body?.productID?.rating ?? 0)"
            
                if self?.orderVwModel.getSingleOrderModelInfo?.body?.orderStatus == 0 {
                    self?.pickUpBtn.isHidden = false
                    self?.cancelBtn.isHidden = false
                    self?.pickUpBtn.setTitle("Accept Order", for: .normal)
                    self?.bookingDetLbl.text = "Accept Order"
                    self?.lblShipped.isHidden = true
                    self?.btnProof.isHidden = true
                } else if self?.orderVwModel.getSingleOrderModelInfo?.body?.orderStatus == 1 {
                    
                    if self?.orderVwModel.getSingleOrderModelInfo?.body?.orderType == 0 {
                        self?.pickUpBtn.isHidden = false
                        self?.cancelBtn.isHidden = true
                        self?.pickUpBtn.setTitle("Order has been picked up by user", for: .normal)
                        self?.bookingDetLbl.text = "Order Pickup By User"
                        self?.btnProof.isHidden = true
                    } else {
                        self?.pickUpBtn.isHidden = false
                        self?.cancelBtn.isHidden = true
                        self?.lblShipped.isHidden = false
                        self?.pickUpBtn.setTitle("Deliver Order", for: .normal)
                        self?.bookingDetLbl.text = "Deliver Order"
                        self?.btnProof.isHidden = true
                    }
                }else if self?.orderVwModel.getSingleOrderModelInfo?.body?.orderStatus == 2 {
                    
                    if self?.orderVwModel.getSingleOrderModelInfo?.body?.orderType == 1 {
                        self?.pickUpBtn.isHidden = false
                        self?.cancelBtn.isHidden = true
                        self?.btnProof.isHidden = true
                        self?.pickUpBtn.setTitle("Order Delivered", for: .normal)
                        self?.lblShipped.isHidden = true
                        self?.bookingDetLbl.text = "Order Delivered"
                    } else {
                        self?.pickUpBtn.isHidden = false
                        self?.btnProof.isHidden = true
                        self?.cancelBtn.isHidden = true
                        self?.pickUpBtn.setTitle("Order Picked Up by user", for: .normal)
                        self?.bookingDetLbl.text = "Order Picked Up by user"
                    }

                }else if self?.orderVwModel.getSingleOrderModelInfo?.body?.orderStatus == 3 {
                    if isTab == "MyClosetFourthIndex" {
                        self?.pickUpBtn.isUserInteractionEnabled = false
                        self?.pickUpBtn.setTitle("Order Delivered", for: .normal)
                        self?.cancelBtn.isHidden = true
                        self?.btnProof.isHidden = false
                    } else {
                        self?.pickUpBtn.isHidden = false
                        self?.cancelBtn.isHidden = true
                        self?.pickUpBtn.setTitle("Order Returned", for: .normal)
                        self?.bookingDetLbl.text = "Order Returned"
                        self?.btnProof.isHidden = false
                    }
                   
                }else if self?.orderVwModel.getSingleOrderModelInfo?.body?.orderStatus == 4 {
                    self?.pickUpBtn.isHidden = false
                    self?.cancelBtn.isHidden = true
                    self?.pickUpBtn.setTitle("Order Completed", for: .normal)
                    self?.bookingDetLbl.text = "Order Completed"
                    self?.btnProof.isHidden = false
                }else if self?.orderVwModel.getSingleOrderModelInfo?.body?.orderStatus == 5 {
                    self?.pickUpBtn.isHidden = false
                    self?.cancelBtn.isHidden = true
                    self?.pickUpBtn.setTitle("Order Cancelled", for: .normal)
                    self?.bookingDetLbl.text = "Order Cancelled"
                    self?.btnProof.isHidden = false
                }
            self?.totalPriceLbl.text = "$ \(self?.orderVwModel.getSingleOrderModelInfo?.body?.totalPrice ?? 0 - (self?.orderVwModel.getSingleOrderModelInfo?.body?.productID?.shipping ?? 0) )"
            self?.serviceChargeLbl.text = "$ \(Int(self?.orderVwModel.getSingleOrderModelInfo?.body?.serviceCharge ?? 0.0))"
//            self?.serviceChargeLbl.text = "$ 3"
            self?.pickupDate.text = self?.orderVwModel.getSingleOrderModelInfo?.body?.startDate ?? ""
            self?.returnDate.text = self?.orderVwModel.getSingleOrderModelInfo?.body?.endDate ?? ""
            self?.pickupAddressLbl.text = self?.orderVwModel.getSingleOrderModelInfo?.body?.productID?.location?.name ?? ""
            self?.expressShippingLbl.text = "$ \(self?.orderVwModel.getSingleOrderModelInfo?.body?.productID?.shipping ?? 0)"
            var total = Double()
            self?.bondLbl.text = "$ \(self?.orderVwModel.getSingleOrderModelInfo?.body?.productID?.deposit ?? 0)"
            let total22 = (self?.orderVwModel.getSingleOrderModelInfo?.body?.totalPrice ?? Int(0.0)) - (self?.orderVwModel.getSingleOrderModelInfo?.body?.productID?.deposit ?? 0)
            let total2 = (self?.orderVwModel.getSingleOrderModelInfo?.body?.productPrice ?? 0) * (self?.orderVwModel.getSingleOrderModelInfo?.body?.totalDays ?? 0)
            self?.totalPriceLbl.text = "$ \(total2)"
            let serviceChargeString = Double(self?.orderVwModel.getSingleOrderModelInfo?.body?.serviceCharge ?? 0)
//            let serviceChargeString = 3
            var serviceCharge = Double(serviceChargeString)
            serviceCharge = serviceCharge //* Double(self?.orderVwModel.getSingleOrderModelInfo?.body?.totalDays ?? 0)
            if self?.orderVwModel.getSingleOrderModelInfo?.body?.orderType == 0 {
                total = Double(total22) + serviceCharge
            } else {
                total = Double(total22) + serviceCharge
            }
            self?.totalpriceNSerchaLvl.text = "$ \(Int(total))"
            self?.facilitiesTblVw.reloadData()
            self?.bookingDetColVw.reloadData()
        }
        
    }
    
    func getProductDeatilforPickup(){
        orderVwModel.getSingleOrderApi(id: getsingleOrderID ?? "")
        orderVwModel.onSuccess = { [weak self] in
            self?.bannerImage.removeAll()
            self?.profileImage.sd_setImage(with: URL.init(string: imageURL + (self?.orderVwModel.getSingleOrderModelInfo?.body?.productID?.userID?.image ?? "")),placeholderImage: UIImage(named: "profileIcon"))
            self?.nameLbl.text = self?.orderVwModel.getSingleOrderModelInfo?.body?.productID?.userID?.name?.capitalizeFirstLetter() ?? ""
            self?.nameLblNew.text = "Product Type: \(self?.orderVwModel.getSingleOrderModelInfo?.body?.productID?.categoryID?.name ?? "")"
            self?.cosmosVw.rating = Double(Float(self?.orderVwModel.getSingleOrderModelInfo?.body?.productID?.rating ?? 0.0))
            let rate = String(format:"%.2f", (self?.orderVwModel.getSingleOrderModelInfo?.body?.productID?.rating ?? 0.0))
            self?.ratingLbl.isHidden = true
            
            
            if "\(self?.orderVwModel.getSingleOrderModelInfo?.body?.productID?.rating ?? 0.0)" == "0.1" {
                self?.cosmosVw.text = "0"
            } else if "\(self?.orderVwModel.getSingleOrderModelInfo?.body?.productID?.rating ?? 0.0)" == "5.1"{
                self?.cosmosVw.text = "5.0"
            } else if "\(self?.orderVwModel.getSingleOrderModelInfo?.body?.productID?.rating ?? 0.0)" == "4.1"{
                self?.cosmosVw.text = "4.0"
            }else if "\(self?.orderVwModel.getSingleOrderModelInfo?.body?.productID?.rating ?? 0.0)" == "3.1"{
                self?.cosmosVw.text = "3.0"
            }else if "\(self?.orderVwModel.getSingleOrderModelInfo?.body?.productID?.rating ?? 0.0)" == "2.1"{
                self?.cosmosVw.text = "2.0"
            }else if "\(self?.orderVwModel.getSingleOrderModelInfo?.body?.productID?.rating ?? 0.0)" == "1.1"{
                self?.cosmosVw.text = "1.0"
            }else {
                self?.cosmosVw.text = "\(self?.orderVwModel.getSingleOrderModelInfo?.body?.productID?.rating ?? 0)"
            }
            self?.cosmosVw.rating = Double(Float(self?.orderVwModel.getSingleOrderModelInfo?.body?.productID?.rating ?? 0.0))
            if self?.orderVwModel.getSingleOrderModelInfo?.body?.productID?.userID?.isVerified == 0{
                self?.tickMarkImg.isHidden = true
            } else {
                self?.tickMarkImg.isHidden = false
            }
//            self?.lblTrack.text = "Tracking ID: \(self?.orderVwModel.getSingleOrderModelInfo?.body?.trackingID ?? "")"
            self?.catagoryLbl.text = self?.orderVwModel.getSingleOrderModelInfo?.body?.productID?.name?.capitalizeFirstLetter() ?? ""
            self?.brandLbl.text = "Brand: \(self?.orderVwModel.getSingleOrderModelInfo?.body?.productID?.brandID?.name ?? "")"
            self?.sizeLbl.text = "Size: \(self?.orderVwModel.getSingleOrderModelInfo?.body?.productID?.sizeID?.name ?? "")"
            self?.rentLbl.text = "Rent: $ \(self?.orderVwModel.getSingleOrderModelInfo?.body?.productID?.price ?? 0)".removingPercentEncoding
            self?.depositLbl.text = "BOND: $ \(self?.orderVwModel.getSingleOrderModelInfo?.body?.productID?.deposit ?? 0)".removingPercentEncoding
            
            self?.bannerImage = self?.orderVwModel.getSingleOrderModelInfo?.body?.productID?.image ?? []
            if self?.vwModel.productDetailInfo?.body?.thumbnail ?? "" != "" {
                self?.videoImgUrl = self?.vwModel.productDetailInfo?.body?.thumbnail ?? ""
            }
            if self?.vwModel.productDetailInfo?.body?.video ?? "" != "" {
                self?.videoUrlStr = self?.vwModel.productDetailInfo?.body?.video
                self?.bannerImage.append(self?.vwModel.productDetailInfo?.body?.video ?? "")
            }
            self?.conditionLbl.text = "Condition: \(self?.orderVwModel.getSingleOrderModelInfo?.body?.productID?.conditionID?.name ?? "")"
            self?.descriptionLbl.text = self?.orderVwModel.getSingleOrderModelInfo?.body?.productID?.description ?? ""
            self?.colorLbl.text = "Color \(self?.orderVwModel.getSingleOrderModelInfo?.body?.productID?.colorID?.name ?? "")"
            self?.styleLbl.text = "Style: \(self?.orderVwModel.getSingleOrderModelInfo?.body?.productID?.styleID?.name ?? "")"
            self?.domesticShippingLbl.isHidden = true
            self?.pickupAddressLbl.text = "\(self?.orderVwModel.getSingleOrderModelInfo?.body?.productID?.location?.name ?? "")"
            self?.priceANdNightLbl.text = "$ \(self?.orderVwModel.getSingleOrderModelInfo?.body?.productID?.price ?? 0) x \(self?.orderVwModel.getSingleOrderModelInfo?.body?.totalDays ?? 0) Nights"
            if self?.orderVwModel.getSingleOrderModelInfo?.body?.orderType == 0 {
                self?.exoressShippingView.isHidden = true
                self?.pickUpNShippingLbl.text = "Location"
            } else {
                self?.expressShippingLbl.text = "$ \(self?.orderVwModel.getSingleOrderModelInfo?.body?.productID?.shipping ?? 0)"
                self?.exoressShippingView.isHidden = false
                self?.domesticShippingLbl.isHidden = true
                self?.pickUpNShippingLbl.text = "Shipping Details"
//                self?.domesticShippingLbl.text = "Product Location \(self?.orderVwModel.getSingleOrderModelInfo?.body?.productID?.location?.name ?? "")"
                self?.pickupAddressLbl.text = "\(self?.orderVwModel.getSingleOrderModelInfo?.body?.address ?? "")"
            }
            switch self?.orderVwModel.getSingleOrderModelInfo?.body?.orderStatus {
            case 0:
                if self?.orderVwModel.getSingleOrderModelInfo?.body?.orderType == 1 {
                    self?.pickUpBtn.setTitle("Order Pending", for: .normal)
                    self?.cancelBtn.isHidden = false
                    self?.lblShipped.isHidden = true
                } else {
                    self?.pickUpBtn.setTitle("Order Pending", for: .normal)
                    self?.lblShipped.isHidden = true
                    self?.cancelBtn.isHidden = false
                }
                print("")
            case 1:
                print("")
                
                if self?.orderVwModel.getSingleOrderModelInfo?.body?.orderType == 1 {
                    self?.pickUpBtn.setTitle("Order Accepted", for: .normal)
                    self?.lblShipped.isHidden = false
                    self?.cancelBtn.isHidden = true
                } else { //CONFIRM ORDER HAS BEEN PICKED UP
                    self?.pickUpBtn.setTitle("Confirm order has been picked up", for: .normal)
                    self?.cancelBtn.isHidden = true
                    self?.lblShipped.isHidden = true
                }
                
            case 2:
                
                if self?.orderVwModel.getSingleOrderModelInfo?.body?.orderType == 3 {
                    self?.pickUpBtn.setTitle("Return Order", for: .normal)
                    self?.lblShipped.isHidden = true
                    self?.cancelBtn.isHidden = true
                } else {
                    self?.pickUpBtn.setTitle("Return Order", for: .normal)
                    self?.cancelBtn.isHidden = true
                    self?.lblShipped.isHidden = true
                }
                
            case 3:
                
                if self?.orderVwModel.getSingleOrderModelInfo?.body?.orderType == 3 {
                    self?.pickUpBtn.setTitle("Rate & Review", for: .normal)
                    self?.lblShipped.isHidden = true
                    self?.cancelBtn.isHidden = true
                    self?.btnProof.isHidden = false
                } else {
                    self?.pickUpBtn.setTitle("Rate & Review", for: .normal)
                    self?.cancelBtn.isHidden = true
                    self?.lblShipped.isHidden = true
                    self?.btnProof.isHidden = false
                }
                
            case 4:
                
                if self?.orderVwModel.getSingleOrderModelInfo?.body?.orderType == 4 {
                    self?.pickUpBtn.setTitle("Completed", for: .normal)
                    self?.btnProof.isHidden = false
                    self?.cancelBtn.isHidden = true
                    self?.lblShipped.isHidden = true
                } else {
                    self?.btnProof.isHidden = false
                    self?.pickUpBtn.setTitle("Completed", for: .normal)
                    self?.cancelBtn.isHidden = true
                    self?.lblShipped.isHidden = true
                }
                
            case 5:
                
                if self?.orderVwModel.getSingleOrderModelInfo?.body?.orderType == 5 {
                    self?.pickUpBtn.setTitle("Order Cancelled", for: .normal)
                    self?.pickUpBtn.isUserInteractionEnabled = false
                    self?.cancelBtn.isHidden = true
                } else {
                    self?.pickUpBtn.setTitle("Order Cancelled", for: .normal)
                    self?.pickUpBtn.isUserInteractionEnabled = false
                    self?.cancelBtn.isHidden = true
                }
                
            default:
                print("")
            }
            self?.bondLbl.text = "$ \(self?.orderVwModel.getSingleOrderModelInfo?.body?.productID?.deposit ?? 0)"
            guard let productPrice = self?.orderVwModel.getSingleOrderModelInfo?.body?.productPrice,
                  let totalDays = self?.orderVwModel.getSingleOrderModelInfo?.body?.totalDays else {
                // Handle the case where either productPrice or totalDays is nil
                print("Either productPrice or totalDays is nil")
                return
            }
            let totalWithoutShipping = productPrice * totalDays
            self?.totalPriceLbl.text = "$ \(totalWithoutShipping)".removingPercentEncoding
            self?.serviceChargeLbl.text = "$ \(Int(self?.orderVwModel.getSingleOrderModelInfo?.body?.serviceCharge ?? 0.0))"
//            self?.serviceChargeLbl.text = "$ 3"
            self?.pickupDate.text = self?.orderVwModel.getSingleOrderModelInfo?.body?.startDate ?? ""
            self?.returnDate.text = self?.orderVwModel.getSingleOrderModelInfo?.body?.endDate ?? ""
            var total = Double()
            let total2 = (self?.orderVwModel.getSingleOrderModelInfo?.body?.totalPrice ?? 0) - (self?.orderVwModel.getSingleOrderModelInfo?.body?.productID?.deposit ?? 0)
            let shipping = (self?.orderVwModel.getSingleOrderModelInfo?.body?.productID?.shipping ?? 0)
            let serviceChargeString = Double(self?.orderVwModel.getSingleOrderModelInfo?.body?.serviceCharge ?? 0.0) ?? 0
            var serviceCharge = Double(serviceChargeString)
//            var serviceCharge = Double(3)
            var depositAmount = Double(self?.orderVwModel.getSingleOrderModelInfo?.body?.productID?.deposit ?? 0)
            serviceCharge = serviceCharge //* Double(self?.orderVwModel.getSingleOrderModelInfo?.body?.totalDays ?? 0)
            if self?.orderVwModel.getSingleOrderModelInfo?.body?.orderType == 0 {
                total = Double(total2) + serviceCharge
            } else {
                total = Double(total2) + serviceCharge
            }
            self?.totalpriceNSerchaLvl.text = "$ \(Int(total))"
            self?.facilitiesTblVw.reloadData()
            self?.bookingDetColVw.reloadData()
        }
    }
    
    //MARK: -> Actions
    
    @IBAction func heartBtnTapped(_ sender: UIButton) {
        
        self.type = vwModel.productDetailInfo?.body?.isFavourite == 2 ? 1 : 2
        if isTab == "AirClosetOrders" {
            productID = self.orderVwModel.getSingleOrderModelInfo?.body?.productID?.id
            self.type = self.orderVwModel.getSingleOrderModelInfo?.body?.productID?.isFavourite == 2 ? 1 : 2
        } else {
            self.type = vwModel.productDetailInfo?.body?.isFavourite == 2 ? 1 : 2

        }
        
        homeVwModel.addfavorites(type: self.type ?? 0, productId: productID ?? ""){
            if self.vwModel.productDetailInfo?.body?.isFavourite == 1 {
                callBackMyCloset?()
                self.heartLikeBtn.setImage(UIImage(named: "heart"), for: .normal)
                self.vwModel.productDetailInfo?.body?.isFavourite = 2
            } else {
                callBackMyCloset?()
                self.heartLikeBtn.setImage(UIImage(named: "Group 9395"), for: .normal)
                self.vwModel.productDetailInfo?.body?.isFavourite = 1
            }
        }
    }
    
    @IBAction func tapBackBtn(_ sender: UIButton) {
        listUpdateCallBack?()
        if isTab == "GiveRate&ReviewAfterReceived"{
            isTab = "ReceivedAfterAccept"
        }
        
        if isTab == "ReceivedAfterAccept"{
            isTab = "MyClosetFourthIndex"
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapShareBtn(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReferVC") as! ReferVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tapEditMsgBtn(_ sender: UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChatVC") as! ChatVC
        if isTab == "Explore" {
            if userList2.count > 0 {
                userList2.forEach({ data in
                    if self.vwModel.productDetailInfo?.body?.userID?.id == data.receiverID ?? "" {
                        vc.receiverId = data.receiverID ?? ""
                        vc.checkBlockStatus = data.isBlocked ?? false
                        vc.reciverName = data.name?.capitalizeFirstLetter() ?? ""
                        vc.blockedMessage = data.blockedByMessage ?? ""
                        vc.receiverImg = data.image ?? ""
                    } else {
                        vc.receiverId = self.vwModel.productDetailInfo?.body?.userID?.id ?? ""
                        SocketIOManager.sharedInstance.createChat(receiverID: self.vwModel.productDetailInfo?.body?.userID?.id ?? "" )
                        vc.reciverName = self.vwModel.productDetailInfo?.body?.userID?.name ?? ""
                        vc.receiverImg = self.vwModel.productDetailInfo?.body?.userID?.image ?? ""
                    }
                })
            } else {
                vc.receiverId = self.vwModel.productDetailInfo?.body?.userID?.id ?? ""
                SocketIOManager.sharedInstance.createChat(receiverID: self.vwModel.productDetailInfo?.body?.userID?.id ?? "" )
                vc.reciverName = self.vwModel.productDetailInfo?.body?.userID?.name ?? ""
                vc.receiverImg = self.vwModel.productDetailInfo?.body?.userID?.image ?? ""
            }
            
        } else if isTab == "AirClosetOrders"{
            if userList2.count > 0 {
                userList2.forEach({ data in
                    if self.orderVwModel.getSingleOrderModelInfo?.body?.productID?.userID?.id == data.receiverID ?? "" {
                        vc.receiverId = data.receiverID ?? ""
                        vc.checkBlockStatus = data.isBlocked ?? false
                        vc.reciverName = data.name?.capitalizeFirstLetter() ?? ""
                        vc.blockedMessage = data.blockedByMessage ?? ""
                        vc.receiverImg = data.image ?? ""
                    } else {
                        vc.receiverId = self.orderVwModel.getSingleOrderModelInfo?.body?.productID?.userID?.id ?? ""
                        SocketIOManager.sharedInstance.createChat(receiverID: self.orderVwModel.getSingleOrderModelInfo?.body?.productID?.userID?.id ?? "")
                        vc.reciverName = self.orderVwModel.getSingleOrderModelInfo?.body?.productID?.userID?.name ?? ""
                        vc.receiverImg = self.orderVwModel.getSingleOrderModelInfo?.body?.productID?.userID?.image ?? ""
                    }
                })
            } else {
                vc.receiverId = self.orderVwModel.getSingleOrderModelInfo?.body?.productID?.userID?.id ?? ""
                SocketIOManager.sharedInstance.createChat(receiverID: self.orderVwModel.getSingleOrderModelInfo?.body?.productID?.userID?.id ?? "")
                vc.reciverName = self.orderVwModel.getSingleOrderModelInfo?.body?.productID?.userID?.name ?? ""
                vc.receiverImg = self.orderVwModel.getSingleOrderModelInfo?.body?.productID?.userID?.image ?? ""
            }
            
        } else if isTab == "MyClosetFourthIndex" || isTab == "ReceivedAfterAccept" {
            
            if userList2.count > 0 {
                userList2.forEach({ data in
                    if self.orderVwModel.getSingleOrderModelInfo?.body?.buyerID?.id == data.receiverID ?? "" {
                        vc.receiverId = data.receiverID ?? ""
                        vc.checkBlockStatus = data.isBlocked ?? false
                        vc.reciverName = data.name?.capitalizeFirstLetter() ?? ""
                        vc.blockedMessage = data.blockedByMessage ?? ""
                        vc.receiverImg = data.image ?? ""
                    } else {
                        vc.receiverId = self.orderVwModel.getSingleOrderModelInfo?.body?.buyerID?.id ?? ""
                        SocketIOManager.sharedInstance.createChat(receiverID: self.orderVwModel.getSingleOrderModelInfo?.body?.buyerID?.id ?? "")
                        vc.reciverName = self.orderVwModel.getSingleOrderModelInfo?.body?.buyerID?.name ?? ""
                        vc.receiverImg = self.orderVwModel.getSingleOrderModelInfo?.body?.buyerID?.image ?? ""
                    }
                })
            } else {
                vc.receiverId = self.orderVwModel.getSingleOrderModelInfo?.body?.buyerID?.id ?? ""
                SocketIOManager.sharedInstance.createChat(receiverID: self.orderVwModel.getSingleOrderModelInfo?.body?.buyerID?.id ?? "")
                vc.reciverName = self.orderVwModel.getSingleOrderModelInfo?.body?.buyerID?.name ?? ""
                vc.receiverImg = self.orderVwModel.getSingleOrderModelInfo?.body?.buyerID?.image ?? ""
            }
        } else {
            if userList2.count > 0 {
                userList2.forEach({ data in
                    if self.vwModel.productDetailInfo?.body?.userID?.id == data.receiverID ?? "" {
                        vc.receiverId = data.receiverID ?? ""
                        vc.checkBlockStatus = data.isBlocked ?? false
                        vc.reciverName = data.name?.capitalizeFirstLetter() ?? ""
                        vc.blockedMessage = data.blockedByMessage ?? ""
                        vc.receiverImg = data.image ?? ""
                    } else {
                        vc.receiverId = self.vwModel.productDetailInfo?.body?.userID?.id ?? ""
                        SocketIOManager.sharedInstance.createChat(receiverID: self.vwModel.productDetailInfo?.body?.userID?.id ?? "")
                        vc.reciverName = self.vwModel.productDetailInfo?.body?.userID?.name ?? ""
                        vc.receiverImg = self.vwModel.productDetailInfo?.body?.userID?.image ?? ""
                    }
                })
            } else {
                vc.receiverId = self.vwModel.productDetailInfo?.body?.userID?.id ?? ""
                SocketIOManager.sharedInstance.createChat(receiverID: self.vwModel.productDetailInfo?.body?.userID?.id ?? "")
                vc.reciverName = self.vwModel.productDetailInfo?.body?.userID?.name ?? ""
                vc.receiverImg = self.vwModel.productDetailInfo?.body?.userID?.image ?? ""
            }
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tapDotsBtn(_ sender: UIButton) {
        if isClickedDots == 0{
            dotsVw.isHidden = false
            isClickedDots = 1
        } else {
            dotsVw.isHidden = true
            isClickedDots = 0
        }
    }
    
    @IBAction func btnCoverTap(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AccountVC") as! AccountVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tapEditBtn(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddClosetVC") as! AddClosetVC
        vc.comesFrom = "Edit"
        vc.productID = self.vwModel.productDetailInfo?.body?.id ?? ""
        vc.isSet = 1
        isTab = "Explore"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func popBack(_ nb: Int) {
        if let viewControllers: [UIViewController] = self.navigationController?.viewControllers {
            guard viewControllers.count < nb else {
                self.navigationController?.popToViewController(viewControllers[viewControllers.count - nb], animated: true)
                return
            }
        }
    }
    
    @IBAction func tapBookingSellerBtn(_ sender: UIButton) {
        
        if comesFrom == "SellerProfile" {
           popBack(2)
        } else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SellerProfileVC") as! SellerProfileVC
            if isTab == "AirClosetOrders" {
                vc.userID = orderVwModel.getSingleOrderModelInfo?.body?.productID?.userID?.id ?? ""
                vc.callBack = { [self] (value) in
                    getsingleOrderID = value
                    getProductDeatilforPickup()
                }
            } else if isTab == "MyClosetFourthIndex" || isTab == "ReceivedAfterAccept"{
                vc.userID = orderVwModel.getSingleOrderModelInfo?.body?.buyerID?.id ?? ""
                vc.callBack = { [self] (value) in
                    getsingleOrderID = value
                    getProductDeatilforPickup()
                }
            } else {
                vc.userID = self.vwModel.productDetailInfo?.body?.userID?.id ?? ""
                vc.callBack = { [self] (value) in
                    productID = value
                    getProductDetail(id: productID ?? "")
                }
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func tapReadMoreBtn(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ViewProofImage") as! ViewProofImage
        vc.proofImage = "\(returnImage)\(self.orderVwModel.getSingleOrderModelInfo?.body?.image ?? "")"
        vc.status = "\(self.orderVwModel.getSingleOrderModelInfo?.body?.isDepositReturned ?? 0)"
        vc.orderIDd = (self.orderVwModel.getSingleOrderModelInfo?.body?.id ?? "")
        vc.callBack = {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
            vc.selectedIndex = 2
            selectedType = 1
            self.navigationController?.pushViewController(vc, animated: false)
        }
        vc.modalPresentationStyle = .overFullScreen
        self.navigationController?.present(vc, animated: true)
    }
    
    @IBAction func tapPickUpBtn(_ sender: UIButton) {
        
        if isTab == "Explore"{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "EnterDetailsVC") as! EnterDetailsVC
            self.navigationController?.pushViewController(vc, animated: true)
            vc.productData = vwModel.productDetailInfo
            vc.serviceChargees = Double(self.vwModel.productDetailInfo?.body?.serviceCharge ?? 0.0) ?? 0.0
//            vc.serviceChargees = 3.0

            isTab = "EnterDetails"
        } else if isTab == "AirClosetOrders"{
            
            if self.orderVwModel.getSingleOrderModelInfo?.body?.orderType == 1 {
                if self.orderVwModel.getSingleOrderModelInfo?.body?.orderStatus == 2 {
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "UploadProofVC") as! UploadProofVC
                    isTab = "Return"
                    vc.comesFrom = "Return"
                    vc.orderID = self.orderVwModel.getSingleOrderModelInfo?.body?.id ?? ""
                    vc.callBack = { [self] in
                        returnCloth(pickupParams: ["_id":self.orderVwModel.getSingleOrderModelInfo?.body?.id ?? "","status":"3"]) { [self] in
                            callBackMyCloset?()
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                    self.navigationController?.pushViewController(vc, animated: false)
                } else if self.orderVwModel.getSingleOrderModelInfo?.body?.orderStatus == 3 {
                     let vc = self.storyboard?.instantiateViewController(withIdentifier: "LeaveFeedbackVC") as! LeaveFeedbackVC
                     vc.userDetails = self.orderVwModel.getSingleOrderModelInfo?.body?.buyerID
                     vc.productId = self.orderVwModel.getSingleOrderModelInfo?.body?.productID?.id ?? ""
                     vc.userID = self.orderVwModel.getSingleOrderModelInfo?.body?.buyerID?.id ?? ""
                     vc.bookingID = self.orderVwModel.getSingleOrderModelInfo?.body?.id ?? ""
                     isTab = "FromReturn"
                     vc.feedbackStatus = self.orderVwModel.getSingleOrderModelInfo?.body?.feedBackStatus == 0 ? 0 : 1
                     self.navigationController?.pushViewController(vc, animated: false)
                 } else if self.orderVwModel.getSingleOrderModelInfo?.body?.orderStatus == 0 {
                     CommonUtilities.shared.showSwiftAlert(message: "Order not accepted by seller.", isSuccess: .error)
                 }
            } else {
                if self.orderVwModel.getSingleOrderModelInfo?.body?.orderStatus == 0 {
                    CommonUtilities.shared.showSwiftAlert(message: "Order not accepted by seller.", isSuccess: .error)
                } else if self.orderVwModel.getSingleOrderModelInfo?.body?.orderStatus == 1 {
                    pickOrder(pickupParams: ["orderId":getsingleOrderID ?? "","status":"2","orderType":self.orderVwModel.getSingleOrderModelInfo?.body?.orderType ?? 0]) {
                        listUpdateCallBack?()
                        self.navigationController?.popViewController(animated: true)
                    }
                } else if self.orderVwModel.getSingleOrderModelInfo?.body?.orderStatus == 2 {
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "UploadProofVC") as! UploadProofVC
                    isTab = "Return"
                    vc.comesFrom = "Return"
                    vc.orderID = self.orderVwModel.getSingleOrderModelInfo?.body?.id ?? ""
                    vc.callBack = { [self] in
                        returnCloth(pickupParams: ["_id":self.orderVwModel.getSingleOrderModelInfo?.body?.id ?? "","status":"3"]) { [self] in
                            callBackMyCloset?()
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                    self.navigationController?.pushViewController(vc, animated: false)
                    
                } else if self.orderVwModel.getSingleOrderModelInfo?.body?.orderStatus == 3 {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "LeaveFeedbackVC") as! LeaveFeedbackVC
                    vc.productId = self.orderVwModel.getSingleOrderModelInfo?.body?.productID?.id ?? ""
                    vc.userID = self.orderVwModel.getSingleOrderModelInfo?.body?.buyerID?.id ?? ""
                    vc.bookingID = self.orderVwModel.getSingleOrderModelInfo?.body?.id ?? ""
                    Singletone.shared.productId = self.orderVwModel.getSingleOrderModelInfo?.body?.buyerID?.id ?? ""
                    vc.feedbackStatus = self.orderVwModel.getSingleOrderModelInfo?.body?.feedBackStatus == 0 ? 0 : 1
                    self.navigationController?.pushViewController(vc, animated: false)
                }
            }
        } else if isTab == "ReceivedAfterAccept"{
            if self.orderVwModel.getSingleOrderModelInfo?.body?.orderType == 1 {
               if self.orderVwModel.getSingleOrderModelInfo?.body?.orderStatus == 2{
                    CommonUtilities.shared.showSwiftAlert(message: "Order already deliverd to user.", isSuccess: .error)
               } else if self.orderVwModel.getSingleOrderModelInfo?.body?.orderStatus == 1{
                   pickOrder(pickupParams: ["orderId":getsingleOrderID ?? "","status":"2","orderType":self.orderVwModel.getSingleOrderModelInfo?.body?.orderType ?? 0]) {
                       listUpdateCallBack?()
                       self.navigationController?.popViewController(animated: true)
                   }
               }
            } else {
                if self.orderVwModel.getSingleOrderModelInfo?.body?.orderStatus == 1{
                    CommonUtilities.shared.showSwiftAlert(message: "Order not picked up by user.", isSuccess: .error)
                }
            }
        } else if isTab == "ReturnAfterPickUp"{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "UploadProofVC") as! UploadProofVC
            isTab = "UploadProof"
            self.navigationController?.pushViewController(vc, animated: false)
        } else if isTab == "MyClosetZeroIndex"{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "RemovePopUpVC") as! RemovePopUpVC
            vc.removeObj = self
            vc.callBack = {
                isTab = "MyClosetZeroIndex"
            }
            vc.productID = productID ?? ""
            isTab = "Remove"
            self.navigationController?.present(vc, animated: true)
        } else if isTab == "CancelBuying"{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "CancelBuyingPopUpVC") as! CancelBuyingPopUpVC
            vc.removeCancelObj = self
            self.navigationController?.present(vc, animated: true)
        } else if isTab == "MyClosetFourthIndex"{
            
            if self.orderVwModel.getSingleOrderModelInfo?.body?.orderStatus == 0 {
                acceptRejectVwMdl.acceptRejectBookingApi(id: getsingleOrderID ?? "", orderStatus: 1)
                let isPast = isStartDateInPastButNotToday(startDateStr: self.orderVwModel.getSingleOrderModelInfo?.body?.startDate ?? "")
                if isPast {
                    CommonUtilities.shared.showSwiftAlert(message: "You cannot accept the past orders.", isSuccess: .error)
                } else {
                    acceptRejectVwMdl.onSuccess = { [weak self] in
                        listUpdateCallBack?()
                        self?.navigationController?.popViewController(animated: true)
                    }
                }
                
            } else if self.orderVwModel.getSingleOrderModelInfo?.body?.orderStatus == 1 {
                pickOrder(pickupParams: ["orderId":getsingleOrderID ?? "","status":"2","orderType":self.orderVwModel.getSingleOrderModelInfo?.body?.orderType ?? 0]) {
                    listUpdateCallBack?()
                    self.navigationController?.popViewController(animated: true)
                }
            } else if self.orderVwModel.getSingleOrderModelInfo?.body?.orderStatus == 2 {
                CommonUtilities.shared.showSwiftAlert(message: "Order already deliverd to user.", isSuccess: .error)
                
            } else if self.orderVwModel.getSingleOrderModelInfo?.body?.orderStatus == 3 {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "LeaveFeedbackVC") as! LeaveFeedbackVC
                vc.productId = self.orderVwModel.getSingleOrderModelInfo?.body?.productID?.id ?? ""
                vc.userID = self.orderVwModel.getSingleOrderModelInfo?.body?.buyerID?.id ?? ""
                vc.bookingID = self.orderVwModel.getSingleOrderModelInfo?.body?.id ?? ""
                vc.feedbackStatus = self.orderVwModel.getSingleOrderModelInfo?.body?.feedBackStatus == 0 ? 0 : 1
                self.navigationController?.pushViewController(vc, animated: false)
            }
        }
        else if isTab == "GiveRate&ReviewAfterReceived"{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "LeaveFeedbackVC") as! LeaveFeedbackVC
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    @IBAction func tapCancelBtn(_ sender: UIButton) {
        if isTab == "AirClosetOrders"{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "EditCancelPopUpVC") as! EditCancelPopUpVC
            vc.bookingID = orderVwModel.getSingleOrderModelInfo?.body?.id ?? ""
            vc.callBack = { [self] (status) in
                if status == true {
                    updateClosetList?()
                    selectedType = 2
                    self.navigationController?.popViewController(animated: true)
                }
            }
            isTab = "CancelOrder"
            self.navigationController?.present(vc, animated: true)
        } else if isTab == "MyClosetFourthIndex"{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "EditCancelPopUpVC") as! EditCancelPopUpVC
            vc.bookingID = orderVwModel.getSingleOrderModelInfo?.body?.id ?? ""
            vc.callBack = { [self] (status) in
                if status == true {
                    updateClosetList?()
                    selectedType = 2
                    self.navigationController?.popViewController(animated: true)
                }
            }
            isTab = "CancelOrder"
            self.navigationController?.present(vc, animated: true)
        }
    }
    
    @IBAction func tapReviewBtn(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReviewVC") as! ReviewVC
        vc.isTab = isTab
        if isTab == "AirClosetOrders" {
            vc.productID = orderVwModel.getSingleOrderModelInfo?.body?.productID?.id ?? ""
        } else if isTab == "ReceivedAfterAccept"  {
            vc.productID = orderVwModel.getSingleOrderModelInfo?.body?.productID?.id ?? ""
        } else if isTab == "MyClosetFourthIndex"  {
            vc.productID = orderVwModel.getSingleOrderModelInfo?.body?.productID?.id ?? ""
        } else {
            vc.productID = self.vwModel.productDetailInfo?.body?.id ?? ""
        }
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    //MARK: -> Did Scroll
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width - (scrollView.contentInset.left*2)
        let index = scrollView.contentOffset.x / width
        let roundedIndex = round( index )
        bookingPageControl.currentPage = Int(roundedIndex)
        print(bookingPageControl.currentPage)
    }
}

//MARK: -> Collection

extension BookingDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var returnCount : Int?
        if isTab == "Explore" {
            bookingPageControl.numberOfPages = bannerImage.count
            returnCount = bannerImage.count
        } else if isTab == "MyClosetFourthIndex" || isTab == "ReceivedAfterAccept" || isTab == "AirClosetOrders" {
            bookingPageControl.numberOfPages = bannerImage.count
            returnCount = bannerImage.count
        } else {
            bookingPageControl.numberOfPages = bannerImage.count
            returnCount = bannerImage.count
        }
        return returnCount ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = bookingDetColVw.dequeueReusableCell(withReuseIdentifier: "BookingDetCVCell", for: indexPath) as! BookingDetCVCell
        if isTab == "Explore" {
            if indexPath.row < bannerImage.count{
                if bannerImage[indexPath.row].contains("mov") || bannerImage[indexPath.row].contains("mp4") || bannerImage[indexPath.row].contains("mpeg"){
                    let videoURL = URL(string: "\(videoURLS)\(bannerImage[indexPath.row])")!
                    generateThumbnailImage(from: videoURL) { thumbnailImage in
                        if let thumbnail = thumbnailImage {
                            cell.bannerImg.image = thumbnail
                        } else {
                            print("Thumbnail image generation failed.")
                        }
                    }
                    cell.btnPlay.tag = indexPath.row
                    cell.btnPlay.addTarget(self, action: #selector(playVideo(sender:)), for: .touchUpInside)
                } else {
                    cell.btnPlay.isHidden = true
                    cell.bannerImg.sd_setImage(with: URL.init(string: productImageUrl + (bannerImage[indexPath.row] )),placeholderImage: UIImage(named: "imagePlaceholder"))
                }
            }
        }
        else if isTab == "MyClosetFourthIndex" || isTab == "ReceivedAfterAccept" || isTab == "AirClosetOrders"{
            
            if indexPath.row < bannerImage.count{
                if bannerImage[indexPath.row].contains("mov") || bannerImage[indexPath.row].contains("mp4") || bannerImage[indexPath.row].contains("mpeg"){
                    let videoURL = URL(string: "\(videoURLS)\(bannerImage[indexPath.row])")!
                    generateThumbnailImage(from: videoURL) { thumbnailImage in
                        if let thumbnail = thumbnailImage {
                            cell.bannerImg.image = thumbnail
                        } else {
                            print("Thumbnail image generation failed.")
                        }
                    }
                    cell.btnPlay.tag = indexPath.row
                    cell.btnPlay.addTarget(self, action: #selector(playVideo(sender:)), for: .touchUpInside)
                } else {
                    cell.btnPlay.isHidden = true
                    cell.bannerImg.sd_setImage(with: URL.init(string: productImageUrl + (bannerImage[indexPath.row] )),placeholderImage: UIImage(named: "imagePlaceholder"))
                }
            }
            
        } else {
            if indexPath.row < bannerImage.count{
                if bannerImage[indexPath.row].contains("mov") || bannerImage[indexPath.row].contains("mp4") || bannerImage[indexPath.row].contains("mpeg"){
                    let videoURL = URL(string: "\(videoURLS)\(bannerImage[indexPath.row])")!
                    generateThumbnailImage(from: videoURL) { thumbnailImage in
                        if let thumbnail = thumbnailImage {
                            cell.bannerImg.image = thumbnail
                        } else {
                            print("Thumbnail image generation failed.")
                        }
                    }
                    cell.btnPlay.tag = indexPath.row
                    cell.btnPlay.addTarget(self, action: #selector(playVideo(sender:)), for: .touchUpInside)
                    
                } else {
                    cell.btnPlay.isHidden = true
                    cell.bannerImg.sd_setImage(with: URL.init(string: productImageUrl + (bannerImage[indexPath.row] )),placeholderImage: UIImage(named: "imagePlaceholder"))
                }
            }
        }
        return cell
    }
    
    @objc func playVideo(sender: UIButton) {
        if let videoURL = URL(string: (videoUrl )+( bannerImage[sender.tag] )) {
            let player = AVPlayer.playVideo(from: videoURL)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

//MARK: -> Extension Protocols

extension BookingDetailsVC: CancelBuyingProtocol, RemoveProtocol {
    
    func removeCancelPop(address: Int) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
        vc.selectedIndex = 2
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func removePop(address: Int) {
        callBackMyCloset?()
        self.navigationController?.popViewController(animated: true)
    }
}


//MARK: - FacilitiesTblVw
extension BookingDetailsVC : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = facilitiesTblVw.dequeueReusableCell(withIdentifier: "FacilitiesTVC") as! FacilitiesTVC
        if isTab == "Explore" || isTab == "MyClosetZeroIndex"{
            if self.vwModel.productDetailInfo?.body?.facilities?.pickup == 1 {
                cell.pickUpView.isHidden = false
            } else {
                cell.pickUpView.isHidden = true
            }
            if self.vwModel.productDetailInfo?.body?.facilities?.drycleaning == 1 {
                cell.dryCleaningVw.isHidden = false
            } else {
                cell.dryCleaningVw.isHidden = true
            }
            if self.vwModel.productDetailInfo?.body?.facilities?.deleivery == 1 {
                cell.expressShippingVw.isHidden = false
            } else {
                cell.expressShippingVw.isHidden = true
            }
        }
        else if isTab == "MyClosetFourthIndex" || isTab == "ReceivedAfterAccept" || isTab == "AirClosetOrders"{
            if self.orderVwModel.getSingleOrderModelInfo?.body?.productID?.facilities?.pickup == 1 {
                cell.pickUpView.isHidden = false
            } else {
                cell.pickUpView.isHidden = true
            }
            if self.orderVwModel.getSingleOrderModelInfo?.body?.productID?.facilities?.drycleaning == 1 {
                cell.dryCleaningVw.isHidden = false
            } else {
                cell.dryCleaningVw.isHidden = true
            }
            if self.orderVwModel.getSingleOrderModelInfo?.body?.productID?.facilities?.deleivery == 1 {
                cell.expressShippingVw.isHidden = false
            } else {
                cell.expressShippingVw.isHidden = true
            }
        } else {
        }
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.facilitiesTblVwHeightCons.constant = self.facilitiesTblVw.contentSize.height
        }
    }
}


extension BookingDetailsVC {
    
    private func pickOrder(pickupParams: [String:Any], onSuccessApi: @escaping (()->())) {
        vwModel.pickOrder(paramss: pickupParams) { [self] in
            self.getProductDeatilforPickup()
            onSuccessApi()
        }
    }
    
    private func returnCloth(pickupParams: [String:Any], onSuccessApi: @escaping (()->())) {
        vwModel.returnCloth(paramss: pickupParams) { [self] in
            self.getProductDeatilforPickup()
            onSuccessApi()
        }
    }
    
}


extension Double {
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension BookingDetailsVC {
    private func getList() {
        messageVM.fetchChatDialogs { [weak self] in
        }
    }
}
