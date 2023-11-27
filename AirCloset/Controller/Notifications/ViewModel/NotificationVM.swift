//
//  NotificationVM.swift
//  AirCloset
//
//  Created by cqlios3 on 08/08/23.
//

import Foundation

class NotificationVM {
    
    //MARK: -> Api Call
    
    var notifData: [NotifModelBody]?
    
    func getNotif(onSuccess: @escaping(()->())) {
        WebService.service(.notifications ,param: [:], service: .post) { (modelData : NotifModel, data, json) in
            if let data = modelData.body {
                self.notifData = data.reversed()
            }
            onSuccess()
        }
    }
    
}
