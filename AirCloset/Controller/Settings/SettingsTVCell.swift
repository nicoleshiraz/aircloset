//
//  SettingsTVCell.swift
//  AirCloset
//
//  Created by cql105 on 07/04/23.
//

import UIKit

class SettingsTVCell: UITableViewCell {
    //Mark:--> Outlets
    @IBOutlet weak var settingsImgVw: UIImageView!
    @IBOutlet weak var settingsLbl: UILabel!
    @IBOutlet weak var toggleBtn: UIButton!
    @IBOutlet weak var notifyNextBtn: UIButton!
    @IBOutlet weak var vwBtn: UIView!
    @IBOutlet weak var referVw: UIView!
    @IBOutlet weak var referLbl: UILabel!
    @IBOutlet weak var refDescLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
