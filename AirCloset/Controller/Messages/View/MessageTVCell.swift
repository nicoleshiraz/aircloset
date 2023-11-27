//
//  MessageTVCell.swift
//  AirCloset
//
//  Created by cql105 on 31/03/23.
//

import UIKit

class MessageTVCell: UITableViewCell {
    //Mark:--> Outlets
    @IBOutlet weak var msgImgVw: UIImageView!
    @IBOutlet weak var msgTitleLbl: UILabel!
    @IBOutlet weak var msgDescLbl: UILabel!
    @IBOutlet weak var msgTimeLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
