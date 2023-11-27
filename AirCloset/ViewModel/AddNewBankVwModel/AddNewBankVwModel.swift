//
//  AddNewBankVwModel.swift
//  AirCloset
//
//  Created by cql200 on 14/06/23.
//

import Foundation

class AddNewBankVwModel : NSObject{
    
    var onSuccess : successResponse?
    var bankListInfo : GetBankListDetailModel?
    var defaultBankInfo : GetBankListDetailModelBody?
    
    func addNewBankApi(accountHolderName : String ,bankName : String,accountNumber : String,ifscCode : String){
        
        let param = ["accountHolderName" : accountHolderName,"bankName" : bankName,"accountNumber" : accountNumber,"ifscCode" : ifscCode]
        WebService.service(.addNewBank,param: param, service: .post, showHud: true) { (bankData : AddNewBankModel, data, json) in
            self.onSuccess?()
        }
    }
    
    func getBankListDetailApi(onSuccess:@escaping(()->Void)){
        
        let param = ["userId": Store.userDetails?.body?.id ?? ""]
        WebService.service(.bankListdetail, param: param, service: .post, showHud: true) { (bankListData : GetBankListDetailModel, data, json) in
            self.bankListInfo = bankListData
            onSuccess()
           // self.onSuccess?()
        }
    }
    
    func setDefaultBankApi(stripeBankAccountId : String){
        let param = ["stripeBankAccountId" : stripeBankAccountId]
        WebService.service(.setDefaultBank, param: param, service: .post, showHud: true) { (defaultBankData : GetBankListDetailModelBody , data, json) in
        self.defaultBankInfo = defaultBankData
        self.onSuccess?()
            
        }
    }
    
    
    func deleteBankApi(stripeBankAccountId : String){
        let param = ["stripeBankAccountId" : stripeBankAccountId]
        WebService.service(.deletebank, param: param, service: .delete, showHud: true) { (Dataa : CommonModel, data, json) in
            self.onSuccess?()
        }
    }

}
