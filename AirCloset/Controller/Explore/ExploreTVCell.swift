//
//  ExploreTVCell.swift
//  AirCloset
//
//  Created by cql105 on 05/04/23.
//

import UIKit
import CoreMIDI
import SwiftGifOrigin
import SDWebImage

class ExploreTVCell: UITableViewCell {
    
    //MARK: -> Outlets & Variables
    
    @IBOutlet weak var exploreClosetColVw: UICollectionView!
    @IBOutlet weak var exploreTitleLbl: UILabel!
    @IBOutlet weak var seeAllBtn: UIButton!
    
    var vwModel = HomeVwModel()
    var model : HomeModel?
    var index:Int?
    var suggestion: [Suggestion]?
    var basedOnLikes: [BasedOnLike]?
    var subsrcibed: [SubscribedUser]?
    var type:Int?
    var callBack: ((Bool)-> ())?
    
    //MARK: -> View Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        exploreClosetColVw.delegate = self
        exploreClosetColVw.dataSource = self
        exploreClosetColVw.reloadData()
        exploreClosetColVw.register(UINib(nibName: "ExploreUserCVC", bundle: nil), forCellWithReuseIdentifier: "ExploreUserCVC")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @objc func heartBtnClicked(sender : UIButton){
        if self.index == 0{
            self.type = suggestion?[sender.tag].isFavourite == 2 ? 1 : 2
            vwModel.addfavorites(type: self.type ?? 1, productId: suggestion?[sender.tag].id ?? ""){
                sender.isSelected = self.type == 1 ? false : true
                self.callBack?(true)
                updateClosetList?()
            }
        } else if self.index == 1{
            vwModel.addfavorites(type: 1, productId: basedOnLikes?[sender.tag].productID?.id ?? ""){
                sender.isSelected = self.type == 1 ? false : true
                self.callBack?(true)
                updateClosetList?()
            }
        }
    }
}

//MARK: ->  DelegateDataSources
extension ExploreTVCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.index == 0 {
            exploreClosetColVw.setEmptyData(msg: "No data found.", rowCount: suggestion?.count ?? 0)
            return suggestion?.count ?? 0
        }
        else if self.index == 1 {
            exploreClosetColVw.setEmptyData(msg: "No data found.", rowCount: basedOnLikes?.count ?? 0)
            return basedOnLikes?.count ?? 0
        } else if self.index == 2 {
            exploreClosetColVw.setEmptyData(msg: "No data found.", rowCount: subsrcibed?.count ?? 0)
            return subsrcibed?.count ?? 0
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if index == 0 {
            let cell = exploreClosetColVw.dequeueReusableCell(withReuseIdentifier: "ExploreCVC", for: indexPath) as! ExploreCVC
            cell.exploreImgVw.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.exploreImgVw.sd_setImage(with: URL.init(string: productImageUrl + (self.suggestion?[indexPath.row].image?.first ?? "")),placeholderImage: UIImage(named: "iconPlaceHolder"))
            cell.sizelTypeLbl.text = suggestion?[indexPath.row].sizeID?.name ?? ""
            cell.priceLbl.text = "$\(suggestion?[indexPath.row].price ?? 0) /Night"
            cell.heartBtn.tag = indexPath.row
            cell.heartBtn.addTarget(self, action: #selector(heartBtnClicked(sender:)), for: .touchUpInside)
            cell.setFavDataFor0(favData: suggestion?[indexPath.row].isFavourite ?? 1)
            cell.nameLbl.text = suggestion?[indexPath.row].name ?? ""
            return cell
        } else if index == 1{
            let cell = exploreClosetColVw.dequeueReusableCell(withReuseIdentifier: "ExploreCVC", for: indexPath) as! ExploreCVC
            cell.exploreImgVw.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.exploreImgVw.sd_setImage(with: URL.init(string: productImageUrl + (self.basedOnLikes?[indexPath.row].productID?.image?.first ?? "")),placeholderImage: UIImage(named: "iconPlaceHolder"))
            cell.sizelTypeLbl.text = basedOnLikes?[indexPath.row].productID?.sizeID?.name ?? ""
            cell.priceLbl.text = "$\(basedOnLikes?[indexPath.row].productID?.price ?? 0) /Night"
            cell.heartBtn.tag = indexPath.row
            cell.heartBtn.addTarget(self, action: #selector(heartBtnClicked(sender:)), for: .touchUpInside)
            cell.setFavDataFor1(favData: basedOnLikes?[indexPath.row].productID?.isFavourite ?? 1)
            return cell
        } else{
            let cell = exploreClosetColVw.dequeueReusableCell(withReuseIdentifier: "ExploreUserCVC", for: indexPath) as! ExploreUserCVC
            cell.imgUser.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.imgUser.sd_setImage(with: URL.init(string: imageURL + (self.subsrcibed?[indexPath.row].subscribeTo?.image ?? "")),placeholderImage: UIImage(named: "iconPlaceHolder"))
            cell.nameLbl.text = subsrcibed?[indexPath.row].subscribeTo?.name ?? ""
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let parentViewController = parentContainerViewController() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            if index == 0{
                let viewController = storyboard.instantiateViewController(withIdentifier: "BookingDetailsVC") as! BookingDetailsVC
                viewController.productID = suggestion?[indexPath.row].id ?? ""
                parentViewController.navigationController?.pushViewController(viewController, animated: true)
            } else if index == 1{
                let viewController = storyboard.instantiateViewController(withIdentifier: "BookingDetailsVC") as! BookingDetailsVC
                viewController.productID = basedOnLikes?[indexPath.row].productID?.id ?? ""
                parentViewController.navigationController?.pushViewController(viewController, animated: true)
                
            } else {
                let viewController = storyboard.instantiateViewController(withIdentifier: "SellerProfileVC") as! SellerProfileVC
                viewController.userID = subsrcibed?[indexPath.row].subscribeTo?.id ?? ""
                viewController.comesFrom = "Chat"
                parentViewController.navigationController?.pushViewController(viewController, animated: true)
            }
            isTab = "Explore"
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: exploreClosetColVw.frame.width/2, height: collectionView.frame.height)
    }
}

extension UITableViewCell {
    func createCenteredImageView(image: UIImage?, width: CGFloat, height: CGFloat) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: width),
            imageView.heightAnchor.constraint(equalToConstant: height)
        ])
        
        return imageView
    }
}
