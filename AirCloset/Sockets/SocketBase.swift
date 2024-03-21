//
//  SocketBase.swift
//  FitnessApp
//
//  Created by anu on 02/06/23.
//

import Foundation

enum SocketKeys : String {
    
    case socketBaseUrl = "http://65.2.68.95:1434/" // Local
//    case socketBaseUrl = "http://192.168.1.222:1434/" // Local    
    
    case userId              = "user_id"
    case senderId            = "sender_id"
    case receiverId          = "receiverId"
    case userid              = "userid"
    case user2Id             = "user2Id"
    case status              = "status"
    case group_id            = "group_id"
    case message_type        = "message_type"
    case message             = "message"
    case Image               = "Image"
    case groupId             = "groupId"
    case bookingid           = "bookingid"
    case live_lat            = "latitude"
    case live_long           = "longitude"
    case ext                 = "extension"
    case user2_id            = "user2_id"
    case comments            = "comments"
    case stylist_user_id     = "stylist_user_id"
    case userIDBy            = "userby"
    case useridTO            = "userto"


    var instance : String {
        return self.rawValue
    }
}

enum SocketEmitters:String{
    
    case disconnect_user          = "disconnect_user"
    case chat_listing             = "getchats"
    case connect_user             = "connect_user"
    case send_message             = "send-message"
    case get_message              = "get-messages-list"
    case report_user              = "report-user"
    case block_user               = "bolck-user"
    case delete_chat              = "clear-messages"
    case mute_notification        = "mute_notification"
    case get_group_messages       = "get_group_messages"
    case live_location_track      = "tracking_user"
    case block_status             = "block_status"
    case user_booking_data        = "user_booking_data"
    case createChat               = "create-chat"
    case blockNotifier            = "message"
    case countStatus              = "get-unreaded-message-count"
    
    var instance : String {
        return self.rawValue
    }
}

enum SocketListeners:String{
    
    case disconnect_listener      = "disconnect_listener"
    case chat_listing             = "myChat"
    case send_message_listner     = "send-message-status"
    case connect_listener         = "connectListenerr"
    case my_chat                  = "messages-list"
    case report_data              = "report_data"
    case delete_data              = "clear-messages-status"
    case block_data               = "block_data"
    case mute_notification_data   = "mute_notification_data"
    case get_group_messages       = "get_group_messages"
    case live_location_final      = "live_location_final"
    case block_status             = "block_status"
    case block_unblock            = "block-user-status"
    case report_user              = "report-user-status"
    case user_booking_data        = "user_booking_data"
    case createChat               = "chat-create-status"
    case recievemessage           = "receve-message"
    case blockNotifier            = "user-block-status-notifyer"
    case errorNotifyer            = "errorNotifyer"
    case newChat                  = "new-chat"
    case countStatus              = "get-unreaded-message-count-status"
    
    var instance : String {
        return self.rawValue
    }
    
}
