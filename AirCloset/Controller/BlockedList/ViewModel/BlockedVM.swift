//
//  BlockedVM.swift
//  AirCloset
//
//  Created by cqlios3 on 24/07/23.
//

import Foundation

class BlockedVM {
    
    //MARK: Api Call
    
    var blockedData: [BlockedListModelBody]?
    
    func getBlockedUsers(onSuccess: @escaping(()->())) {
        WebService.service(.getBlockUser ,param: [:], service: .get) { (modelData : BlockedListModel, data, json) in
            if let data = modelData.body {
                self.blockedData = data
            }
            onSuccess()
        }
    }
    
}
