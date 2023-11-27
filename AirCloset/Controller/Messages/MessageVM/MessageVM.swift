//
//  MessageVM.swift
//  AirCloset
//
//  Created by cqlios3 on 25/07/23.
//

import UIKit
import Foundation

var userList2: [AllUser] = []

class MessageVM {
    
    var socket = SocketIOManager()
    var userList: [AllUser] = []
    
    func fetchChatDialogs(onSuccess: @escaping(()->())) {
        SocketIOManager.sharedInstance.messageListing()
        SocketIOManager.sharedInstance.messageListingListener { [weak self] messageDialogs in
            print(messageDialogs)
            self?.userList = messageDialogs
            userList2 = messageDialogs
            onSuccess()
        }
    }
}
