//
//  AddPostVwModel.swift
//  AirCloset
//
//  Created by cql200 on 24/05/23.
//

import Foundation
import UIKit
import SwiftUI
 
struct facilities{
    var facilities: Int?
    
}

class AddPostVwModel : NSObject {
    
    var catagoryInfo : CatagoryModel?
    var conditionInfo : ClothConditionModel?
    var colorInfo : ColorModel?
    var styleInfo : StyleModel?
    var brandInfo : BrandModel?
    var sizeInfo : SizeModel?
    var facilityInt : Int?
    
    var onSuccess : successResponse?

    func getCatagoryList(onsuccess:@escaping(()->())){
        WebService.service(.catagory, service: .get, showHud: true) { (catagoryDATA : CatagoryModel, data, json) in
            self.catagoryInfo = catagoryDATA
            onsuccess()

    }
    }
    
    func getConditionList(onsuccess:@escaping(()->())){
        WebService.service(.condition, service: .get, showHud: true) { (conditionDAta : ClothConditionModel, data, json) in
            self.conditionInfo = conditionDAta
            onsuccess()

    }
    }
    
    func getColorListApi(onsuccess:@escaping(()->())){
        WebService.service(.colorList, service: .get, showHud: true) { (colorData : ColorModel, data, json) in
            self.colorInfo = colorData
            onsuccess()
        }
 
    }
    
    func getStyleListApi(onsuccess:@escaping(()->())){
        WebService.service(.styleList, service: .get, showHud: true) { (styleData : StyleModel, data, json) in
            self.styleInfo = styleData
            onsuccess()
        }
    }
    
    
    func getBrandListApi(onsuccess:@escaping(()->())){
        WebService.service(.brandList, service: .get, showHud: true) { (brandData : BrandModel, data, json) in
            self.brandInfo = brandData
            onsuccess()
        }
    }

    func getSizeListApi(onsuccess:@escaping(()->())){
        WebService.service(.sizeList, service: .get, showHud: true) { (sizeData : SizeModel, data, json) in
            self.sizeInfo = sizeData
            onsuccess()
        }
    }
    
    
    func addPostApi(image : [UIImageView],video : ImageStructInfo,description : String,categoryId : String,brandId: String,sizeId : String,conditionId: String,price : Int,deposit: Int,colorId: String,styleId: String,facilities : AllFacilities ,shipping : Int,location : String,lat : String,long : String,id: String,type: String,thumbnaill: ImageStructInfo, name: String) {
        
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(facilities.self)
            let jsonString = String(data: jsonData, encoding: .utf8)
            guard let json = jsonString else{return}
            var uplodImageInfo = [ImageStructInfo]()
            for index in 0..<image.count{
                uplodImageInfo.append(ImageStructInfo.init(fileName: "Img\(image[index]).jpeg", type: "jpeg", data: (image[index].image?.toData())!, key: "image"))
            }
            
            var param = [String:Any]()
            if type == "1" {
                param = ["image" : uplodImageInfo,"description" : description,"categoryId": categoryId,"brandId": brandId,"sizeId": sizeId,"price" : price,"facilities" : json,"shipping" : shipping, "location": location,"lat" : lat,"long" : long,"isEdit":type,"isAvailable":1,"thumbnail":thumbnaill,"name":name] as [String : Any]
            } else {
                param = ["image" : uplodImageInfo,"description" : description,"categoryId": categoryId,"brandId": brandId,"sizeId": sizeId,"price" : price,"facilities" : json,"shipping" : shipping, "location": location,"lat" : lat,"long" : long,"isEdit":type,"isAvailable":2,"id":id,"thumbnail":thumbnaill,"name":name] as [String : Any]
            }
                param["video"] = video
            if styleId != "" {
                param["styleId"] = styleId
            }
            if colorId != "" {
                param["colorId"] = colorId
            }
            WebService.service(.productCreate, param: param, service: .post, showHud: true) { (addPostData :AddPostModel, data, json) in
                print(param)
                self.onSuccess?()
            }
        }catch {
            print("Error is---",error.localizedDescription)
        }
    }
    
    func addPostApiWithoutVideo(image : [UIImageView],description : String,termAndCondition : String,categoryId : String,brandId: String,sizeId : String,conditionId: String,price : Int,deposit: Int,colorId: String,styleId: String,facilities : AllFacilities ,shipping : Int,location : String,lat : String,long : String,id: String,type: String, name: String) {
        
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(facilities.self)
            let jsonString = String(data: jsonData, encoding: .utf8)
            guard let json = jsonString else{return}
            var uplodImageInfo = [ImageStructInfo]()
            for index in 0..<image.count{
                uplodImageInfo.append(ImageStructInfo.init(fileName: "Img\(image[index]).jpeg", type: "jpeg", data: (image[index].image?.toData())!, key: "image"))
            }
            var param = [String:Any]()
            if type == "1" {
                param = ["image" : uplodImageInfo,"description" : description,"termAddCondition" : termAndCondition,"categoryId": categoryId,"brandId": brandId,"sizeId": sizeId,"price" : price, "deposit"  : deposit,"facilities" : json,"shipping" : shipping, "location": location,"lat" : lat,"long" : long,"isEdit":type,"isAvailable":1,"thumbnail":"","name":name] as [String : Any]
            } else {
                param = ["image" : uplodImageInfo,"description" : description,"termAddCondition" : termAndCondition,"categoryId": categoryId,"brandId": brandId,"sizeId": sizeId,"price" : price, "deposit"  : deposit,"facilities" : json,"shipping" : shipping, "location": location,"lat" : lat,"long" : long,"isEdit":type,"isAvailable":2,"id":id,"thumbnail":"","name":name] as [String : Any]
            }
            
//            var param = ["image" : uplodImageInfo,"description" : description,"termAddCondition" : termAndCondition,"categoryId": categoryId,"brandId": brandId,"sizeId": sizeId, "conditionId" : conditionId,"price" : price, "deposit"  : deposit,"facilities" : json,"shipping" : shipping, "location": location,"lat" : lat,"long" : long,"isEdit":type,"isAvailable":1,"id":id] as [String : Any]
                param["video"] = ""
            if styleId != "" {
                param["styleId"] = styleId
            }
            if colorId != "" {
                param["colorId"] = colorId
            }
             print(param)
            WebService.service(.productCreate, param: param, service: .post, showHud: true) { (addPostData :AddPostModel, data, json) in
                print(param)
                self.onSuccess?()
            }
        }catch {
            print("Error is---",error.localizedDescription)
        }
    }

}
