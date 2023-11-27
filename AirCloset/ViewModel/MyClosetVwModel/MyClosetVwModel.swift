//
//  MyClosetVwModel.swift
//  AirCloset
//
//  Created by cql200 on 03/07/23.
//

import Foundation

class MyClosetVwModel : NSObject{
    
    var onSuccess : successResponse?
    var myClosetInfo : MyClosetModel?
    
    func getMyClosetApi(){
        
        WebService.service(.getMyClosetDetail, service: .get, showHud: true) { (myClosetData : MyClosetModel,data ,json ) in
            self.myClosetInfo = myClosetData
            self.onSuccess?()
        }
    }
    
}
