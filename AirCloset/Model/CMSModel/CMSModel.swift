//
//  CMSModel.swift
//  AirCloset
//
//  Created by cql200 on 10/05/23.
//

import Foundation

struct CMSModel : Codable {
    var success : Bool?
    var code : Int?
    var message : String?
    var body : CMSBody?
}

struct CMSBody : Codable{
    var id : String?
    var title : String?
    var content : String?
    var createdAt : String?
    var updatedAt : String?
    var v : Int?
    var type : Int?
    
    enum CodingKeys : String , CodingKey{
        case id = "_id"
        case title
        case content
        case createdAt
        case updatedAt
        case v = "__v"
        case type
    }
    
    init(from decoder: Decoder) throws {
                  do {
                      let values = try decoder.container(keyedBy: CodingKeys.self)
                      self.id = try values.decodeIfPresent(String.self, forKey: .id)
                      self.title = try values.decodeIfPresent(String.self, forKey: .title)
                      self.content = try values.decodeIfPresent(String.self, forKey: .content)
                      self.createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
                      self.updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
                      self.v = try values.decodeIfPresent(Int.self, forKey: .v)
                      self.type = try values.decodeIfPresent(Int.self, forKey: .type)
 
                  }
            catch {
                      debugPrint(error.localizedDescription)
                  }
}
}
