//
//  FeedbackViewModel.swift
//  AirCloset
//
//  Created by cqlios3 on 24/07/23.
//

import Foundation

class FeedbackViewModel {
    
    //MARK: Api Call
    
    var sellerProfileNew: SellerProfileModellBody?
    var ratingData: [ReviewModelSingleProductBody]?
    
    func addRating(params: [String:Any],onSuccess: @escaping(()->())) {
        WebService.service(.addRateReview ,param: params, service: .post) { (modelData : CommonModel, data, json) in
            onSuccess()
        }
    }
    
    func getdetails(params: [String:Any],onSuccess: @escaping(()->())) {
        WebService.service(.sellerProfilee ,param: params, service: .get) { (modelData : SellerProfileModell, data, json) in
            if let data = modelData.body {
                self.sellerProfileNew = data
            }
            onSuccess()
        }
    }
    
    func getRatting(params: [String:Any],onSuccess: @escaping(()->())) {
        WebService.service(.rating ,param: params, service: .post) { (modelData : ReviewModelSingleProduct, data, json) in
            if let data = modelData.body {
                self.ratingData = data
            }
            onSuccess()
        }
    }
    
}
