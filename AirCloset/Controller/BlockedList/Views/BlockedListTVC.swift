//
//  BlockedListTVC.swift
//  AirCloset
//
//  Created by cqlnitin on 13/04/23.
//

import UIKit

class BlockedListTVC: UITableViewCell {
    //Mark:--> Outlets
    @IBOutlet weak var blockImgVw: UIImageView!
    @IBOutlet weak var blockTitleLbl: UILabel!
    @IBOutlet weak var blockDescLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
