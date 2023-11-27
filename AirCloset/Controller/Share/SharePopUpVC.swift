//
//  SharePopUpVC.swift
//  AirCloset
//
//  Created by cql105 on 07/04/23.
//

import UIKit
//Mark:--> Protocol
protocol ShareProtocol{
    func removeSharePop(address : Int)
}
class SharePopUpVC: UIViewController {

    //Mark:--> Outlets & Variables
    @IBOutlet weak var shareColVw: UICollectionView!
    @IBOutlet weak var shareLbl: UILabel!
    
    var shareObj : ShareProtocol?
    var shareImgAry = ["insta","facebook","snapchat","whatsapp","message","twitter"]
    var shareLblary = ["Instagram","Facebook","Snap chat","Whatsapp","Message","Twitter"]
    
    //Mark:--> View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        shareColVw.delegate = self
        shareColVw.dataSource = self
        
        if isTab == "Share" {
            shareLbl.text = "Share"
        } else if isTab == "ReferFriend"{
            shareLbl.text = "Refer a friend"
        }
    }
    
    //Mark:--> Actions
    @IBAction func tapCloseBtn(_ sender: UIButton) {
    //    isTab = 1
        self.dismiss(animated: true, completion: nil)
    }
}

//Mark:--> DelegatesDataSources
extension SharePopUpVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = shareColVw.dequeueReusableCell(withReuseIdentifier: "ShareCVCell", for: indexPath) as! ShareCVCell
        cell.shareImgVw.image = UIImage(named: shareImgAry[indexPath.row])
        cell.shareLbl.text = shareLblary[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/3, height: collectionView.frame.height/2)
    }
}
