//
//  ExploreCVC.swift
//  AirCloset
//
//  Created by cql105 on 05/04/23.
//

import UIKit
import SkeletonView

class ExploreCVC: UICollectionViewCell {
    // Mark :--> Outlets
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var exploreImgVw: UIImageView!
    @IBOutlet weak var heartBtn: UIButton!
    @IBOutlet weak var sizelTypeLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
   
    @IBOutlet weak var nameLbl: UILabel!
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setFavDataFor0(favData: Int) {
        if favData == 2 {
            heartBtn.isSelected = true
        } else{
            heartBtn.isSelected = false
        }
    }
    
    func setFavDataFor1(favData: Int) {
        if favData == 2 {
            heartBtn.isSelected = true
        } else{
            heartBtn.isSelected = false
        }
    }
    
}
