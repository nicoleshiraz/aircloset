//
//  ChatModel.swift
//  FitnessApp
//
//  Created by Anu on 09/06/23.
//

import Foundation

// MARK: - SingleMessageModelElement
struct SingleMessageModelElement: Codable {
    let id: Int?
    let senderName: String?
    let message: String?
    let senderID, senderImage: String?
    let receiverName: String?
    let receiverID: Int?
    let receiverImage, createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case senderName = "SenderName"
        case message
        case senderID = "Sender_ID"
        case senderImage = "SenderImage"
        case receiverName = "ReceiverName"
        case receiverID = "ReceiverId"
        case receiverImage = "ReceiverImage"
        case createdAt, updatedAt
    }
}

typealias SingleMessageModel = [SingleMessageModelElement]


// MARK: - RecieveAllUserChat
struct RecieveAllUserChat: Codable {
    let id, senderID, receiverID, lastMsgID: Int?
    let deletedID, userID, count, otherUserID: Int?
    let userName, userImage, lastMessage, lastMessageCreated, receiverName, receiverImage, senderImage, senderName : String?
    
    
    enum CodingKeys: String, CodingKey {
        case id, senderImage, senderName
        case senderID = "senderId"
        case receiverID = "receiverId"
        case lastMsgID = "lastMsgId"
        case deletedID = "deletedId"
        case userID = "userId"
        case count
        case receiverImage
        case receiverName
        case otherUserID = "other_user_id"
        case userName, userImage, lastMessage, lastMessageCreated
    }
}

typealias RecieveAllUserChats = [RecieveAllUserChat]

// MARK: - GetChatListElement
struct GetChatListElement: Codable {
    let id: Int?
    let senderName, message: String?
    let senderID: Int?
    let senderImage, receiverName: String?
    let receiverID: Int?
    let receiverImage, createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case senderName = "SenderName"
        case message
        case senderID = "Sender_ID"
        case senderImage = "SenderImage"
        case receiverName = "ReceiverName"
        case receiverID = "ReceiverId"
        case receiverImage = "ReceiverImage"
        case createdAt, updatedAt
    }
}

typealias GetChatList = [GetChatListElement]


// MARK: - GetSingleMsg
struct GetSingleMsg: Codable {
    let senderID, receiverID: Int?
    let message,receiverImage, createdAt: String?

    enum CodingKeys: String, CodingKey {
        case senderID = "senderId"
        case receiverID = "receiverId"
        case message, receiverImage, createdAt
    }
}

typealias GetSinglemsg = [GetSingleMsg]
