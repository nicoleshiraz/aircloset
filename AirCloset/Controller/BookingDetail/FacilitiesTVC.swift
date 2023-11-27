//
//  FacilitiesTVC.swift
//  AirCloset
//
//  Created by cql200 on 23/05/23.
//

import UIKit

class FacilitiesTVC: UITableViewCell {

   
    @IBOutlet weak var dryCleaningVw: UIView!
    @IBOutlet weak var pickUpView: UIView!
    @IBOutlet weak var expressShippingVw: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
