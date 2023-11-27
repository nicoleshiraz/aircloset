//
//  SenderTVCell.swift
//  AirCloset
//
//  Created by cql105 on 05/04/23.
//

import UIKit

class SenderTVCell: UITableViewCell {
    
    @IBOutlet weak var btnViewProfileSender: UIButton!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var userImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userImg.roundedImage()
    }
    
    func setMessageData(message: AllMessage, recieverImage: String) {
        userImg.imageLoad(imageUrl: "\(imageURL)\(recieverImage)")
        lblMessage.text = message.message?.data ?? ""
    }
    
}
