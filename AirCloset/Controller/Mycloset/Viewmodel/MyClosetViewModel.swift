//
//  MyClosetViewModel.swift
//  AirCloset
//
//  Created by cqlios3 on 24/07/23.
//

import Foundation

class MyClosetViewModel {
    
    //MARK: Api Call
    
    func deleteProduct(params: [String:Any],onSuccess: @escaping(()->())) {
        WebService.service(.deleteProduct ,param: params, service: .delete) { (modelData : CommonModel, data, json) in
            onSuccess()
        }
    }
}
