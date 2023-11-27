//
//  AirClosetTVCell.swift
//  AirCloset
//
//  Created by cql105 on 03/04/23.
//

import UIKit

class AirClosetTVCell: UITableViewCell {
    
    //Mark:--> Outlets & Variables
    @IBOutlet weak var cosTableImgVw: CustomImageView!
    @IBOutlet weak var airClosetTitleLbl: UILabel!
    @IBOutlet weak var dotsBtn: UIButton!
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var cancelOrderBtn: UIButton!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var finishLabel: UILabel!
    @IBOutlet weak var editCancelView: CustomView!
    @IBOutlet weak var editCancelVwHgt: NSLayoutConstraint!
    @IBOutlet weak var viewReceiptBtn: UIButton!
    @IBOutlet weak var sizeLbl: UILabel!
    @IBOutlet weak var pricePrNtLbl: UILabel!
    @IBOutlet weak var descritptionLbl: UILabel!
    
    var isClickedd = Int()
    var editCallBack:(()->Void)?
    
    //Mark:--> View Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        isClickedd = 0
        editCancelView.isHidden = true
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    //Mark:--> Actions
    @IBAction func tapDotsBtn(_ sender: UIButton) {
        editCallBack?()
    }
}
