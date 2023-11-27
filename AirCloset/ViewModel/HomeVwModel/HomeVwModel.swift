//
//  HomeVwModel.swift
//  AirCloset
//
//  Created by cql200 on 18/05/23.
//

import Foundation
import UIKit

class HomeVwModel : NSObject{
    var onSuccess : successResponse?
    var homeInfoModel : HomeModel?

//    func homeDataApi(type : Int){
//        let param = ["type" : type]


//        WebService.service(.homeData, param: param, service: .post, showHud: true) { (homeData : HomeModel, data, json) in
//            self.homeInfoModel = homeData
//            self.onSuccess?()
//        }
//    }
    
    
    func homeDataApi(type : Int,price : Int,brandId : String,sizeId: String,colorId : String,minimum : Int, maximum : Int){
        var param = ["type" : type] as [String : Any]
        
        if price != 0{
             param["price"] = price
        }
        
        if brandId != ""{
            param["brandId"] = brandId
        }
        
        if sizeId != ""{
            param["sizeId"] = sizeId
        }
             
        if colorId != ""{
            param["colorId"] = colorId
        }
//        if minimum != 0{
//            param["minimum"] = minimum
//        }
        
        if minimum < 0 {
            
        }
        else {
            param["minimum"] = minimum
        }
        
        
        if maximum != 0{
            param["maximum"] = maximum
        }
        param["lat"] = "\(Store.lat ?? 0.0)"
        param["long"] = "\(Store.long ?? 0.0)"

//        if minimum != 0 && maximum != 0{
//
//        }

            WebService.service(.homeData, param: param, service: .post, showHud: true) { (homeData : HomeModel, data, json) in
                print(param)
                self.homeInfoModel = homeData
                self.onSuccess?()
            }
        }

    func addfavorites(type :Int,productId : String,onSuccess:@escaping()->Void){
        let param = ["type" : type, "productId" : productId] as [String : Any]
        WebService.service(.addFavorite,param: param, service: .post, showHud: true) { (addFavoriteData : AddFavoritesModel,data ,json ) in
            print(addFavoriteData)
            onSuccess()
            
        }
    }
    
}
