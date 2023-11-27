//
//  SeeAllVC.swift
//  AirCloset
//
//  Created by cql105 on 18/04/23.
//

import UIKit
import SDWebImage
import SwiftUI

class SeeAllVC: UIViewController {
    // Mark :--> Outlets & Variables
    @IBOutlet weak var seeAllLbl: UILabel!
    @IBOutlet weak var seeAllColVw: UICollectionView!
    var seeAllImgAry = ["girl","muffler","jacket","sweater","muffler","girl","jacket","sweater", "girl","muffler"]
    var seeAllTitle = ""
    
    // var vwModel = HomeVwModel()
    var arrSuggestion : [Suggestion]?
    var arrBasedOnLikes: [BasedOnLike]?
    var arrSubscribedUser: [SubscribedUser]?
    var vwModel = HomeVwModel()
    var type:Int?
    var callback: (()->())?
//    var imageView: UIImageView!
    //Mark :--> View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        seeAllColVw.delegate = self
        seeAllColVw.dataSource = self
        seeAllLbl.text = seeAllTitle
    }
    
    //MARK: - Objc Function
    @objc func heartBtnClicked(sender : UIButton){
        
        if sender.isSelected == true{
            self.type = 2
        } else {
            self.type = 1
        }
        if seeAllTitle == "Suggestions"{
            self.type = arrSuggestion?[sender.tag].isFavourite == 2 ? 1 : 2
            vwModel.addfavorites(type: self.type ?? 1, productId: arrSuggestion?[sender.tag].id ?? "") {
                if self.arrSuggestion?[sender.tag].isFavourite == 1 {
                    self.arrSuggestion?[sender.tag].isFavourite = 2
                } else {
                    self.arrSuggestion?[sender.tag].isFavourite = 1
                }
                self.seeAllColVw.reloadData()
            }
        } else if seeAllTitle == "Your Likes"{
            self.type = arrBasedOnLikes?[sender.tag].productID?.isFavourite == 2 ? 1 : 2
            vwModel.addfavorites(type: 1, productId: arrBasedOnLikes?[sender.tag].productID?.id ?? "") {
                if self.arrBasedOnLikes?[sender.tag].productID?.isFavourite == 1 {
                    self.arrBasedOnLikes?[sender.tag].productID?.isFavourite = 2
                } else {
                    self.arrBasedOnLikes?[sender.tag].productID?.isFavourite = 1
                }
                self.callback?()
                self.navigationController?.popViewController(animated: true)
//                self.seeAllColVw.reloadData()
            }
            
        } else {
            
        }
        
    }
    
    //Mark:--> Actions
    @IBAction func tapBackBtn(_ sender: UIButton) {
        //      isTab = 1
        callback?()
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapShareBtn(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReferVC") as! ReferVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK:-->  DelegateDataSources
extension SeeAllVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if seeAllTitle == "Suggestions"{
            seeAllColVw.setEmptyData(msg: "No data found.", rowCount: arrSuggestion?.count ?? 0)
            return arrSuggestion?.count ?? 0
        } else if seeAllTitle == "Your Likes"{
            seeAllColVw.setEmptyData(msg: "No data found.", rowCount: arrBasedOnLikes?.count ?? 0)
            return arrBasedOnLikes?.count ?? 0
        } else {
            seeAllColVw.setEmptyData(msg: "No data found.", rowCount: arrSubscribedUser?.count ?? 0)
            return arrSubscribedUser?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = seeAllColVw.dequeueReusableCell(withReuseIdentifier: "SeeAllCVC", for: indexPath) as! SeeAllCVC
        cell.heartBtn.addTarget(self, action: #selector(heartBtnClicked(sender:)), for: .touchUpInside)
        
        if seeAllTitle == "Suggestions"{
            cell.seeAllImgVw.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.seeAllImgVw.sd_setImage(with: URL.init(string: (productImageUrl) + (arrSuggestion?[indexPath.row].image?.first ?? "")),placeholderImage: UIImage(named: "iconPlaceHolder"))
            cell.heartBtn.tag = indexPath.row
            cell.productPriceLbl.text = "$\(arrSuggestion?[indexPath.row].price ?? 0) Night"
            cell.productSizeLbl.text = arrSuggestion?[indexPath.row].sizeID?.name ?? ""
            
            if arrSuggestion?[indexPath.row].isFavourite == 2{
                cell.heartBtn.setImage(UIImage(named: "heart"), for: .normal)
            } else{
                cell.heartBtn.setImage(UIImage(named: "Group 9395"), for: .normal)
            }
            
        }
        else if seeAllTitle == "Your Likes"{
            cell.seeAllImgVw.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.seeAllImgVw.sd_setImage(with: URL.init(string: (productImageUrl) + (arrBasedOnLikes?[indexPath.row].productID?.image?.first ?? "")),placeholderImage: UIImage(named: "iconPlaceHolder"))
            cell.heartBtn.tag = indexPath.row
            cell.productPriceLbl.text = "$\(arrBasedOnLikes?[indexPath.row].productID?.price ?? 0) Night"
            cell.productSizeLbl.text = arrBasedOnLikes?[indexPath.row].productID?.sizeID?.name ?? ""
            
            if arrBasedOnLikes?[indexPath.row].productID?.isFavourite == 2{
                cell.heartBtn.setImage(UIImage(named: "heart"), for: .normal)
            } else{
                cell.heartBtn.setImage(UIImage(named: "Group 9395"), for: .normal)
            }
        }
        else {
            cell.seeAllImgVw.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.seeAllImgVw.sd_setImage(with: URL.init(string: (imageURL) + (arrSubscribedUser?[indexPath.row].subscribeTo?.image ?? "")),placeholderImage: UIImage(named: "iconPlaceHolder"))
            cell.heartBtn.isHidden = true
            cell.productSizeLbl.isHidden = true
            cell.productPriceLbl.text = arrSubscribedUser?[indexPath.row].subscribeTo?.name ?? ""
            cell.shareBtn.isHidden = true
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: seeAllColVw.frame.width/2, height: collectionView.frame.height/4)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if seeAllTitle == "Suggestions"{
            let vc = storyboard?.instantiateViewController(withIdentifier: "BookingDetailsVC") as! BookingDetailsVC
            vc.productID = arrSuggestion?[indexPath.row].id ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
            
        } else if seeAllTitle == "Your Likes"{
           
            let vc = storyboard?.instantiateViewController(withIdentifier: "BookingDetailsVC") as! BookingDetailsVC
            vc.productID = arrSuggestion?[indexPath.row].id ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
           // vc.productID = arrSuggestion?[indexPath.row].id ?? ""
            let vc = storyboard?.instantiateViewController(withIdentifier: "SellerProfileVC") as! SellerProfileVC
            vc.userID = arrSubscribedUser?[indexPath.row].subscribeTo?.id ?? ""
//            vc.userID = receiverId
            vc.comesFrom = "Chat"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        isTab = "Explore"
    }
}

