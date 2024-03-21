//
//  ViewReceiptVC.swift
//  AirCloset
//
//  Created by cqlnitin on 16/04/23.
//

import UIKit

class ViewReceiptVC: UIViewController {
    
    @IBOutlet weak var shippingView: UIView!
    @IBOutlet weak var shippingLbl: UILabel!
    @IBOutlet weak var lblBond: UILabel!
    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var serviceChargeLbl: UILabel!
    @IBOutlet weak var priceLblwithTotalNt: UILabel!
    @IBOutlet weak var totalPriceOfTotalNtLbl: UILabel!
    @IBOutlet weak var pickUpDateLbl: UILabel!
    @IBOutlet weak var returnDateLbl: UILabel!
    @IBOutlet weak var totalPriceLbl: UILabel!
    
    var cardListVwModel = AddNewCardvwModel()
    var oderID = String()
    var comeFrom = "checkOut"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getBookingData()
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.tabBarController?.tabBar.isHidden = true
    }
    
    //------------------------------------------------------
    
    //MARK: Actions
    
    @IBAction func btnCancellation(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AirClosetWorksVC") as! AirClosetWorksVC
        vc.isComeFrom = 4
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnContactUs(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ContactUsVC") as! ContactUsVC
        vc.comesFrom = "ViewRecipet"
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func btnHelpCenter(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AirClosetWorksVC") as! AirClosetWorksVC
        vc.isComeFrom = 1
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tapBackBtn(_ sender: UIButton) {
        if comeFrom != "order" {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
            vc.selectedIndex = 0
            self.navigationController?.pushViewController(vc, animated: false)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
}


extension ViewReceiptVC {
    private func getBookingData() {
        cardListVwModel.getRecipt(productId: Singletone.shared.productId ?? "") { [weak self] in
            self?.productNameLbl.text = (self?.cardListVwModel.reciptData?.productName ?? "").capitalizeFirstLetter()
            self?.serviceChargeLbl.text = "$ \((self?.cardListVwModel.reciptData?.serviceCharge ?? 0).formattedString)"
//            self?.serviceChargeLbl.text = "$ 3"
            self?.priceLblwithTotalNt.text = "Price: $ \(self?.cardListVwModel.reciptData?.productPrice ?? 0) × \(self?.cardListVwModel.reciptData?.totalDays ?? 0) Nights".removingPercentEncoding
            let serviceCharges = Int((self?.cardListVwModel.reciptData?.serviceCharge ?? 0.0))
//            let serviceCharges = Int(3)
            let shippingg = Int((self?.cardListVwModel.reciptData?.shipping ?? Int(0.0)))
            let totall = (self?.cardListVwModel.reciptData?.productPrice ?? 0) * (self?.cardListVwModel.reciptData?.totalDays ?? 0)
            if (self?.cardListVwModel.reciptData?.orderType ?? 0) == 0 {
                self?.totalPriceOfTotalNtLbl.text = "$ \(totall)".removingPercentEncoding
                self?.shippingView.isHidden = true
            } else {
                self?.totalPriceOfTotalNtLbl.text = "$ \(totall)".removingPercentEncoding
                self?.shippingView.isHidden = false
            }
            self?.pickUpDateLbl.text = self?.cardListVwModel.reciptData?.pickupDate ?? ""
            self?.returnDateLbl.text = self?.cardListVwModel.reciptData?.returnDate ?? ""
            var total = Double(self?.cardListVwModel.reciptData?.totalPrice ?? 0) + (self?.cardListVwModel.reciptData?.serviceCharge ?? 0.0)
            
            total = total - Double((self?.cardListVwModel.reciptData?.deposit ?? Int(0.0)))
            
//            var total = Double(self?.cardListVwModel.reciptData?.totalPrice ?? 0) + 3.0
            self?.totalPriceLbl.text = "$ \(Int(total))"
            self?.shippingLbl.text = "$ \(self?.cardListVwModel.reciptData?.shipping ?? 0)"
            self?.lblBond.text = "$ \(self?.cardListVwModel.reciptData?.deposit ?? 0)"
            self?.lblBond.isHidden = false
        }
    }
}
