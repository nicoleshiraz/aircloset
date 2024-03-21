//
//  EnterDetailsVC.swift
//  AirCloset
//
//  Created by cql105 on 05/04/23.
//

import UIKit
import CountryPickerView

class EnterDetailsVC: UIViewController, UITextFieldDelegate, UIPickerViewDelegate {
    //MARK: -> Outlets & Variables
    @IBOutlet weak var pickUpVw: UIView!
    @IBOutlet weak var deliveryVw: UIView!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var enterDetailsLbl: UILabel!
    @IBOutlet weak var pickUpImgVw: CustomImageView!
    @IBOutlet weak var pickUpBtn: UIButton!
    @IBOutlet weak var deliveryImgVw: CustomImageView!
    @IBOutlet weak var deliveryBtn: UIButton!
    @IBOutlet weak var pickUpTF: UITextField!
    @IBOutlet weak var deliveryTF: UITextField!
    
    @IBOutlet weak var shipHeight: NSLayoutConstraint!
    @IBOutlet weak var shipVieww: CustomView!
    @IBOutlet weak var expressShippingCharges: UILabel!
    
    @IBOutlet weak var bondPickLbl: UILabel!
    @IBOutlet weak var bondDeliveryLbl: UILabel!
    @IBOutlet weak var lblExpresss: UILabel!
    @IBOutlet weak var pickVieww: CustomView!
    @IBOutlet weak var deliveryCountryCode: UILabel!
    @IBOutlet weak var nightTxtForDelivery: UITextField!
    @IBOutlet weak var productImg: CustomImageView!
    @IBOutlet weak var phoneNoPickTxtFld: UITextField!
    @IBOutlet weak var nightsTxtFld: UITextField!
    @IBOutlet weak var deliveryPhnTxtFld: UITextField!
    @IBOutlet weak var addressTxtFld: UITextField!
    @IBOutlet weak var clothTitleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var brandLbl: UILabel!
    @IBOutlet weak var sizeLbl: UILabel!
    @IBOutlet weak var rentLbl: UILabel!
    @IBOutlet weak var depositLbl: UILabel!
    
    @IBOutlet weak var btnPick: UIButton!
    @IBOutlet weak var costbreakdownDelLbl: UILabel!
    @IBOutlet weak var costbreakdownDelAmtLbl: UILabel!
    @IBOutlet weak var priceDetailDelLbl: UILabel!
    @IBOutlet weak var priceDetailDelAmtLbl: UILabel!
    @IBOutlet weak var serviceChargesDellbl: UILabel!
    @IBOutlet weak var totalCostDelLbl: UILabel!
    
    @IBOutlet weak var costBreakDownPickLbl: UILabel!
    @IBOutlet weak var costbreakdwnPickAmtLbl: UILabel!
    @IBOutlet weak var priceDeatilPickLbl: UILabel!
    @IBOutlet weak var priceDetailPickAmotLbl: UILabel!
    @IBOutlet weak var serviceChargesPickLbl: UILabel!
    @IBOutlet weak var talAmountPickLbl: UILabel!
    @IBOutlet weak var btnPickup: UIButton!
    @IBOutlet weak var btnDelivery: UIButton!
    
    @IBOutlet weak var cntryCdLbl: UILabel!
    var comesFrom = String()
    let datePicker = UIDatePicker()
    var productData : ProductDetailModel?
    var productDataForEdit: ClosetListingOrderByMeModelBody?
    var createOrderVwModel = CreateOrderVwModel()
    var vwModel = GetSingleOrderVwModel()
    var nightVal  = 0
    var countryPickerView = CountryPickerView()
    var productID = String()
    var lat = Double()
    var long = Double()
    var deliveryDates = String()
    var clicktext = Int()
    var serviceChargees = Double()
    var historyLocationList: [LocationItem] {
        get {
            if let locationDataList = UserDefaults.standard.array(forKey: "HistoryLocationList") as? [Data] {
                // Decode NSData into LocationItem object.
                return locationDataList.map({ NSKeyedUnarchiver.unarchiveObject(with: $0) as! LocationItem })
            } else {
                return []
            }
        }
        set {
            // Encode LocationItem object.
            let locationDataList = newValue.map({ NSKeyedArchiver.archivedData(withRootObject: $0) })
            UserDefaults.standard.set(locationDataList, forKey: "HistoryLocationList")
        }
    }
    
    //MARK: -> View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        pickVieww.cornerRadius = 9
        pickUpBtn.layer.cornerRadius = 0
        self.btnPickup.isHidden = false
        self.btnDelivery.isHidden = true
        countryPickerView.delegate = self
        deliveryImgVw.isHidden = true
        deliveryVw.isHidden = true
        nightTxtForDelivery.delegate = self
        // submitBtn.isUserInteractionEnabled = false
        deliveryTF.delegate = self
        pickUpTF.delegate = self
        datePicker.minimumDate = Date()
        if nightVal == 0 {
            nightsTxtFld.text = ""
        } else {
            nightsTxtFld.text = "\(nightVal)"
        }
        nightsTxtFld.addTarget(self, action: #selector(myTargetFunction), for: .touchDown)
        nightsTxtFld.keyboardType = .numberPad
        //print(isTab)
        
        if isTab == "EnterDetails" {
            enterDetailsLbl.text = "Enter Details"
            submitBtn.setTitle("Submit", for: .normal)
            getProductData()
        } else if isTab == "EditDetails" {
            setDataForEdit()
//            getProductData()
            comesFrom = "Edit"
            enterDetailsLbl.text = "Edit Details"
            submitBtn.setTitle("Update", for: .normal)
        }
        nightTxtForDelivery.delegate = self
        nightsTxtFld.delegate = self
        pickUpTF.delegate = self
    }
    
    //MARK: Edit Details
    
    func setDataForEdit() {
        serviceCharge = productDataForEdit?.serviceCharge ?? 0.0
        productImg.sd_setImage(with: URL.init(string: productImageUrl + (productDataForEdit?.productID?.image?.first ?? "")), placeholderImage: UIImage(named: "profileIcon"))
        clothTitleLbl.text = productDataForEdit?.productID?.categoryID?.name
        descriptionLbl.text = productDataForEdit?.productID?.description ?? ""
        brandLbl.text = "Brand: " + (productDataForEdit?.productID?.brandID?.name ?? "")
        sizeLbl.text = "Size: " + (productDataForEdit?.productID?.sizeID?.name ?? "")
        rentLbl.text = "Rent: " + "$\(productDataForEdit?.productID?.price ?? 0)/ Night"
        depositLbl.text = "BOND: " + "$\(productDataForEdit?.productID?.deposit ?? 0)"
        phoneNoPickTxtFld.text = "\(productDataForEdit?.phoneNumber ?? 0)"
        pickUpTF.text = productDataForEdit?.startDate ?? ""
        addressTxtFld.text = productDataForEdit?.address ?? ""
        deliveryPhnTxtFld.text = "\(productDataForEdit?.phoneNumber ?? 0)"
        nightTxtForDelivery.text = "\(productDataForEdit?.totalDays ?? 0)"
        addressTxtFld.text = productDataForEdit?.address ?? ""
        costbreakdownDelLbl.text = "$\(productDataForEdit?.productPrice ?? 0) x \(productDataForEdit?.totalDays ?? 0) Nights"
        var totalAmount = Double()
        totalAmount = Double(((productDataForEdit?.productPrice ?? 0) * (Int(productDataForEdit?.totalDays ?? 0) )))
        expressShippingCharges.text = "\(productDataForEdit?.productID?.deposit ?? 0)"
        cntryCdLbl.text = productDataForEdit?.countryCode
        costbreakdownDelAmtLbl.text = "$ \(totalAmount.formattedStringWithoutDecimal)"
        priceDetailDelLbl.text = costbreakdownDelLbl.text
        priceDetailDelAmtLbl.text = costbreakdownDelAmtLbl.text
        serviceChargesDellbl.text = "$\(serviceCharge.formattedString)"

        if productDataForEdit?.orderType == 0 {
            totalCostDelLbl.text = "\(productDataForEdit?.totalPrice ?? 0)"
        } else {
            totalCostDelLbl.text = "\(productDataForEdit?.totalPrice ?? 0)"
//            totalCostDelLbl.text = "\(Int(total))"
        }
        
        costBreakDownPickLbl.text = "$\(productDataForEdit?.productPrice ?? 0) x \(productDataForEdit?.totalDays ?? 0) Nights"
        costbreakdwnPickAmtLbl.text = "$ \((productDataForEdit?.productPrice ?? 0) * (Int(productDataForEdit?.totalDays ?? 0)))"
        priceDeatilPickLbl.text = costBreakDownPickLbl.text
        priceDetailPickAmotLbl.text = costbreakdownDelAmtLbl.text
        serviceChargesPickLbl.text = "$ \(serviceCharge)"
        
        if productDataForEdit?.orderType == 0 {
            talAmountPickLbl.text = "$ " + ("\(totalAmount + (serviceChargees))".removingPercentEncoding ?? "")
        } else {
            talAmountPickLbl.text = "$ " + ("\(totalAmount + (serviceChargees))".removingPercentEncoding ?? "")
        }
        nightsTxtFld.text = "\(productDataForEdit?.totalDays ?? 0)"
        nightVal = productDataForEdit?.totalDays ?? 0
        deliveryCountryCode.text = productDataForEdit?.countryCode ?? ""
        if productDataForEdit?.orderType == 0 {
            deliveryVw.isHidden = true
            pickUpVw.isHidden = false
            self.btnPickup.isHidden = false
            self.btnDelivery.isHidden = true
            pickUpImgVw.isHidden = false
            deliveryImgVw.isHidden = true
            pickUpBtn.setTitleColor(.white, for: .normal)
            deliveryBtn.setTitleColor(UIColor.init(named: "purpleColor"), for: .normal)
            self.deliveryDate()
            pickUpTF.text = productDataForEdit?.startDate ?? ""
        } else {
            deliveryDateForDelivery()
            self.btnPickup.isHidden = true
            self.btnDelivery.isHidden = false
            deliveryVw.isHidden = false
            pickUpVw.isHidden = true
            pickUpImgVw.isHidden = true
            deliveryImgVw.isHidden = false
            deliveryBtn.setTitleColor(.white, for: .normal)
            pickUpBtn.setTitleColor(UIColor.init(named: "purpleColor"), for: .normal)
            deliveryTF.text = productDataForEdit?.startDate ?? ""
        }
        if productData?.body?.facilities?.deleivery == 0 {
            lblExpresss.isHidden = true
            shipVieww.isHidden = true
            shipHeight.constant = 0
        } else {
            lblExpresss.isHidden = false
            shipVieww.isHidden = false
        }
        
    }
    
    
    
    //MARK: - Custom Function
    
    func getProductData(){
        
        if comesFrom == "Edit" {
            serviceCharge = productDataForEdit?.serviceCharge ?? 0.0
            productImg.sd_setImage(with: URL.init(string: productImageUrl + (productDataForEdit?.productID?.image?.first ?? "")), placeholderImage: UIImage(named: "profileIcon"))
            clothTitleLbl.text = productDataForEdit?.productID?.categoryID?.name
            descriptionLbl.text = productDataForEdit?.productID?.description ?? ""
            brandLbl.text = "Brand: " + (productDataForEdit?.productID?.brandID?.name ?? "")
            sizeLbl.text = "Size: " + (productDataForEdit?.productID?.sizeID?.name ?? "")
            rentLbl.text = "Rent: " + "$\(productDataForEdit?.productID?.price ?? 0)/ Night"
            depositLbl.text = "BOND: " + "$\(productDataForEdit?.productID?.deposit ?? 0)"
            phoneNoPickTxtFld.text = "\(productDataForEdit?.phoneNumber ?? 0)"
            pickUpTF.text = productDataForEdit?.startDate ?? ""
            addressTxtFld.text = productDataForEdit?.address ?? ""
            deliveryPhnTxtFld.text = "\(productDataForEdit?.phoneNumber ?? 0)"
            if clicktext == 1 {
                nightTxtForDelivery.text = "\(nightVal)"
            } else {
                nightTxtForDelivery.text = "\(productDataForEdit?.totalDays ?? 0)"
            }
            addressTxtFld.text = productDataForEdit?.address ?? ""
            
        } else {
            productImg.sd_setImage(with: URL.init(string: productImageUrl + (productData?.body?.image?.first ?? "")), placeholderImage: UIImage(named: "profileIcon"))
            clothTitleLbl.text = productData?.body?.categoryID?.name ?? ""
            descriptionLbl.text = productData?.body?.description ?? ""
            brandLbl.text = "Brand: " + (productData?.body?.brandID?.name ?? "")
            sizeLbl.text = "Size: " + (productData?.body?.sizeID?.name ?? "")
            rentLbl.text = "Rent: " + "$\(productData?.body?.price ?? 0) / Night"
            depositLbl.text = "BOND: " + "$ \(productData?.body?.deposit ?? 0)"
            expressShippingCharges.text = "$ \(productData?.body?.shipping ?? 0)"
            if productData?.body?.facilities?.pickup == 0 {
                self.btnPickup.isHidden = true
                self.btnDelivery.isHidden = false
                deliveryVw.isHidden = false
                pickUpVw.isHidden = true
                //self.submitBtn.isUserInteractionEnabled = true
                pickUpImgVw.isHidden = true
                deliveryImgVw.isHidden = false
                self.btnPick.setTitle("No Pick Up", for: .normal)
                deliveryBtn.setTitleColor(.white, for: .normal)
                pickUpBtn.setTitleColor(UIColor.init(named: "purpleColor"), for: .normal)
            } else {
                self.btnPick.setTitle("Pick Up", for: .normal)
            }
            if productData?.body?.facilities?.deleivery == 0 {
                lblExpresss.isHidden = true
                shipVieww.isHidden = true
                shipHeight.constant = 0

            } else {
                lblExpresss.isHidden = false
                shipVieww.isHidden = false
            }
        }
        
        var totalAmount = Double()
        if comesFrom == "Edit" {
            
            if productDataForEdit?.orderType == 0 {
                costbreakdownDelLbl.text = "$ \(productDataForEdit?.productPrice ?? 0) x \(nightVal ) Nights"
                totalAmount = Double(((productDataForEdit?.productPrice ?? 0) * (Int(nightsTxtFld.text ?? "") ?? 0)))
            } else {
                costbreakdownDelLbl.text = "$ \(productDataForEdit?.productPrice ?? 0) x \(nightVal ) Nights"
                totalAmount = Double(((productDataForEdit?.productPrice ?? 0) * (Int(nightTxtForDelivery.text ?? "") ?? 0)))
            }
        } else {
            if deliveryVw.isHidden {
                costbreakdownDelLbl.text = "$ \(productData?.body?.price ?? 0) x \(nightVal ) Nights"
                totalAmount = Double(((productData?.body?.price ?? 0) * (Int(nightsTxtFld.text ?? "") ?? 0)))
            } else {
                costbreakdownDelLbl.text = "$ \(productData?.body?.price ?? 0) x \(nightVal ) Nights"
                totalAmount = Double(((productData?.body?.price ?? 0) * (Int(nightTxtForDelivery.text ?? "") ?? 0)))
            }
        }
        
        var serviceChargee = serviceChargees
        priceDetailDelAmtLbl.text = "$ \(Int(totalAmount))"
        if productData?.body?.facilities?.deleivery == 1 {
            if deliveryImgVw.isHidden == false {
                totalAmount = totalAmount + Double((productData?.body?.shipping ?? 0))
            }
        }
        costbreakdownDelAmtLbl.text = "$ \(Int(totalAmount) )"
        priceDetailDelLbl.text = costbreakdownDelLbl.text
        serviceChargesDellbl.text = "$ \(serviceChargees)"
        let totalCost = totalAmount + Double(serviceChargees) //+ Double((productData?.body?.deposit ?? 0))
        bondDeliveryLbl.text = "$ \(productData?.body?.deposit ?? 0)"
        let roundedValue = String(format: "$ %.2f", totalCost)
//        totalCostDelLbl.text = roundedValue
        totalCostDelLbl.text =  "$ \(Int(totalCost))"
        serviceChargees = serviceChargee
        if comesFrom == "Edit" {
            if productDataForEdit?.orderType == 0 {
                costBreakDownPickLbl.text = "$ \(productDataForEdit?.productPrice ?? 0) x \(nightsTxtFld.text ?? "") Nights"
                costbreakdwnPickAmtLbl.text = "$ \((productDataForEdit?.productPrice ?? 0) * (Int(nightsTxtFld.text ?? "") ?? 0))"
                bondPickLbl.text = "$\(productDataForEdit?.productID?.deposit ?? 0)"
            } else {
                costBreakDownPickLbl.text = "$ \(productDataForEdit?.productPrice ?? 0) x \(nightTxtForDelivery.text ?? "") Nights"
                costbreakdwnPickAmtLbl.text = "$ \((productDataForEdit?.productPrice ?? 0) * (Int(nightTxtForDelivery.text ?? "") ?? 0))"
                bondDeliveryLbl.text = "$ \(productDataForEdit?.productID?.deposit ?? 0)"
            }
          
        } else {
            
            if deliveryVw.isHidden {
                costBreakDownPickLbl.text = "$ \(productData?.body?.price ?? 0) x \(nightsTxtFld.text ?? "") Nights"
                costbreakdwnPickAmtLbl.text = "$ \((productData?.body?.price ?? 0) * (Int(nightsTxtFld.text ?? "") ?? 0))"
                bondPickLbl.text = "$\(productData?.body?.deposit ?? 0)"
            } else {
                costbreakdownDelLbl.text = "$ \(productData?.body?.price ?? 0) x \(nightTxtForDelivery.text ?? "") Nights"
                costbreakdownDelAmtLbl.text = "$ \((productData?.body?.price ?? 0) * (Int(nightTxtForDelivery.text ?? "") ?? 0))"
                bondDeliveryLbl.text = "$\(productData?.body?.deposit ?? 0)"
            }
        }
        
        
        if comesFrom == "Edit" {
            
            if productDataForEdit?.orderType == 0 {
                costbreakdownDelLbl.text = "$ \(productDataForEdit?.productPrice ?? 0) x \(nightVal ) Nights"
//                totalAmount = Double(((productDataForEdit?.productPrice ?? 0) * (Int(nightsTxtFld.text ?? "") ?? 0) + (productDataForEdit?.productID?.deposit ?? 0)))
                totalAmount = Double(((productDataForEdit?.productPrice ?? 0) * (Int(nightsTxtFld.text ?? "") ?? 0)))
            } else {
                costbreakdownDelLbl.text = "$ \(productDataForEdit?.productPrice ?? 0) x \(nightVal ) Nights"
//                totalAmount = Double(((productDataForEdit?.productPrice ?? 0) * (Int(nightTxtForDelivery.text ?? "") ?? 0) + (productDataForEdit?.productID?.deposit ?? 0)))
                totalAmount = Double(((productDataForEdit?.productPrice ?? 0) * (Int(nightTxtForDelivery.text ?? "") ?? 0)))
            }
        } else {
            
//            let amountt = (productData?.body?.deposit ?? 0)
            let amountt = 0

            if deliveryVw.isHidden {
                costbreakdownDelLbl.text = "$ \(productData?.body?.price ?? 0) x \(nightVal ) Nights"
                totalAmount = Double((productData?.body?.price ?? 0) * (Int(nightsTxtFld.text ?? "") ?? 0) + amountt)
            } else {
                costbreakdownDelLbl.text = "$ \(productData?.body?.price ?? 0) x \(nightVal ) Nights"
                totalAmount = Double((productData?.body?.price ?? 0) * (Int(nightTxtForDelivery.text ?? "") ?? 0) + amountt)
            }
        }
        priceDeatilPickLbl.text = costBreakDownPickLbl.text
        priceDetailPickAmotLbl.text = costbreakdownDelAmtLbl.text
        serviceChargesPickLbl.text = "$ \(serviceChargees.formattedStringWithoutDecimal)"
        var finalAmount = Int(totalAmount)
//        if comesFrom == "Edit" {
//            talAmountPickLbl.text = "$ " + (("\(totalAmount + (serviceChargees))"))
//        } else {
//            talAmountPickLbl.text = "$ " + (("\(totalAmount + (serviceChargees))"))
//        }
        
        if comesFrom == "Edit" {
            let total = totalAmount + serviceChargees
            let roundedValue = String(format: "$ %.2f", total)
//            talAmountPickLbl.text = roundedValue
            talAmountPickLbl.text = "$ \(Int(total))"
        } else {
            let total = totalAmount + serviceChargees
            let roundedValue = String(format: "$ %.2f", total)
//            talAmountPickLbl.text = roundedValue
            talAmountPickLbl.text = "$ \(Int(total))"
        }
//
        print(finalAmount + 2,"priceeeeeeeeee")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if isTab == "EnterDetails" {
            enterDetailsLbl.text = "Enter Details"
            submitBtn.setTitle("Submit", for: .normal)
            btnPickup.setTitle("Submit", for: .normal)
            btnDelivery.setTitle("Submit", for: .normal)
//            getProductData()
        } else if isTab == "EditDetails" {
            enterDetailsLbl.text = "Edit Details"
            submitBtn.setTitle("Update", for: .normal)
            btnPickup.setTitle("Update", for: .normal)
            btnDelivery.setTitle("Update", for: .normal)
        }
    }
    
    func datePickerValues(textField: UITextField){
        datePicker.datePickerMode = .date
        textField.inputView = datePicker
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            
        }
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissDatePicker))
        toolbar.setItems([doneButton], animated: true)
        textField.inputAccessoryView = toolbar
        if textField == deliveryTF{
            datePicker.tag = 1
        }else{
            datePicker.tag = 2
        }
    }
    
    @objc func dismissDatePicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yy"
        //        formatter.dateStyle = .medium
        //        formatter.timeStyle = .none
        switch datePicker.tag{
        case 1:
            deliveryTF.text = formatter.string(from: datePicker.date)
            deliveryTF.resignFirstResponder()
        case 2:
            pickUpTF.text = formatter.string(from: datePicker.date)
            pickUpTF.resignFirstResponder()
        default:
            print("hello")
        }
    }
    
    //Mark:--> Actions
    @IBAction func tapBackBtn(_ sender: UIButton) {
        //done by me
        isTab = "Explore"
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func countryDeliveryCdBtn(_ sender: Any) {
        countryPickerView.showCountriesList(from: self)
    }
    
    @IBAction func countryCdBtnTapped(_ sender: UIButton) {
        countryPickerView.showCountriesList(from: self)
    }
    
    @IBAction func tapNoPickUpBtn(_ sender: UIButton) {
        
    }
    @IBAction func addressBtn(_ sender: UIButton) {
        let customLocationPicker = CustomLocationAddProductss()
        customLocationPicker.viewController = self
        let navigationController = UINavigationController(rootViewController: customLocationPicker)
        present(navigationController, animated: true, completion: nil)
    }
    
    @IBAction func tapPickUpBtn(_ sender: UIButton) {
        
        if comesFrom == "Edit" {
            CommonUtilities.shared.showSwiftAlert(message: "You cannot change delivery mode this time.", isSuccess: .error)
        } else {
            if productData?.body?.facilities?.pickup == 0 {
                CommonUtilities.shared.showSwiftAlert(message: "Pickup is not available for this item.", isSuccess: .error)
            } else {
                deliveryVw.isHidden = true
                pickUpVw.isHidden = false
                self.btnPickup.isHidden = false
                self.btnDelivery.isHidden = true
                pickUpImgVw.isHidden = false
                deliveryImgVw.isHidden = true
                pickUpBtn.setTitleColor(.white, for: .normal)
                deliveryBtn.setTitleColor(UIColor.init(named: "purpleColor"), for: .normal)
               // deliveryDateForDelivery()
                self.deliveryDate()
            }
        }
    }
    
    @IBAction func tapDeliveryBtn(_ sender: UIButton) {
        
        if comesFrom == "Edit" {
            CommonUtilities.shared.showSwiftAlert(message: "You cannot change delivery mode this time.", isSuccess: .error)
        } else {
            if productData?.body?.facilities?.deleivery == 0 {
                CommonUtilities.shared.showSwiftAlert(message: "Seller not enabled delivery option for this product.", isSuccess: .error)
            } else {
                self.btnPickup.isHidden = true
                self.btnDelivery.isHidden = false
                deliveryVw.isHidden = false
                pickUpVw.isHidden = true
                //self.submitBtn.isUserInteractionEnabled = true
                pickUpImgVw.isHidden = true
                deliveryImgVw.isHidden = false
                deliveryBtn.setTitleColor(.white, for: .normal)
                pickUpBtn.setTitleColor(UIColor.init(named: "purpleColor"), for: .normal)
                if cntryCdLbl.text == "+1"{
                    deliveryPhnTxtFld.text = phoneNoPickTxtFld.text
                } else{
                }
            }
            self.deliveryDate()
//            let shipping = Double(productData?.body?.shipping ?? 0) + serviceChargees + Double(productData?.body?.deposit ?? 0)
//            totalCostDelLbl.text =  "$ " + "\(shipping)"
            
            let shipping = Double(productData?.body?.shipping ?? 0) + serviceChargees //+ Double(productData?.body?.deposit ?? 0)
            let roundedValue = String(format: " %.2f", shipping)
            totalCostDelLbl.text = "\(Int(shipping))"
            
//            totalCostDelLbl.text =  "$ " + "\((productData?.body?.shipping ?? 0) + (Int(productData?.body?.serviceCharge ?? "") ?? 0))"
        }
    }
    
    @IBAction func tapSubmitBtn(_ sender: UIButton) {
        if pickUpTF.text!.isBlank {
            CommonUtilities.shared.showSwiftAlert(message: "Please enter Pickup Date", isSuccess: .error)
        }
        else if cntryCdLbl.text == ""{
            CommonUtilities.shared.showSwiftAlert(message: "Please select country Code", isSuccess: .error)
        }
        
        else if phoneNoPickTxtFld.text!.isBlank{
            CommonUtilities.shared.showSwiftAlert(message: "Please enter your Phone Number", isSuccess: .error)
        }
        else if phoneNoPickTxtFld.text!.count < 8 || phoneNoPickTxtFld.text!.count > 13{
            CommonUtilities.shared.showSwiftAlert(message: "Please enter your valid Number", isSuccess: .error)
        }
        else if self.nightVal < 1 {
            CommonUtilities.shared.showSwiftAlert(message: "Please enter the total Nights", isSuccess: .error)
        }else {
            deliveryDate()
            createOrderVwModel.createOrderApi(productId: comesFrom == "Edit" ? productDataForEdit?.productID?.id ?? "" : productData?.body?.id ?? "", startDate: pickUpTF.text ?? "", countryCode: cntryCdLbl.text ?? "", phoneNumber: phoneNoPickTxtFld.text ?? "", endDate: deliveryTF.text ?? "", address: addressTxtFld.text ?? "", type: 0,comesFrom: comesFrom,productID:  comesFrom == "Edit" ? productDataForEdit?.id ?? "" : productData?.body?.id ?? "")
            createOrderVwModel.onSuccess = { [weak self] in
                
                if self?.comesFrom == "Edit" {
                    listUpdateCallBack?()
                    self?.navigationController?.popViewController(animated: true)
                } else {
                    let vc = self?.storyboard?.instantiateViewController(withIdentifier: "CheckOutVC") as! CheckOutVC
                    isTab = "ComingFromEnterDetails"
                    vc.comesFrom = "EnterDetails"
                    vc.chaarges = 2
                    vc.fullAmount = self?.talAmountPickLbl.text ?? ""
                    productDaata = self?.productData
                    vc.isPickup = true //pickup
                    vc.createdOrderData = self?.createOrderVwModel.createdorderDataInfo
                    self?.navigationController?.pushViewController(vc, animated: false)
                }
            }
        }
    }
    
    func deliveryDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy" // Adjust the format according to your selected date's format
        guard let selectedDateText = pickUpTF.text,
              let selectedDate = dateFormatter.date(from: selectedDateText) else {
            print("Invalid selected date: \(pickUpTF.text ?? "")")
            return
        }
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.day = nightVal
        guard let newDate = calendar.date(byAdding: dateComponents, to: selectedDate) else {
            print("Failed to calculate new date")
            return
        }
        
        let newDateFormatter = DateFormatter()
        newDateFormatter.dateFormat = "dd/MM/yy"
        
        let newDateString = newDateFormatter.string(from: newDate)
        deliveryTF.text = newDateString
    }
    
    func deliveryDateForDelivery() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy" // Adjust the format according to your selected date's format
        guard let selectedDateText = deliveryTF.text,
              let selectedDate = dateFormatter.date(from: selectedDateText) else {
            print("Invalid selected date: \(deliveryTF.text ?? "")")
            return
        }
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.day = nightVal
        guard let newDate = calendar.date(byAdding: dateComponents, to: selectedDate) else {
            print("Failed to calculate new date")
            return
        }
        
        let newDateFormatter = DateFormatter()
        newDateFormatter.dateFormat = "dd/MM/yy"
        
        let newDateString = newDateFormatter.string(from: newDate)
        deliveryDates = newDateString
    }
    
    
    func setDeliveryData() {
        self.deliveryBtn.isUserInteractionEnabled = false
        self.pickUpVw.isHidden = true
        self.deliveryVw.isHidden = false
        pickUpImgVw.isHidden = true
        deliveryImgVw.isHidden = false
        deliveryBtn.setTitleColor(.white, for: .normal)
        pickUpBtn.setTitleColor(UIColor.init(named: "purpleColor"), for: .normal)
        self.btnPickup.isHidden = true
        self.btnDelivery.isHidden = false
        if cntryCdLbl.text == "+1"{
            deliveryPhnTxtFld.text = phoneNoPickTxtFld.text
        } else{
        }
        self.deliveryDate()
    }
    
    
    @IBAction func btnActionDeliverySubmit(_ sender: UIButton) {
        deliveryDateForDelivery()
        if deliveryTF.text!.isBlank {
            CommonUtilities.shared.showSwiftAlert(message: "Please enter Delivery Date", isSuccess: .error)
        } else if deliveryCountryCode.text == ""{
            CommonUtilities.shared.showSwiftAlert(message: "Please select country Code", isSuccess: .error)
        } else if deliveryPhnTxtFld.text!.isBlank{
            CommonUtilities.shared.showSwiftAlert(message: "Please enter your Phone Number", isSuccess: .error)
        } else if deliveryPhnTxtFld.text!.count < 6 || deliveryPhnTxtFld.text!.count > 13{
            CommonUtilities.shared.showSwiftAlert(message: "Please enter your valid Number", isSuccess: .error)
        } else if self.nightVal < 1 {
            CommonUtilities.shared.showSwiftAlert(message: "Please enter the total Nights", isSuccess: .error)
        } else if addressTxtFld.text!.isBlank{
            CommonUtilities.shared.showSwiftAlert(message: "Please enter your delivery Address", isSuccess: .error)
        } else {
            
            createOrderVwModel.createOrderApi(productId: comesFrom == "Edit" ? productDataForEdit?.productID?.id ?? "" : productData?.body?.id ?? "", startDate: deliveryTF.text ?? "", countryCode: deliveryCountryCode.text ?? "", phoneNumber: deliveryPhnTxtFld.text ?? "", endDate: deliveryDates, address: addressTxtFld.text ?? "", type: 1,comesFrom: comesFrom, productID: comesFrom == "Edit" ? productDataForEdit?.id ?? "" : productData?.body?.id ?? "")
            createOrderVwModel.onSuccess = { [weak self] in
                if self?.comesFrom == "Edit" {
                    listUpdateCallBack?()
                    self?.navigationController?.popViewController(animated: true)
                } else {
//                    let vc = self?.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
//                    vc.selectedIndex = 2
//                    selectedType = 1
//                    self?.navigationController?.pushViewController(vc, animated: false)
                    let vc = self?.storyboard?.instantiateViewController(withIdentifier: "CheckOutVC") as! CheckOutVC
                    isTab = "ComingFromEnterDetails"
                    vc.comesFrom = "EnterDetails"
                    vc.chaarges = 2
                    vc.fullAmount = self?.totalCostDelLbl.text ?? ""
                    productDaata = self?.productData
                    vc.isPickup = false //delivery
                    vc.createdOrderData = self?.createOrderVwModel.createdorderDataInfo
                    self?.navigationController?.pushViewController(vc, animated: false)
                }
            }
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        datePicker.tag = textField.tag
        if textField == pickUpTF{
            datePickerValues(textField: pickUpTF)
        } else if textField == deliveryTF{
            datePickerValues(textField: deliveryTF)
        }
    }
    @objc func myTargetFunction(textField: UITextField) {
        
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Get the current text in the text field
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return true
    }
    
    
    @objc func textFieldDidChange(_ textField: UITextField) {        
        if textField == nightsTxtFld {
           nightVal = (Int(nightsTxtFld.text ?? "") ?? 0)
            self.getProductData()
        }else{
            nightVal = (Int(nightTxtForDelivery.text ?? "") ?? 0)
            clicktext = 1
            self.getProductData()
        }
    }
}

extension EnterDetailsVC : CountryPickerViewDelegate{
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        let title = "Selected Country"
        let message = "Name: \(country.name) \nCode: \(country.code) \nPhone: \(country.phoneCode) \nPhone: \(country.flag)"
        cntryCdLbl.text = country.phoneCode
        deliveryCountryCode.text = country.phoneCode
    }
    
}


//MARK: - Location
extension EnterDetailsVC: LocationPickerDelegate, LocationPickerDataSource {
    func numberOfAlternativeLocations() -> Int {
        return historyLocationList.count
        
    }
    
    func alternativeLocation(at index: Int) -> LocationItem {
        return historyLocationList.reversed()[index]
        
    }
    
    func showLocation(locationItem: LocationItem) {
        lat = locationItem.coordinate?.latitude ?? 0.0
        long = locationItem.coordinate?.longitude ?? 0.0
        print(lat)
        print(long)
        addressTxtFld.text = locationItem.name + "," + locationItem.formattedAddressString!
        
    }
    
    func storeLocation(locationItem: LocationItem) {
        if let index = historyLocationList.firstIndex(of: locationItem) {
            historyLocationList.remove(at: index)
        }
        historyLocationList.append(locationItem)
    }
    
    func locationDidSelect(locationItem: LocationItem) {
        print("Select delegate method: " + locationItem.name)
    }
    
    func locationDidPick(locationItem: LocationItem) {
        showLocation(locationItem: locationItem)
        storeLocation(locationItem: locationItem)
    }
    func convertToUTC(dateToConvert:String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        let convertedDate = formatter.date(from: dateToConvert)
        formatter.timeZone = TimeZone(identifier: "UTC")
        return formatter.string(from: convertedDate!)
        
    }
    
}


import UIKit
import LocationPickerViewController

class CustomLocationAddProductss: LocationPicker {
    
    var viewController: EnterDetailsVC!
    
    override func viewDidLoad() {
        super.addBarButtons()
        super.viewDidLoad()
    }
    
    @objc override func locationDidSelect(locationItem: LocationItem) {
        print("Select overrided method: " + locationItem.name)
        
    }
    
    @objc override func locationDidPick(locationItem: LocationItem) {        
        viewController.showLocation(locationItem: locationItem)
        viewController.storeLocation(locationItem: locationItem)
    }
    
}


extension Double {
    func convertToAppropriateType() -> Any {
        if self.truncatingRemainder(dividingBy: 1) == 0 {
            return Int(self)
        } else {
            return self
        }
    }
}
