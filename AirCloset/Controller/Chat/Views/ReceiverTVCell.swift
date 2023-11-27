//
//  ReceiverTVCell.swift
//  AirCloset
//
//  Created by cql105 on 05/04/23.
//

import UIKit

class ReceiverTVCell: UITableViewCell {
    
    @IBOutlet weak var btnViewProfileReceiver: UIButton!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var userImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userImg.roundedImage()
    }
    
    func setMessageData(message: AllMessage) {
        userImg.imageLoad(imageUrl: "\(imageURL)\(Store.userDetails?.body?.image ?? "")")
        lblMessage.text = message.message?.data ?? ""
    }
}
