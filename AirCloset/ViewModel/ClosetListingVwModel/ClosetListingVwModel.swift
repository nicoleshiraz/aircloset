//
//  ClosetListingVwModel.swift
//  AirCloset
//
//  Created by cql131 on 20/06/23.
//

import Foundation

class ClosetListingVwModel : NSObject{
    
    var onSuccess : successResponse?
    var closetListingFavInfo : ClosetListingFavModel?
    var closetListingOrderByMeInfo : ClosetListingOrderByMeModel?
    var closetListingOrderByMeInfoo: [ClosetListingOrderByMeModelBody]?
    var closetListingOrderByOthersInfo : ClosetListingOderedByOtherModel?

    func getClosetListingApi(type : Int){
        
        if type == 0{
        let param = ["type" : type]
        WebService.service(.getclosetListing, param: param, service: .post, showHud: true) { (favListData : ClosetListingFavModel, data, json) in
            self.closetListingFavInfo = favListData
            self.onSuccess?()
        }
        }
        
        else if type == 1 {
            let param = ["type" : type]
            WebService.service(.getclosetListing, param: param, service: .post, showHud: true) { (orderByMe : ClosetListingOrderByMeModel, data, json) in
                self.closetListingOrderByMeInfo = orderByMe
                self.onSuccess?()
            }
        }
        else if type == 2 {
            let param = ["type" : type]
            WebService.service(.getclosetListing, param: param, service: .post, showHud: true) { (odredByOthers : ClosetListingOderedByOtherModel, data,json) in
                self.closetListingOrderByOthersInfo = odredByOthers
                self.onSuccess?()
            }
        }
    }
}
