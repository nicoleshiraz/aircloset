//
//  ChatData.swift
//  AirCloset
//
//  Created by cqlios3 on 25/07/23.
//

import Foundation

// MARK: - AllUserElement
struct AllUser: Codable {
    var chatID, receiverID, name, image, blockedByMessage: String?
    var lastMessage: LastMessage?
    var isBlocked: Bool?
    var unreadCount: Int?

    enum CodingKeys: String, CodingKey {
        case chatID = "chatId"
        case receiverID = "receiverId"
        case name, image, lastMessage, isBlocked, blockedByMessage, unreadCount
    }
}

// MARK: - LastMessage
struct LastMessage: Codable {
    var messageType: Int?
    var data, date: String?
}

// MARK: - Message
struct Message: Codable {
    var chatID, name, image: String?
    var messageType: Int?
    var message: MessageClass?
    var date: String?

    enum CodingKeys: String, CodingKey {
        case chatID = "chatId"
        case name, image, messageType, message, date
    }
}

// MARK: - MessageClass
struct MessageClass: Codable {
    var type, data: String?
}


// MARK: - AllMessage
struct AllMessage: Codable {
    var messageID, chatID, name, image: String?
    var messageType: Int?
    var message: Message2?
    var date: String?

    enum CodingKeys: String, CodingKey {
        case messageID = "messageId"
        case chatID = "chatId"
        case name, image, messageType, message, date
    }
}

// MARK: - Message
struct Message2: Codable {
    var type, data: String?
}
typealias AllMessages = [AllMessage]
