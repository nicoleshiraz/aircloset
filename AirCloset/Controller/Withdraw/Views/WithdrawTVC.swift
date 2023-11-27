//
//  WithdrawTVC.swift
//  AirCloset
//
//  Created by cqlnitin on 14/04/23.
//

import UIKit

class WithdrawTVC: UITableViewCell {
    //Mark:--> Outlets
    @IBOutlet weak var withImgVw: UIImageView!
    @IBOutlet weak var withTitleLbl: UILabel!
    @IBOutlet weak var withDescLbl: UILabel!
    @IBOutlet weak var withDollarLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setData(listData: WalletModelGetTransactionDetail) {
        withTitleLbl.text = listData.name?.capitalizeFirstLetter()
        withDescLbl.text = listData.paymentMethod == 0 ? "Amount Added" : "Withdraw"
        
        if listData.paymentMethod == 0 {
            withImgVw.image = UIImage(named: "greenEllipse")
        } else {
            withImgVw.image = UIImage(named: "greenEllipse 1")
        }
        
        withDollarLbl.text = "$\(listData.amount ?? 0)"
    }
}
