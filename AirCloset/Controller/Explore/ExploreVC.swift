//
//  ExploreVC.swift
//  AirCloset
//
//  Created by cql105 on 31/03/23.
//

import UIKit
import SkeletonView
import CoreLocation

var updateClosetList: (()->())?
var updateNoDataMsg: (()->())?

class ExploreVC: UIViewController {
    var typeIs = 0
    
    //MARK: -> Outlets & Variables
    
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var exploreColVw: UICollectionView!
    @IBOutlet weak var exploreTableVw: UITableView!
    
    var clothingImgAry = ["clothingStore","greyTrending","greyWomen","greyMen","greyChild"]
        var clothingLblAry = ["All","Trending","Women","Men","Kids"]
        var exploreLblAry = ["Suggested for you","Based on your likes","Subscribed sellers"]
        var clothingPurpleImgAry = ["pinkClothingStore","pinkTrending","women","man","child"]
    var isSelectedIndexx = 0
    var vwModel = HomeVwModel()
    var searchArray = [Suggestion]()
    var isFiltered = false
    
    //MARK: --> View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        exploreColVw.delegate = self
        exploreColVw.dataSource = self
        NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: nil, userInfo: nil)
//        getHomeData(type: 0)
//        callBackMyCloset = {
//            self.getHomeData(type: 0)
//        }
        SocketIOManager.sharedInstance.socket.connect()
        self.txtSearch.addTarget(self, action: #selector(searchWorkersAsPerText(_ :)), for: .editingChanged)
    }

    
    override func viewWillAppear(_ animated: Bool) {    
        getHomeData(type: 0)
    }
    
    //MARK: Predicate to filter data
    
    @objc func searchWorkersAsPerText(_ textfield:UITextField) {
        isFiltered = true
        self.searchArray.removeAll()
        if txtSearch.text?.count != 0 {
            for obj in vwModel.homeInfoModel?.body?.suggestion ?? [] {
                let range = obj.name?.lowercased().range(of: textfield.text!, options: .caseInsensitive, range: nil,   locale: nil)
                if range != nil {
                    searchArray.append(obj)
                }
                self.vwModel.homeInfoModel?.body?.suggestion = searchArray
                DispatchQueue.main.async {
                    self.exploreTableVw.reloadData()
                }
            }
        } else {
            isFiltered = false
            DispatchQueue.main.async {
                self.getHomeData(type: 0)
                self.exploreTableVw.reloadData()
            }
        }
    }
    
    //MARK: - APIFunc
    func getHomeData(type : Int){
        vwModel.homeDataApi(type: type, price: Singletone.shared.priceFiler ?? 0, brandId: Singletone.shared.brandFilter ?? "", sizeId: Singletone.shared.sizeFilter ?? "", colorId: Singletone.shared.colorFilter ?? "", minimum: Singletone.shared.minDistFilter ?? 0, maximum: Singletone.shared.maxDistfilter ?? 0)
        vwModel.onSuccess = {
            updateNoDataMsg?()
            self.exploreTableVw.reloadData()
        }
    }
    
    //MARK: - Objc Fucntion
    @objc func seeAllBtnTapped(sender : UIButton){
        let array = ["Suggestions","Your Likes", "Subscribed Seller"]
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SeeAllVC") as! SeeAllVC
        vc.seeAllTitle = array[sender.tag]
        vc.arrSuggestion = vwModel.homeInfoModel?.body?.suggestion
        vc.arrBasedOnLikes = vwModel.homeInfoModel?.body?.basedOnLikes
        vc.arrSubscribedUser = vwModel.homeInfoModel?.body?.subscribedUsers
        vc.callback = {
            self.exploreTableVw.reloadData()
            self.exploreColVw.reloadData()
            self.isSelectedIndexx = 0
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: -> Actions
    
    @IBAction func tapFilterBtn(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FilterVC") as! FilterVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tapShareBtn(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReferVC") as! ReferVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tapPlusBtn(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddClosetVC") as! AddClosetVC
        isTab = "Explore"
        vc.isSet = 0
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: -->  DelegateDataSources of Collection View
extension ExploreVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return clothingLblAry.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = exploreColVw.dequeueReusableCell(withReuseIdentifier: "ExploreCVCell", for: indexPath) as! ExploreCVCell
        cell.clothingImgVw.image = UIImage(named: clothingImgAry[indexPath.row])
        cell.clothingLbl.text = clothingLblAry[indexPath.row]
        
        if indexPath.row == isSelectedIndexx {
            cell.clothingImgVw.image = UIImage(named: clothingPurpleImgAry[indexPath.row])
            cell.clothingLbl.textColor = UIColor(named: "purpleColor")
            cell.lineLbl.backgroundColor = UIColor(named: "purpleColor")
        } else {
            cell.clothingImgVw.image = UIImage(named: clothingImgAry[indexPath.row])
            cell.clothingLbl.textColor = .lightGray
            cell.lineLbl.backgroundColor = .lightGray
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        isSelectedIndexx = indexPath.row
        Singletone.shared.priceFiler = 0
        Singletone.shared.brandFilter = ""
        Singletone.shared.sizeFilter = ""
        Singletone.shared.colorFilter = ""
        Singletone.shared.minDistFilter = 0
        Singletone.shared.maxDistfilter = 0
        getHomeData(type: indexPath.row)
        self.typeIs = indexPath.row
        self.exploreColVw.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: exploreColVw.frame.width / 5 , height: 60)
    }
    
}

//MARK: ->  DelegateDataSources of Table View
extension ExploreVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = exploreTableVw.dequeueReusableCell(withIdentifier: "ExploreTVCell", for: indexPath) as! ExploreTVCell
        cell.exploreTitleLbl.text = exploreLblAry[indexPath.row]
        cell.seeAllBtn.tag = indexPath.row
        cell.index = indexPath.row
        if indexPath.row == 0 {
            cell.seeAllBtn.addTarget(self, action: #selector(seeAllBtnTapped(sender:)), for: .touchUpInside)
            if self.vwModel.homeInfoModel?.body?.suggestion?.count ?? 0 > 0 {
                cell.seeAllBtn.isHidden = false
            } else {
                cell.seeAllBtn.isHidden = true
            }
            cell.suggestion = self.vwModel.homeInfoModel?.body?.suggestion
        } else if indexPath.row == 1 {
            if self.vwModel.homeInfoModel?.body?.basedOnLikes?.count ?? 0 > 0 {
                cell.seeAllBtn.isHidden = false
            } else {
                cell.seeAllBtn.isHidden = true
            }
            cell.basedOnLikes = self.vwModel.homeInfoModel?.body?.basedOnLikes
            cell.seeAllBtn.addTarget(self, action: #selector(seeAllBtnTapped(sender:)), for: .touchUpInside)
        } else {
            if self.vwModel.homeInfoModel?.body?.subscribedUsers?.count ?? 0 > 0 {
                cell.seeAllBtn.isHidden = false
            } else {
                cell.seeAllBtn.isHidden = true
            }
            cell.subsrcibed = self.vwModel.homeInfoModel?.body?.subscribedUsers
            cell.seeAllBtn.addTarget(self, action: #selector(seeAllBtnTapped(sender:)), for: .touchUpInside)
        }
        cell.callBack = { [weak self] dataa in
            if dataa == true{
                self?.getHomeData(type: self?.typeIs ?? 0)
            }
        }
        cell.seeAllBtn.tag = indexPath.row
        cell.model =  self.vwModel.homeInfoModel
        cell.exploreClosetColVw.reloadData()
        return cell
    }
}



