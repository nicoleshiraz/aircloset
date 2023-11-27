//
//  BlockedListVC.swift
//  AirCloset
//
//  Created by cqlnitin on 13/04/23.
//

import UIKit

class BlockedListVC: UIViewController {
    //MARK: -> Outlets & Variables
    @IBOutlet weak var blockedListTableVw: UITableView!
    @IBOutlet weak var buyerImgVw: CustomImageView!
    @IBOutlet weak var buyerBtn: UIButton!
    @IBOutlet weak var sellerImgVw: CustomImageView!
    @IBOutlet weak var sellerBtn: CustomButton!
    
    var listImgAry = ["brownHair","mask","msg","blockImg"]
    var listTitleAry = ["Stells Stefword","Samuel Joyce",
                        "Jenni Miranda","Elva Barker"]
    var listDescAry = ["You sent a sticker","Samuel sent a sticker",
                       "I like this version","Elva sent an attachment"]
    
    var blockedVM = BlockedVM()
    var userRole = 1
    //MARK: -> View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        sellerImgVw.isHidden = true
        blockedListTableVw.delegate = self
        blockedListTableVw.dataSource = self
        getBlockedUsers()
    }
    
    //MARK: -> Actions
    @IBAction func tapBackBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapBuyerBtn(_ sender: Any) {
        buyerImgVw.isHidden = false
        userRole = 1
        sellerImgVw.isHidden = true
        buyerBtn.setTitleColor(.white, for: .normal)
        sellerBtn.setTitleColor(UIColor.init(named: "purpleColor"), for: .normal)
        blockedListTableVw.isHidden = false
        blockedListTableVw.reloadData()
    }
    
    @IBAction func tapSellerBtn(_ sender: UIButton) {
        buyerImgVw.isHidden = true
        sellerImgVw.isHidden = false
        userRole = 2
        sellerBtn.setTitleColor(.white, for: .normal)
        buyerBtn.setTitleColor(UIColor.init(named: "purpleColor"), for: .normal)
        blockedListTableVw.isHidden = false
        blockedListTableVw.reloadData()
    }
    
    @IBAction func tapUnblockBtn(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "UnblockPopUpVC") as! UnblockPopUpVC
        self.navigationController?.present(vc, animated: true)
    }
}

//MARK: -> DelegatesDataSources
extension BlockedListVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listTitleAry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = blockedListTableVw.dequeueReusableCell(withIdentifier: "BlockedListTVC", for: indexPath) as! BlockedListTVC
        cell.blockImgVw.image = UIImage(named:listImgAry[indexPath.row])
        cell.blockTitleLbl.text = listTitleAry[indexPath.row]
        cell.blockDescLbl.text = listDescAry[indexPath.row]
        return cell
    }
}

extension BlockedListVC {
    
    private func getBlockedUsers() {
        blockedVM.getBlockedUsers() { [weak self] in
            self?.blockedListTableVw.reloadData()
        }
    }
}
