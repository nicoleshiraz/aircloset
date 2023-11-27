//
//  BrandVM.swift
//  AirCloset
//
//  Created by cqlios3 on 14/09/23.
//

import Foundation

class BrandVM {
    
    //MARK: -> Api Call
    
    var brandData: [BrandModelBody]?
        
    func getBrands(onSuccess: @escaping(()->())) {
        WebService.service(.brandList ,param: [:], service: .get) { (modelData : BrandModel, data, json) in
            if let data = modelData.body {
                self.brandData = data
            }
            onSuccess()
        }
    }
    
}
