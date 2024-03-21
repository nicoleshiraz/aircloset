

//
//  SocketIOManager.swift
//  Capturise
//
//  Created by apple on 25/02/20.
//  Copyright © 2020 apple. All rights reserved.
//

import Foundation
import SocketIO
import SwiftyJSON

//var messageCount

protocol SocketDelegate {
    func listenedData(data: JSON, response: String)
}

class SocketIOManager: NSObject {
    
    var onSuccess:(successResponse)?
    static let sharedInstance = SocketIOManager()
        
    var manager : SocketManager?
    var delegate: SocketDelegate?
    var socket: SocketIOClient!
    
    override init() {
        super.init()
        manager = SocketManager(socketURL: URL(string:SocketKeys.socketBaseUrl.instance)!, config: [.log(true),.compress,.extraHeaders(["authorization": Store.authKey ?? ""])])
        guard let manager = manager else {return}
        socket = manager.defaultSocket
        defaultHandlers()
    }
    
    func establishConnection(){
        if self.socket.status != .connected{
            self.socket.connect()
        }
    }
    
    func isConnected() ->Bool{
        if self.socket.status == .connected{
            return true
        }
        else{
            return false
        }
    }
    
    func defaultHandlers() {
        socket.on(clientEvent: .statusChange) {data, ack in
            self.socket.on(clientEvent: .reconnect) {data, ack in
                print("Reconnected")
            }
            print("Status Change")
        }
        
        socket.on(SocketListeners.countStatus.instance){ data, ack in
            self.delegate?.listenedData(data: JSON(data), response: "SocketListeners.countStatus.instance")
            do{
                let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
                let newMszs = try JSONDecoder().decode(CountModel.self, from: jsonData)
            }catch{
                print("Error \(error)")
            }
            print(data,"hgddfdffhff")
        }
        
        socket.on(clientEvent: .connect) {data, ack in
            print("socket connected")
            self.connectUser()
            self.connect_user_listener()
        }
        
        socket.on(clientEvent: .reconnectAttempt) {data, ack in
            print("ReConnect Attempt")
        }
        
        socket.on(clientEvent: .error) {data, ack in
            print("error")
            self.establishConnection()
        }
        
        socket.on(clientEvent: .disconnect) {data, ack in
            print("Disconnect")
        }
    }
    
    //MARK: - Close socket connection
    
    func closeConnection() {
        socket.disconnect()
    }
    
    //MARK: - Method to update the auth token
    
    func updateAuthToken(_ authToken: String) {
         guard let manager = manager else { return }
         manager.config = SocketIOClientConfiguration(arrayLiteral: .compress, .extraHeaders(["authorization": authToken]))
         socket.disconnect()
         socket = manager.defaultSocket
         defaultHandlers()
     }
}
    
extension SocketIOManager {
    
    //MARK: - Connect user
    
    func connectUser(){
        socket.emit(SocketEmitters.connect_user.instance)
    }
    
    func connect_user_listener(){
        socket.on(SocketListeners.connect_listener.instance){arrOfAny, ack in
            print("User Connected Successfully")
            NotificationCenter.default.post(name: Notification.Name("socketConnected"), object: nil, userInfo: nil)
        }
    }
    
    func createChat(receiverID: String){
        let param: parameter = ["receiverId": receiverID]
        socket.emit(SocketEmitters.createChat.instance, param)
    }
    
    func createChatListener(receiverID: String){
        socket.on(SocketListeners.createChat.instance){response, ack in
            print(response)
        }
    }
    
    
    func newChat(){
        socket.on(SocketListeners.newChat.instance){response, ack in
            print(response)
        }
    }
    
    
    //MARK: - Get MessageList
    
    func messageListing() {
        let param: parameter = [SocketKeys.userId.instance: Store.userDetails?.body?.id ?? 0]
        socket.emit(SocketEmitters.chat_listing.instance,param)
    }
    
    func messageListingListener(onSuccess: @escaping(_ messageInfo:[AllUser]) -> Void) {
        socket.on(SocketListeners.chat_listing.instance) { arrOfAny, ack  in
            do{
                let jsonData = try JSONSerialization.data(withJSONObject: arrOfAny[0], options: [])
                let newMszs = try JSONDecoder().decode([AllUser].self, from: jsonData)
                onSuccess(newMszs)
            }catch{
                print("Error \(error)")
            }
            
        }
    }
    
    //MARK: - Send Message
    func sendMessageEmitter(receiverId:String, message: [String:Any]) {
        socket.emit(SocketEmitters.send_message.instance, message)
    }
    
    func send_Message_Listnener(onSuccess: @escaping(_ messageInfo:AllMessage) -> Void) {
        socket.off(SocketListeners.send_message_listner.instance)
        socket.on(SocketListeners.send_message_listner.instance) { response, act in
            do{
                let jsonData = try JSONSerialization.data(withJSONObject: response[0], options: [])
                let newMszs = try JSONDecoder().decode(AllMessage.self, from: jsonData)
                onSuccess(newMszs)
            }catch{
                print("Error \(error)")
            }
        }
    }
    
    //MARK: - Recieve message listner
    
    func recieveMessage(onSuccess: @escaping(_ messageInfo:AllMessage) -> Void) {
        socket.off(SocketListeners.recievemessage.instance)

        socket.on(SocketListeners.recievemessage.instance) { response, act in
            do{
                let jsonData = try JSONSerialization.data(withJSONObject: response[0], options: [])
                let newMszs = try JSONDecoder().decode(AllMessage.self, from: jsonData)
                onSuccess(newMszs)
            }catch{
                print("Error \(error)")
            }
        }
    }

    //MARK: - Get All previous chat
    
    func myChatListing(receiverId:String) {
        let param: parameter = [SocketKeys.receiverId.instance: receiverId]
        socket.emit(SocketEmitters.get_message.instance, param)

    }
    
    func get_All_Chat_Listner(onSuccess: @escaping(_ messageInfo:[AllMessage]) -> Void){
        socket.off(SocketListeners.my_chat.instance)
        socket.on(SocketListeners.my_chat.instance){ messageList, ack in

            do{
                let jsonData = try JSONSerialization.data(withJSONObject: messageList[0], options: [])
                let newMszs = try JSONDecoder().decode([AllMessage].self, from: jsonData)
                onSuccess(newMszs)
            }catch{
                print("Error \(error)")
            }
        }
    }
    
    //MARK: - Delete Chat History
    func clearChat(receiverId:String) {
        let param: parameter = [SocketKeys.receiverId.instance : receiverId ]
        socket.emit(SocketEmitters.delete_chat.instance, param)
    }
    
    func delete_Chat_listener(onSuccess: @escaping(()->())){
        socket.on(SocketListeners.delete_data.instance){arrOfAny, ack in
            onSuccess()
        }
    }
    
    //MARK: - Block Unblock
    
    func blockUserEmitter(receiverId: String) {
        let param: parameter = [SocketKeys.receiverId.instance: receiverId]
        socket.emit(SocketEmitters.block_user.instance, param)
    }
    
    func blockUserListner(onSuccess: @escaping(_ msg: String) -> Void){
        socket.on(SocketListeners.block_unblock.instance){ data, ack in
            if let data = data[0] as? [String:Any]{
                if let msg = data["message"] as? String{
                    onSuccess(msg)
                }
            }
        }
    }

    func blockUserListner2(onSuccess: @escaping(_ msg: String , _ status: Int) -> Void){
        socket.on(SocketListeners.blockNotifier.instance){ data, ack in
            if let data = data[0] as? [String:Any]{
                if let status = data["isBlocked"] as? Int{
                    let msg = data["message"] as? String ?? ""
                    onSuccess(msg, status)
                }
            }
        }
    }
    
    func blockUserListner3(onSuccess: @escaping(_ msg: String , _ status: Int) -> Void){
        socket.on(SocketListeners.errorNotifyer.instance){ data, ack in
            print(ack)
            if let data = data[0] as? [String:Any]{
                CommonUtilities.shared.showSwiftAlert(message: data["message"] as? String ?? "", isSuccess: .error)
//                if let status = data["isBlocked"] as? Int{
//                    let msg = data["message"] as? String ?? ""
//                    onSuccess(msg, status)
//                }
            }
        }
    }
    
    //MARK: - Report user
    
    func reportUserEmitter(receiverId: String,comment:String) {
        let param: parameter = [SocketKeys.receiverId.instance: receiverId ,SocketKeys.message.instance:comment]
        socket.emit(SocketEmitters.report_user.instance, param)
    }
        
    func reportUserListner(onSuccess: @escaping(_ msg: String) -> Void){
        socket.on(SocketListeners.report_user.instance){ data, ack in
            if let data = data[0] as? [String:Any]{
                if let msg = data["message"] as? String{
                    onSuccess(msg)
                }
            }
        }
    }
    
    //MARK: - message count
    
    func countEmitter() {
//        let param: parameter = [SocketKeys.receiverId.instance: receiverId]
        socket.emit(SocketEmitters.countStatus.instance)
    }
        
    func countListner(onSuccess: @escaping(_ msg: String) -> Void){
        
    }
}
