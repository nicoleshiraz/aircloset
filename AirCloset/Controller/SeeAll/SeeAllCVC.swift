//
//  SeeAllCVC.swift
//  AirCloset
//
//  Created by cql105 on 19/04/23.
//

import UIKit

class SeeAllCVC: UICollectionViewCell {
    // Mark :--> Outlets
    @IBOutlet weak var seeAllImgVw: UIImageView!
    @IBOutlet weak var productPriceLbl: UILabel!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var productSizeLbl: UILabel!
    @IBOutlet weak var heartBtn: UIButton!
    
    var suggestion: [Suggestion]?
    var basedOnLikes: [BasedOnLike]?
    
}
