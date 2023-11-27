//
//  SingletonClass.swift
//  AirCloset
//
//  Created by cql200 on 12/06/23.
//

import Foundation
import UIKit

class Singletone{
    
    static var shared = Singletone()
    
    var clothsTermsAndCon : String?
    var amount : Int?
    var cardId : String?
    var productId : String?
    var idProofImg : UIImageView?

    var brandFilter : String?
    var brandName : String?
    
    var colorFilter : String?
    var colorName : String?
    
    var sizeFilter : String?
    var sizeName : String?
    
    var priceFiler : Int?
    var minDistFilter : Int?
    var maxDistfilter : Int?
    var lat = Store.lat
    var long = Store.long


}
