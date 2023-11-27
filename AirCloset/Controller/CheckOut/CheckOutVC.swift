//
//  CheckOutVC.swift
//  AirCloset
//
//  Created by cql105 on 06/04/23.
//

import UIKit

var productDaata : ProductDetailModel?
var productDataa: GetSingleOrderModel?

class CheckOutVC: UIViewController {
    
    //MARK: -> Outlets & Variables
    
    @IBOutlet weak var lblExpresss: UILabel!
    @IBOutlet weak var pickVIeww: CustomView!
    @IBOutlet weak var checkOutTableVw: UITableView!
    @IBOutlet weak var checkOutBtn: UIButton!
    @IBOutlet weak var checkOutLbl: UILabel!
//    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var trackingIdVwHgt: NSLayoutConstraint!
    @IBOutlet weak var trackingIdVw: UIView!
    @IBOutlet weak var btnPickk: UIButton!
    
    @IBOutlet weak var continueView : CustomView!
    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var clothTitle: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var brandLbl: UILabel!
    @IBOutlet weak var sizeLbl: UILabel!
    @IBOutlet weak var rentLbl: UILabel!
    @IBOutlet weak var depositlbl: UILabel!
    
    @IBOutlet weak var totalrentLbl: UILabel!
    @IBOutlet weak var serviceChargeslbl: UILabel!
    @IBOutlet weak var totalLbl: UILabel!
    @IBOutlet weak var datelbl: UILabel!
    
    var cardImgAry = ["Icon metro-visa","Icon awesome-credit-card",
                      "Icon awesome-cc-paypal","applePay"]
    var indxValue = -1
    var cardListVwModel = AddNewCardvwModel()
    var getCardListModel : GetCardListDetailModel?
    var stripeIdinStr : String?
    var defaultselectedCard : String?
    var chaarges = Double()
    var createdOrderData : CreateOrderModel?
    var comesFrom = String()
    
    //MARK: -> View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(productDaata)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        checkOutBtn.isUserInteractionEnabled = true
        checkOutTableVw.delegate = self
        checkOutTableVw.dataSource = self
        if isTab == "ComingFromEnterDetails" || isTab == "CheckOut" || isTab == "IdVerificationAfterCheckOut"{
//            editBtn.isHidden = false
            checkOutLbl.text = "Check Out"
            trackingIdVwHgt.constant = 0
            trackingIdVw.isHidden = true
            getCardList()
            getProductData()
        } else if isTab == "ComingFromReturnPolicy" || isTab == "Notification" || isTab == "AirClosetOrders"{
//            editBtn.isHidden = true
            checkOutLbl.text = "Payment"
            trackingIdVwHgt.constant = 85
            trackingIdVw.isHidden = false
            getCardList()
            getProductData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getCardList()
    }
    
    
    //MARK: - Custom Api Func
    func getCardList(){
      
        cardListVwModel.getCardListDetailApi()
        cardListVwModel.onSuccess = { [weak self] in
            self?.getCardListModel = self?.cardListVwModel.cardListInfo
            self?.checkOutBtn.isHidden = self?.cardListVwModel.cardListInfo?.body?.count ?? 0 > 0 ? false : true
            self?.continueView.isHidden = self?.cardListVwModel.cardListInfo?.body?.count ?? 0 > 0 ? false : true
            self?.checkOutTableVw.reloadData()
        }
    }

    //MARK: -CustomFunc
    func getProductData(){
        print(productDataa)
        if isTab == "ComingFromReturnPolicy" {
            productImg.sd_setImage(with: URL(string: productImageUrl + (productDataa?.body?.productID?.image?.first ?? "")), placeholderImage: UIImage(named: "profileIcon"))
            
            clothTitle.text = productDataa?.body?.productID?.categoryID?.name ?? ""
            descriptionLbl.text = productDataa?.body?.productID?.description ?? ""
            brandLbl.text = "Brand: " + (productDataa?.body?.productID?.brandID?.name ?? "")
            sizeLbl.text = "Size: " + (productDataa?.body?.productID?.sizeID?.name ?? "")
            rentLbl.text = "Rent: " + "$\(productDataa?.body?.totalDays ?? 0)/ Night"
            depositlbl.text = "Deposit: " + "$\(productDataa?.body?.productID?.deposit ?? 0)"
            totalrentLbl.text = "Total Rent: " + "$\( self.createdOrderData?.body?.productPrice ?? 0)"
//            var serviceCharge = Int(productDataa?.body?.serviceCharge ?? "") ?? 0
            serviceChargeslbl.text = "Service Charge Includes: " + "$\(serviceCharge)"
            let serviceChargeIncluedRent = Double(self.createdOrderData?.body?.totalPrice ?? 0)
            print(self.createdOrderData?.body?.totalPrice ?? 0)
            var total = Double()
            total = Double(serviceChargeIncluedRent + (chaarges))
            totalLbl.text = "Total: $\(total.formattedString)"
            datelbl.text = "\(productDataa?.body?.startDate ?? "") To \(productDataa?.body?.startDate ?? "")"
            Singletone.shared.amount = productDataa?.body?.totalPrice ?? 0
            if productDaata?.body?.facilities?.pickup == 0 {
                btnPickk.setTitle("No Pick Up", for: .normal)
            } else {
                btnPickk.setTitle("Pick Up", for: .normal)
            }
            btnPickk.setGradientBackground(colors: [#colorLiteral(red: 0.8862276673, green: 0.2431013286, blue: 0.5877236724, alpha: 1) , #colorLiteral(red: 0.7126128078, green: 0.1641548574, blue: 0.8014796376, alpha: 1)], startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 1, y: 1))

            if productDaata?.body?.facilities?.deleivery == 0 {
                lblExpresss.isHidden = true
            } else {
                pickVIeww.isHidden = false
            }
        } else {
            productImg.sd_setImage(with: URL(string: productImageUrl + (productDaata?.body?.image?.first ?? "")), placeholderImage: UIImage(named: "profileIcon"))
            
            clothTitle.text = productDaata?.body?.categoryID?.name ?? ""
            descriptionLbl.text = productDaata?.body?.description ?? ""
            brandLbl.text = "Brand: " + (productDaata?.body?.brandID?.name ?? "")
            sizeLbl.text = "Size: " + (productDaata?.body?.sizeID?.name ?? "")
            rentLbl.text = "Rent: " + "$\(productDaata?.body?.price ?? 0)/ Night"
            depositlbl.text = "Deposit: " + "$\(productDaata?.body?.deposit ?? 0)"
            totalrentLbl.text = "Total Rent: " + ("$\(( self.createdOrderData?.body?.totalPrice ?? 0))".removingPercentEncoding ?? "")
            var totalServiceCharge = chaarges * Double(self.createdOrderData?.body?.totalPrice ?? 0)
            serviceChargeslbl.text = "Service Charge Includes: " + "$\(2)"
            if productDaata?.body?.facilities?.pickup == 0 {
                pickVIeww.isHidden = true
            } else {
                pickVIeww.isHidden = false
            }
            if productDaata?.body?.facilities?.deleivery == 0 {
                lblExpresss.isHidden = true
            } else {
                pickVIeww.isHidden = false
            }
            let serviceChargeIncluedRent = Double(self.createdOrderData?.body?.totalPrice ?? 0)
            print(self.createdOrderData?.body?.totalPrice ?? 0)
            var total = Double()
            total = Double(serviceChargeIncluedRent + (chaarges))
            totalLbl.text = "Total: $\(total.formattedString)"
            
            print(self.createdOrderData?.body?.totalPrice ?? 0)
            totalLbl.text = "Total: $\((serviceChargeIncluedRent + chaarges).formattedString)"
            datelbl.text = "\(createdOrderData?.body?.startDate ?? "") To \(createdOrderData?.body?.endDate ?? "")"
            Singletone.shared.amount = createdOrderData?.body?.totalPrice ?? 0
        }
    }
    
    //MARK: -> Actions
    @IBAction func tapBackBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapEditBtn(_ sender: UIButton) {
//        navigationController?.popViewController(animated: true)
//        isTab = "EditDetails"
    }
    
    @IBAction func tapContinueBtn(_ sender: UIButton) {
        if Store.userDetails?.body?.idVerification == 0 {
            if isTab == "CheckOut" || isTab == "ComingFromEnterDetails"{
                if getCardListModel?.body?.count ?? 0 != 0 {
                    let vc = storyboard?.instantiateViewController(withIdentifier: "IdVerificationPopUpVC") as! IdVerificationPopUpVC
                    vc.verifyObj = self
                    self.navigationController?.present(vc, animated: true)
                }else {
                    CommonUtilities.shared.showSwiftAlert(message: "Please add card first.", isSuccess: .error)
                }
            }else {
                let vc = storyboard?.instantiateViewController(withIdentifier: "UploadProofVC") as! UploadProofVC
                isTab = "UploadProof"
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            cardListVwModel.payNowApi(amount: Singletone.shared.amount ?? 0, cardId: Singletone.shared.cardId ?? "", productId: Singletone.shared.productId ?? "")
            cardListVwModel.onSuccess = { [weak self] in
                let vc = self?.storyboard?.instantiateViewController(withIdentifier: "DeliverPopUpVC") as! DeliverPopUpVC
                vc.callBack = { (value,newVal) in
                    if value == 1 {
                        let vc = self?.storyboard?.instantiateViewController(withIdentifier: "ViewReceiptVC") as! ViewReceiptVC
                        isTab = "ViewReceipt"
                        self?.navigationController?.pushViewController(vc, animated: false)

//                        let vc = self?.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
//                        vc.selectedIndex = 2
//                        selectedType = 1
//                        self?.navigationController?.pushViewController(vc, animated: true)
                    } else if value == 2 {
                        let vc = self?.storyboard?.instantiateViewController(withIdentifier: "ViewReceiptVC") as! ViewReceiptVC
                        isTab = "ViewReceipt"
                        self?.navigationController?.pushViewController(vc, animated: false)
                    } else {
                        self?.navigationController?.popToRootViewController(animated: true)
                    }
                }
                isTab = "UploadProof"
                self?.navigationController?.present(vc, animated: true)
            }
        }
        
    }
    
    @IBAction func tapAddNewCardBtn(_ sender: UIButton) {
        if isTab == "ComingFromEnterDetails"{
            let vc = storyboard?.instantiateViewController(withIdentifier: "AddNewCardVC") as! AddNewCardVC
            isTab = "CheckOut"
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = storyboard?.instantiateViewController(withIdentifier: "AddNewCardVC") as! AddNewCardVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

//MARK: -> DelegatesDataSources of Table View

extension CheckOutVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        checkOutTableVw.setEmptyData(msg: "No card found.", rowCount: getCardListModel?.body?.count ?? 0)
        return getCardListModel?.body?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = checkOutTableVw.dequeueReusableCell(withIdentifier: "CheckOutTVCell", for: indexPath) as! CheckOutTVCell
        cell.cardLbl.text = "XXXX-XXXX-XXXX-\(getCardListModel?.body?[indexPath.row].number ?? 0)"
        if getCardListModel?.body?[indexPath.row].isDefault == 1{
            cell.tickCircleImg.image = UIImage(named: "Icon awesome-check-circle")
            Singletone.shared.cardId = getCardListModel?.body?[indexPath.row].cardStripeID ?? ""
            self.defaultselectedCard = getCardListModel?.body?[indexPath.row].cardStripeID ?? ""
        } else {
            cell.tickCircleImg.image = UIImage(named: "Icon feather-circle")
        }
        cell.deleteBtn.tag = indexPath.row
        cell.deleteBtn.addTarget(self, action: #selector(deleteCard(sender:)), for: .touchUpInside)
        return cell
    }
    
    @objc func deleteCard(sender: UIButton) {
        deleteCard(deleteParam: ["cardStripeId":getCardListModel?.body?[sender.tag].cardStripeID ?? ""])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cardListVwModel.setDefaultcard(stripId: getCardListModel?.body?[indexPath.row].cardStripeID ?? "") {
            self.getCardList()
        }
    }
}

//MARK: -> Extensions Protocols

extension CheckOutVC: IdVerificationProtocol{
    func removeVerificationPop(address: Int) {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyProfileVC") as! MyProfileVC
//        isTab = "IdVerificationAfterCheckOut"
//        self.navigationController?.pushViewController(vc, animated: false)
//
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "UploadProofVC") as! UploadProofVC
//        vc.comesFrom = comesFrom
//        vc.callBack = { [self] in
//            getProfileInfoApi()
//        }
        isTab = "IdVerificationAfterCheckOut"
        comesFromGlobal = "Verify"
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}


extension CheckOutVC {
    
    private func deleteCard(deleteParam: [String:Any]) {
        cardListVwModel.deleteProduct(params: deleteParam) {
            self.getCardList()
        }
    }
}


//MARK: -> Extension Protocols
extension CheckOutVC: DeliverProtocol{
    func removeDeliverPop(address: Int) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
        vc.selectedIndex = 2
        selectedType = 2
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension UIButton {
    func setGradientBackground(colors: [UIColor], startPoint: CGPoint, endPoint: CGPoint) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint

        // Make sure to remove any existing gradients before adding a new one
        layer.sublayers?.filter { $0 is CAGradientLayer }.forEach { $0.removeFromSuperlayer() }

        layer.insertSublayer(gradientLayer, at: 0)
    }
}
