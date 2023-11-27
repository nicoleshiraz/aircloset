//
//  DeleteAccountModel.swift
//  AirCloset
//
//  Created by cql200 on 18/05/23.
//

import Foundation

struct DeleteAccountModel: Codable {
    
    var success : Bool?
    var code : Int?
    var message : String?
    var body : DeleteInfoBody?
    
}
struct DeleteInfoBody : Codable{
    var acknowledged : Bool?
    var deletedCount : Int?
    
    enum CodingKeys : String, CodingKey{
        case acknowledged
        case deletedCount
    }
}
