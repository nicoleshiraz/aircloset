//
//  ContactVM.swift
//  AirCloset
//
//  Created by cqlios3 on 13/09/23.
//

import Foundation

class ContactVM {
    
    //MARK: -> Api Call
        
    func addDetails(params: [String:Any], onSuccess: @escaping(()->())) {
        WebService.service(.contactUss ,param: params, service: .post) { (modelData : CommonModel, data, json) in
            CommonUtilities.shared.showSwiftAlert(message: modelData.message ?? "", isSuccess: .success)
            onSuccess()
        }
    }
    
}
