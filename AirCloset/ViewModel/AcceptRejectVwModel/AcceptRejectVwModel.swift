//
//  AcceptRejectVwModel.swift
//  AirCloset
//
//  Created by cql200 on 06/07/23.
//

import Foundation

class AcceptRejectVwModel : NSObject{
    
    var onSuccess : successResponse?
    var acceptRejectInfo : AcceptRejectOrderModel?
    var cancelData: OrderCancelBody?
    
    func acceptRejectBookingApi(id : String, orderStatus : Int){
        let param = ["orderId": id,"status" : orderStatus] as [String : Any]
        
        WebService.service(.acceptRejectBooking,param: param, service: .post, showHud: true) { (acceptRejectData : AcceptRejectOrderModel, data, json) in
            self.acceptRejectInfo = acceptRejectData
            self.onSuccess?()
        }
    }
    
    func cancelBooking(paramss: [String:Any], onSuccessApi: @escaping (()->())){
        WebService.service(.cancelBooking,param: paramss, service: .post, showHud: true) { (modelData : OrderCancel, data, json) in
            CommonUtilities.shared.showSwiftAlert(message: modelData.message ?? "", isSuccess: .success)
            if let data = modelData.body {
                self.cancelData = data
            }
            onSuccessApi()
        }
    }
}
