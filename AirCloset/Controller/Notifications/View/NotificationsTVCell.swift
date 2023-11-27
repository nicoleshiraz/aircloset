//
//  NotificationsTVCell.swift
//  AirCloset
//
//  Created by cql105 on 04/04/23.
//

import UIKit

class NotificationsTVCell: UITableViewCell {

    //MARK: -> Outlets
    
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var notImgVw: CustomImageView!
    @IBOutlet weak var notTitleLbl: UILabel!
    @IBOutlet weak var notDescLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func notifData(notifData: NotifModelBody) {
        notImgVw.roundedImage()
        let notifDate = convertStrToDate(strDate: notifData.createdAt ?? "")
        if #available(iOS 13.0, *) {
            timeLbl.text = notifDate.timeAgoDisplay()
        } else {
            // Fallback on earlier versions
        }
        productImage.layer.cornerRadius = 5
        productImage.imageLoad(imageUrl: "\(imageURL)\(notifData.receiverID?.image ?? "")")
        notImgVw.imageLoad(imageUrl: "\(imageURL)\(notifData.senderID?.image ?? "")")
        notTitleLbl.text = notifData.productName?.capitalizeFirstLetter() ?? ""
        notDescLbl.text = notifData.message?.capitalizeFirstLetter() ?? ""
    }
    
}
