//
//  SellerViewModel.swift
//  AirCloset
//
//  Created by cqlios3 on 24/07/23.
//

import Foundation

class SellerViewModel {
    
    var sellerData: SellerProfileModelBody?
    var subscribeData: SubscribeBody?
    var ratingUser: String?
    //MARK: Api Call
    
    func sellerProfile(params: [String:Any],onSuccess: @escaping(()->())) {
        WebService.service(.sellerProfile ,param: params, service: .post) { (modelData : SellerProfileModel, data, json) in
            if let data = modelData.body {
                self.sellerData = data
            }
            if let dictionary = json as? [String: Any],
               let body = dictionary["body"] as? [String: Any],
               let createBooking = body["userData"] as? [String: Any],
               let bookingDate = createBooking["rating"] as? Int {
                self.ratingUser = "\(bookingDate)"
            }
            onSuccess()
        }
    }
    
    func suscribeUser(params: [String:Any],onSuccess: @escaping(()->())) {
        WebService.service(.suscribe ,param: params, service: .post) { (modelData : Subscribe, data, json) in
            if let data = modelData.body {
                self.subscribeData = data
            }
            onSuccess()
        }
    }
    
}
