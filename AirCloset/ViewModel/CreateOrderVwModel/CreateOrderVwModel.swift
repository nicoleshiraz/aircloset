//
//  CreateOrderVwModel.swift
//  AirCloset
//
//  Created by cql200 on 08/06/23.
//

import Foundation

class CreateOrderVwModel : NSObject{
    
    var onSuccess : successResponse?
    var createdorderDataInfo : CreateOrderModel?
    func createOrderApi(productId : String , startDate : String,countryCode :String, phoneNumber: String,endDate : String,address : String, type: Int , comesFrom: String,productID: String){
        var parms = [String:Any]()
        if comesFrom == "Edit" {
            parms = ["productId" : productId, "startDate" : startDate,"countryCode" : countryCode ,"phoneNumber" : phoneNumber,"endDate" : endDate, "address" : address,"orderType":type,"id" : productID, "isEdit": 2]
        } else {
            parms = ["productId" : productId, "startDate" : startDate,"countryCode" : countryCode ,"phoneNumber" : phoneNumber,"endDate" : endDate, "address" : address,"orderType":type, "isEdit": 1]
        }
        
        WebService.service(.createOrder, param: parms, service: .post, showHud: true) { (createOrderData : CreateOrderModel, data,json ) in
            CommonUtilities.shared.showSwiftAlert(message: createOrderData.message ?? "", isSuccess: .success)
            
            self.createdorderDataInfo = createOrderData
            productIdBooking = createOrderData.body?.id
            Singletone.shared.productId = createOrderData.body?.id
            self.onSuccess?()
        }
    }
}
