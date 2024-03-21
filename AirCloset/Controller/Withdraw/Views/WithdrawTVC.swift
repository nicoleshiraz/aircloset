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
    
    @IBOutlet weak var lblDateTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setData(listData: WalletModelGetTransactionDetail) {
        withTitleLbl.text = listData.name?.capitalizeFirstLetter()
        withDescLbl.text = listData.paymentProcess == 0 ? "Amount Added" : "Withdraw"
        if listData.paymentProcess == 0 {
            withImgVw.image = UIImage(named: "greenEllipse")
        } else {
            withImgVw.image = UIImage(named: "greenEllipse 1")
        }
        
        withDollarLbl.text = "$ \(Int(listData.amount ?? 0))"
        
        if let date = listData.createdAt?.convertDateFormat() {
            lblDateTime.text = date
        } else {
            print("Failed to convert string to date.")
        }
    }
}
