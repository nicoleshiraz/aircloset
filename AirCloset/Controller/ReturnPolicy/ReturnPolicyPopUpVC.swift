//
//  ReturnPolicyPopUpVC.swift
//  AirCloset
//
//  Created by cql105 on 25/04/23.
//

import UIKit
//Mark:--> Protocol
protocol ReturnPolicyProtocol{
    func removeReturnPolicyPop(address : Int, productData : ProductDetailModel?)
}
class ReturnPolicyPopUpVC: UIViewController {
    
    //Mark:--> Variables
    var productData : ProductDetailModel?
    var removeReturnPolicyObj : ReturnPolicyProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    //Mark:--> Actions
    @IBAction func tapCloseBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapPayNowBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: {
            self.removeReturnPolicyObj?.removeReturnPolicyPop(address: 1, productData: self.productData)
        })
    }

    @IBAction func tapRateReturnPolicyBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: {
            self.removeReturnPolicyObj?.removeReturnPolicyPop(address: 1, productData: self.productData)
        })
    }
}
