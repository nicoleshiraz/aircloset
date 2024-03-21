//
//  ProductVwModel.swift
//  AirCloset
//
//  Created by cql200 on 19/05/23.
//

import Foundation

class ProductVwModel : NSObject{
    
    var productDetailInfo : ProductDetailModel?
    var onSuccess : successResponse?

    func getProductDetailApi(id : String){
        let param = ["_id" : id]
        WebService.service(.productDetail, param: param, service: .post, showHud: true) { (productDeatil : ProductDetailModel, data, json )in
         
            self.productDetailInfo = productDeatil
            self.onSuccess?()
        }
    }
    
    
    func pickOrder(paramss: [String:Any], onSuccessApi: @escaping (()->())){
        WebService.service(.pickOrder,param: paramss, service: .post, showHud: true) { (modelData : OrderCancel, data, json) in
            CommonUtilities.shared.showSwiftAlert(message: modelData.message ?? "", isSuccess: .success)
            if let data = modelData.body {
            }
            onSuccessApi()
        }
    }
    
    func returnCloth(paramss: [String:Any], onSuccessApi: @escaping (()->())){
        WebService.service(.returnClothes,param: paramss, service: .post, showHud: true) { (modelData : CommonModel, data, json) in
            CommonUtilities.shared.showSwiftAlert(message: modelData.message ?? "", isSuccess: .success)
            onSuccessApi()
        }
    }
    
    func returnProofCloth(paramss: [String:Any], onSuccessApi: @escaping (()->())){
        WebService.service(.returProof,param: paramss, service: .post, showHud: true) { (modelData : CommonModel, data, json) in
            CommonUtilities.shared.showSwiftAlert(message: modelData.message ?? "", isSuccess: .success)
            onSuccessApi()
        }
    }


}
