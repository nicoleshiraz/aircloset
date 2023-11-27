//
//  GetSingleOrderVwModel.swift
//  AirCloset
//
//  Created by cql200 on 04/07/23.
//

import Foundation

class GetSingleOrderVwModel : NSObject{
    
    var onSuccess : successResponse?
    var getSingleOrderModelInfo : GetSingleOrderModel?
    
    func getSingleOrderApi(id : String){
        let param = ["_id" : id]
        WebService.service(.getSingleOrderDeatil, param: param, service: .post, showHud: true) { (singleOrderData : GetSingleOrderModel, data, json) in
            self.getSingleOrderModelInfo = singleOrderData
            self.onSuccess?()
        }
    }
}
