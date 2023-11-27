//
//  InAppPurchase.swift
//  iChota
//
//  Created by Gaurav on 26/12/22.
//  Copyright © 2022 AppDeft. All rights reserved.
//

import UIKit
import StoreKit
import Foundation
import MBProgressHUD

enum PKIAPHandlerAlertType {
    case setProductIds
    case disabled
    case restored
    case purchased
    
    var message: String{
        switch self {
        case .setProductIds: return "Product ids not set, call setProductIds method!"
        case .disabled: return "Purchases are disabled in your device!"
        case .restored: return "You've successfully restored your purchase!"
        case .purchased: return "You've successfully bought this purchase!"
        }
    }
}

enum IAPProducts:String{
    case monthly = "com.stylist.plan.monthly"
}

class PKIAPHandler: NSObject {
    
    //MARK:- Shared Object
    static let shared = PKIAPHandler()
    var parentVC = UIViewController()
    
    private override init() { }
    
    //MARK: - Properties
    //MARK: - Private
    fileprivate var productIds = [IAPProducts.monthly.rawValue]
    fileprivate var productID = ""
    fileprivate var productsRequest = SKProductsRequest()
    fileprivate var fetchProductComplition: (([SKProduct])->Void)?
    
    fileprivate var productToPurchase: SKProduct?
    fileprivate var purchaseProductComplition: ((PKIAPHandlerAlertType, SKProduct?, SKPaymentTransaction?)->Void)?
    
    //MARK: - Public
    var isLogEnabled: Bool = true
    
    //MARK: - Methods
    //MARK: - Public
    
    //Set Product Ids
    func setProductIds(ids: [String]) {
        self.productIds = ids
    }
    
    //MARK: - PURCHASE OF A PRODUCT
    func canMakePurchases() -> Bool {  return SKPaymentQueue.canMakePayments()  }
    
    func purchase(product: SKProduct, complition: @escaping ((PKIAPHandlerAlertType, SKProduct?, SKPaymentTransaction?)->Void)) {
        self.purchaseProductComplition = complition
        self.productToPurchase = product
        if self.canMakePurchases() {
            let payment = SKPayment(product: product)
            SKPaymentQueue.default().add(self)
            SKPaymentQueue.default().add(payment)
            
            log("PRODUCT TO PURCHASE: \(product.productIdentifier)")
            productID = product.productIdentifier
        }
        else {
            complition(PKIAPHandlerAlertType.disabled, nil, nil)
        }
    }
    
    //MARK: - RESTORE PURCHASE
    
    func restorePurchase(){
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    
    //MARK: - FETCH AVAILABLE IAP PRODUCTS
    
    func fetchAvailableProducts(complition: @escaping (([SKProduct])->Void)){
        showLoader()
        self.fetchProductComplition = complition
        // Put here your IAP Products ID's
        if self.productIds.isEmpty {
            log(PKIAPHandlerAlertType.setProductIds.message)
            fatalError(PKIAPHandlerAlertType.setProductIds.message)
        }
        else {
            productsRequest = SKProductsRequest(productIdentifiers: Set(self.productIds))
            productsRequest.delegate = self
            productsRequest.start()
        }
    }
    
    func hideLoader(){
        DispatchQueue.main.async {
            if let vc = UIApplication.shared.keyWindow{
                MBProgressHUD.hide(for: vc, animated: true)
            }
        }
    }
    
    func showLoader(){
        DispatchQueue.main.async {
            if let vc = UIApplication.shared.keyWindow{
                MBProgressHUD.showAdded(to: vc, animated: true)
            }
        }
    }
    
    //MARK: - Private
    fileprivate func log <T> (_ object: T) {
        if isLogEnabled {
            NSLog("\(object)")
        }
    }
}

//MARK: - Product Request Delegate and Payment Transaction Methods
extension PKIAPHandler: SKProductsRequestDelegate, SKPaymentTransactionObserver{
    
    //MARK: - REQUEST IAP PRODUCTS
    func productsRequest (_ request:SKProductsRequest, didReceive response:SKProductsResponse) {
        hideLoader()
        if (response.products.count > 0) {
            if let complition = self.fetchProductComplition {
                complition(response.products)
            }
        }
    }
    
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        if let complition = self.purchaseProductComplition {
            complition(PKIAPHandlerAlertType.restored, nil, nil)
        }
    }
    
    //MARK: - IAP PAYMENT QUEUE
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction:AnyObject in transactions {
            if let trans = transaction as? SKPaymentTransaction {
                switch trans.transactionState {
                case .purchased:
                    log("Product purchase done")
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    hideLoader()
                    if let complition = self.purchaseProductComplition {
                        complition(PKIAPHandlerAlertType.purchased, self.productToPurchase, trans)
                    }
                    break
                    
                case .failed:
                    log("Product purchase failed")
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    hideLoader()
                    break
                case .restored:
                    log("Product restored")
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    hideLoader()
                    break
                    
                default: break
                }}}
    }
}
