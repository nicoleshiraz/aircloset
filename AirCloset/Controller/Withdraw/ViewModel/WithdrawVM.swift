//
//  WithdrawVM.swift
//  AirCloset
//
//  Created by cqlios3 on 03/08/23.
//

import Foundation

class WithdrawVM {
    
    //MARK: Api Call
    
    var walletData: WalletModelBody?
    
    func getWithdrawList(onSuccess: @escaping(()->())) {
        WebService.service(.walletData ,param: [:], service: .get) { (modelData : WalletModel, data, json) in
            if let data = modelData.body {
                self.walletData = data
            }
            onSuccess()
        }
    }
    
    func withDrawAmmount(params: [String:Any] ,onSuccess: @escaping(()->())) {
        WebService.service(.withdrawlFromWallet ,param: params, service: .post) { (modelData : CommonModel, data, json) in
            onSuccess()
        }
    }
    
    func addBankAccount(params: [String:Any] ,onSuccess: @escaping(()->())) {
        WebService.service(.walletData ,param: params, service: .post) { (modelData : WalletModel, data, json) in
            if let data = modelData.body {
                self.walletData = data
            }
            onSuccess()
        }
    }
    
    func addMoney(params: [String:Any] ,onSuccess: @escaping(()->())) {
        WebService.service(.addPaymentToWalet ,param: params, service: .post) { (modelData : CommonModel, data, json) in
            onSuccess()
        }
    }
    
    func deleteProduct(params: [String:Any],onSuccessApi: @escaping(()->())) {
        WebService.service(.deleteCard ,param: params, service: .delete) { (modelData : CommonModel, data, json) in
            CommonUtilities.shared.showSwiftAlert(message: modelData.message ?? "", isSuccess: .success)
            onSuccessApi()
        }
    }
    
}
