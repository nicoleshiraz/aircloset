//
//  ForgotPassModel.swift
//  AirCloset
//
//  Created by cql200 on 08/05/23.
//

import Foundation

struct CommonModel : Codable{
    let success : Bool?
    let code : Int?
    let message : String?
    let body : Body?
}

struct Body : Codable{
    
}


struct CountModel: Codable {
    let count: Int
}
