//
//  WithdrawVC.swift
//  AirCloset
//
//  Created by cqlnitin on 14/04/23.
//

import UIKit

class WithdrawVC: UIViewController {
    
    //MARK: -> Outlets & Variables
    
    @IBOutlet weak var balanceLbl: UILabel!
    @IBOutlet weak var btnRefer: UIButton!
    @IBOutlet weak var btnWithdrawOutlet: CustomButton!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var withdrawTableVw: UITableView!
    @IBOutlet weak var userImage: CustomImageView!
    
    var withdrawImgAry = ["greenEllipse", "pinkEllipse","greenEllipse","pinkEllipse","greenEllipse"]
    var withdrawLblAry = ["John Marker","Bank Account","John Marker","Bank Account","Bank Account"]
    var withdrawDescLblAry = ["Received","Withdraw to HSBC Bank","Received","Withdraw to HSBC Bank","Withdraw to HSBC Bank",]
    
    var withdraw = WithdrawVM()
    
    //MARK: -> View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        withdrawTableVw.delegate = self
        withdrawTableVw.dataSource = self
        setData()
    }
    
    func setData() {
        getDetails()
        userImage.roundedImage()
        nameLbl.text = "Hello, \(Store.userDetails?.body?.name?.capitalizeFirstLetter() ?? "")"
        userImage.imageLoad(imageUrl: "\(imageURL)\(Store.userDetails?.body?.image ?? "")")
    }
    
    //MARK: -> Actions
    
    @IBAction func tapBackBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnReferTap(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReferVC") as! ReferVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tapAddMoneyBtn(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddMoneyVC") as! AddMoneyVC
        vc.callBack = {
            self.getDetails()
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tapWithdraw(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SavedAccVC") as! SavedAccVC
        vc.callBack = {
            self.getDetails()
        }
        vc.totalAmmount = self.withdraw.walletData?.response?.wallet ?? 0.0
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: -> DelegatesDataSources

extension WithdrawVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        withdrawTableVw.setEmptyData(msg: "No data found.", rowCount: withdraw.walletData?.getTransactionDetail?.count ?? 0)
        return withdraw.walletData?.getTransactionDetail?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = withdrawTableVw.dequeueReusableCell(withIdentifier: "WithdrawTVC", for: indexPath) as! WithdrawTVC
        if withdraw.walletData?.getTransactionDetail?.count ?? 0 > 0 {
            cell.setData(listData: (withdraw.walletData?.getTransactionDetail?[indexPath.row])!)
        }
        return cell
    }
}

extension WithdrawVC {
    
    private func getDetails() {
        withdraw.getWithdrawList { [weak self] in
            self?.balanceLbl.text = "\((self?.withdraw.walletData?.response?.wallet ?? 0).rounded(toPlaces: 0).formattedString) AUD"
            self?.withdrawTableVw.reloadData()
        }
    }
}



extension String {
//    func convertDateFormat() -> String? {
//        let dateFormatter = DateFormatter()
//
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
////        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
////        dateFormatter.locale = Locale.current
////        dateFormatter.timeZone = TimeZone.current
//
//        if let date = dateFormatter.date(from: self) {
//            dateFormatter.dateFormat = "yyyy-MM-dd h:mm a"
//            return dateFormatter.string(from: date)
//        } else {
//            return nil
//        }
//    }
    
    func convertDateFormat() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        if let date = dateFormatter.date(from: self) {
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.dateFormat = "yyyy-MM-dd h:mm a"
        
            return dateFormatter.string(from: date)
        }
        return nil
    }

}

