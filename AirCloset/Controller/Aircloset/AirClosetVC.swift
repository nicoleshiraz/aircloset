//
//  AirClosetVC.swift
//  AirCloset
//
//  Created by cql105 on 31/03/23.
//

import UIKit

var selectedType: Int = 0

class AirClosetVC: UIViewController {
    
    //MARK: -> Outlets & Variables
    @IBOutlet weak var favBack: CustomImageView!
    @IBOutlet weak var airClosetTableVw: UITableView!
    @IBOutlet weak var ordrBackGround: CustomImageView!
    @IBOutlet weak var airClosetColVw: UICollectionView!
    @IBOutlet weak var myFvrtBtn: UIButton!
    @IBOutlet weak var ordersBtn: CustomButton!
    @IBOutlet weak var myOrdersBgImgVw: CustomImageView!
    @IBOutlet weak var myOrdersBtn: CustomButton!
    
    var airClosetImgAry = ["girl","jacket","muffler","sweater"]
    var ordersImgAry = ["girl","girl","girl"]
    var ordersLblAry = ["Ladies Top","Ladies Top","Ladies Top"]
    var ordersStatusAry = ["Status: Picked Up","Status: Pending","Status: Delivered"]
    
    var dropDownIndex = -1
    var editHidden = false
    var isFrm = ""
    
    var myOrdersImgAry = ["brownHairs","gown","brownHairs"]
    var myOrdersLblAry = ["Ladies Top","Ladies Gown","Ladies Top"]
    var myOrdersStatusAry = ["Status: Accepted","Status: Pending","Status: Reserved"]
    var vwModel = ClosetListingVwModel()
    var favModel : ClosetListingFavModel?
    var orderByMeModel : ClosetListingOrderByMeModel?
    var orderByMeModelList : [ClosetListingOrderByMeModelBody]?
    var orderByOtherModelList : [ClosetListingOderedByOtherModelBody]?
    var orderByOtherModel : ClosetListingOderedByOtherModel?
    var tapFavVwmodel = HomeVwModel()
    var imageView: UIImageView!
    
    //MARK: -> View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        ordrBackGround.isHidden = true
        myOrdersBgImgVw.isHidden = true
        airClosetTableVw.isHidden = true
        
        airClosetColVw.delegate = self
        airClosetColVw.dataSource = self
        airClosetTableVw.delegate = self
        airClosetTableVw.dataSource = self
        
        updateClosetList = { [self] in
            selectedType = 0
            vwModel.getClosetListingApi(type: 0)
            vwModel.onSuccess = { [weak self] in
                self?.favModel = self?.vwModel.closetListingFavInfo
                self?.myfavTap()
            }
        }
        
        if selectedType == 0 {
            selectedType = 0
            vwModel.getClosetListingApi(type: 0)
            vwModel.onSuccess = { [weak self] in
                self?.favModel = self?.vwModel.closetListingFavInfo
                self?.myfavTap()
            }
            myfavTap()
        } else if selectedType == 1 {
            vwModel.getClosetListingApi(type: 1)
            vwModel.onSuccess = { [weak self] in
                self?.orderByMeModel = self?.vwModel.closetListingOrderByMeInfo
                self?.orderByMeModelList = self?.vwModel.closetListingOrderByMeInfo?.body
                self?.orderByMeModelList = self?.vwModel.closetListingOrderByMeInfo?.body?.filter({ $0.cancelStatus == 0 })
                self?.orderTap()
            }
            orderTap()
        } else {
            vwModel.getClosetListingApi(type: 2)
            vwModel.onSuccess = {[weak self] in
                self?.orderByOtherModel = self?.vwModel.closetListingOrderByOthersInfo
                self?.orderByOtherModel?.body = self?.vwModel.closetListingOrderByOthersInfo?.body?.filter({ $0.cancelStatus != 1 })
                self?.orderByOtherModelList = self?.vwModel.closetListingOrderByOthersInfo?.body
                self?.myorderTap()
            }
            myorderTap()
        }        
        
        listUpdateCallBack = { [self] in
            if selectedType == 0 {
                selectedType = 0
                vwModel.getClosetListingApi(type: 0)
                vwModel.onSuccess = { [weak self] in
                    self?.favModel = self?.vwModel.closetListingFavInfo
                    self?.myfavTap()
                }
                myfavTap()
            } else if selectedType == 1 {
                vwModel.getClosetListingApi(type: 1)
                vwModel.onSuccess = { [weak self] in
                    self?.orderByMeModel = self?.vwModel.closetListingOrderByMeInfo
                    self?.orderByMeModelList = self?.vwModel.closetListingOrderByMeInfo?.body
                    self?.orderByMeModelList = self?.vwModel.closetListingOrderByMeInfo?.body?.filter({ $0.cancelStatus == 0 })
                    self?.orderTap()
                }
                orderTap()
            } else {
                vwModel.getClosetListingApi(type: 2)
                vwModel.onSuccess = {[weak self] in
                    self?.orderByOtherModel = self?.vwModel.closetListingOrderByOthersInfo
                    self?.orderByOtherModel?.body = self?.vwModel.closetListingOrderByOthersInfo?.body?.filter({ $0.cancelStatus != 1 })
                    self?.orderByOtherModelList = self?.vwModel.closetListingOrderByOthersInfo?.body
                    self?.myorderTap()
                }
                myorderTap()
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    //MARK: - DefaultFunc
    func defaultApiFunc(){
        selectedType = 0
        vwModel.getClosetListingApi(type: 0)
        vwModel.onSuccess = { [weak self] in
            self?.favModel = self?.vwModel.closetListingFavInfo
            self?.myfavTap()
        }
        myfavTap()
    }
    
    //MARK: - Objc Function
    @objc func heartLikeBTnnTapped(sender : UIButton){
        tapFavVwmodel.addfavorites(type: 1, productId: vwModel.closetListingFavInfo?.body?[sender.tag].productID?.id ?? "") {
            self.defaultApiFunc()
        }
        
    }
    
    //Mark:--> Actions
    @IBAction func tapMyFavBtn(_ sender: UIButton){
        selectedType = 0
        vwModel.getClosetListingApi(type: 0)
        vwModel.onSuccess = { [weak self] in
            self?.favModel = self?.vwModel.closetListingFavInfo
            self?.myfavTap()
        }
//        myfavTap()
    }
    
    @IBAction func tapOrdersBtn(_ sender: UIButton) {
        selectedType = 1
        vwModel.getClosetListingApi(type: 1)
        vwModel.onSuccess = { [weak self] in
            self?.orderByMeModel = self?.vwModel.closetListingOrderByMeInfo
            self?.orderByMeModelList = self?.vwModel.closetListingOrderByMeInfo?.body
            self?.orderByMeModelList = self?.vwModel.closetListingOrderByMeInfo?.body?.filter({ $0.cancelStatus == 0 })
            self?.orderTap()
            
        }
//        orderTap()
    }
    
    @IBAction func tapMyOrdersBtn(_ sender: UIButton) {
        selectedType = 2
        vwModel.getClosetListingApi(type: 2)
        vwModel.onSuccess = {[weak self] in
            self?.orderByOtherModel = self?.vwModel.closetListingOrderByOthersInfo
            self?.orderByOtherModelList = self?.vwModel.closetListingOrderByOthersInfo?.body
//            self?.orderByOtherModel?.body = self?.vwModel.closetListingOrderByOthersInfo?.body?.filter({ $0.cancelStatus != 1 })
            self?.myorderTap()
        }
    }
}

//MARK: -> DelegatesDatasources of Collection View
extension AirClosetVC: UICollectionViewDelegate, UICollectionViewDataSource,
                       UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        airClosetColVw.setEmptyData(msg: "No data found.", rowCount: favModel?.body?.count ?? 0)
        return favModel?.body?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = airClosetColVw.dequeueReusableCell(withReuseIdentifier: "AirClosetCVCell", for: indexPath) as! AirClosetCVCell
        cell.heartBtn.tag = indexPath.row
        cell.airClosetImgVw.sd_setImage(with: URL.init(string: productImageUrl + (self.vwModel.closetListingFavInfo?.body?[indexPath.row].productID?.image?.first ?? "" )),placeholderImage : UIImage(named: "profileIcon"))
        
        cell.heartBtn.addTarget(self, action: #selector(heartLikeBTnnTapped(sender:)), for: .touchUpInside)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "BookingDetailsVC") as! BookingDetailsVC
        viewController.productID = self.vwModel.closetListingFavInfo?.body?[indexPath.row].productID?.id ?? ""
        isTab = "Explore"
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: airClosetColVw.frame.width/2, height: collectionView.frame.height/3)
    }
}

//MARK: -> DelegatesDatasources of Table view
extension AirClosetVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFrm == "orders"{
            airClosetTableVw.setEmptyData(msg: "No data found.", rowCount: orderByMeModelList?.count ?? 0)
            return orderByMeModelList?.count ?? 0
        } else {
            airClosetTableVw.setEmptyData(msg: "No data found.", rowCount: orderByOtherModel?.body?.count ?? 0)
            return orderByOtherModel?.body?.count ?? 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = airClosetTableVw.dequeueReusableCell(withIdentifier: "AirClosetTVCell", for: indexPath) as! AirClosetTVCell
        cell.viewReceiptBtn.isHidden = false
        if isFrm == "orders"{
            cell.viewReceiptBtn.isHidden = false
            cell.imgProof.isHidden = false
            cell.statusLbl.isHidden = false
            cell.cosTableImgVw.sd_setImage(with: URL.init(string: productImageUrl + (self.orderByMeModelList?[indexPath.row].productID?.image?.first ?? "" )),placeholderImage : UIImage(named: "profileIcon"))
            cell.airClosetTitleLbl.text = orderByMeModelList?[indexPath.row].productID?.name?.capitalizeFirstLetter() ?? ""
            cell.sizeLbl.text = "Size: \(orderByMeModelList?[indexPath.row].productID?.sizeID?.name ?? "")"
            cell.startDate.text = "Start: \(orderByMeModelList?[indexPath.row].startDate ?? "")"
            cell.finishLabel.text = "Finish: \(orderByMeModelList?[indexPath.row].endDate ?? "")"
            var total = (orderByMeModelList?[indexPath.row].productID?.price ?? 0) * (orderByMeModelList?[indexPath.row].totalDays ?? 0)
            cell.pricePrNtLbl.text = "$\(total) (\("$\(orderByMeModelList?[indexPath.row].productID?.price ?? 0) x \((orderByMeModelList?[indexPath.row].totalDays ?? 0))"))"
//            cell.pricePrNtLbl.text = "$\(orderByMeModelList?[indexPath.row].productID?.price ?? 0)/Night"
            cell.viewReceiptBtn.tag = indexPath.row
            cell.viewReceiptBtn.addTarget(self, action: #selector(viewReceiptButtonAction), for: .touchUpInside)
            //cell.descritptionLbl.text = orderByMeModelList?[indexPath.row].productID?.description ?? ""
            
            //MARK: Edit or Cancel Order
            
            let result = isDateGreaterThanCurrentDate(dateString: orderByMeModelList?[indexPath.row].endDate ?? "")
            cell.editBtn.tag = indexPath.row
            cell.cancelOrderBtn.tag = indexPath.row
            cell.editBtn.addTarget(self, action: #selector(editOrder(sender:)), for: .touchUpInside)
            cell.cancelOrderBtn.addTarget(self, action: #selector(cancleOrder(sender:)), for: .touchUpInside)
            
            if orderByMeModelList?[indexPath.row].orderType == 1 {
                if orderByMeModelList?[indexPath.row].orderStatus == 0{
                    cell.statusLbl.text = "Status: Pending"
                    cell.statusLbl.textColor = UIColor.black
//                    cell.viewReceiptBtn.isHidden = true

                    cell.dotsBtn.isHidden = false
                   
                } else if orderByMeModelList?[indexPath.row].orderStatus == 1{
                    cell.statusLbl.text = "Status: Accepted"
                    cell.statusLbl.textColor = UIColor.black
//                    cell.viewReceiptBtn.isHidden = true

                    cell.dotsBtn.isHidden = true
                } else if orderByMeModelList?[indexPath.row].orderStatus == 2 && result == true{
                    cell.statusLbl.text = "Status: Delivered"
                    cell.statusLbl.textColor = UIColor.black
//                    cell.viewReceiptBtn.isHidden = true

                    cell.dotsBtn.isHidden = true
                } else if orderByMeModelList?[indexPath.row].orderStatus == 2 && result == false {
                    cell.statusLbl.text = "Status: Return Due"
                    cell.statusLbl.textColor = UIColor.red
//                    cell.viewReceiptBtn.isHidden = true

                    cell.dotsBtn.isHidden = true
                } else if orderByMeModelList?[indexPath.row].orderStatus == 3{
                    cell.statusLbl.text = "Status: Returned"
                    cell.statusLbl.textColor = UIColor.black
//                    cell.viewReceiptBtn.isHidden = true
                    cell.dotsBtn.isHidden = true
                } else if orderByMeModelList?[indexPath.row].orderStatus == 4{
                    cell.statusLbl.text = "Status: Completed"
                    cell.statusLbl.textColor = UIColor.black
//                    cell.viewReceiptBtn.isHidden = false
                    cell.dotsBtn.isHidden = true
                }
            } else {
                if orderByMeModelList?[indexPath.row].orderStatus == 0{
                    cell.statusLbl.text = "Status: Pending"
                    cell.statusLbl.textColor = UIColor.black
//                    cell.viewReceiptBtn.isHidden = true

                    cell.dotsBtn.isHidden = false
                } else if orderByMeModelList?[indexPath.row].orderStatus == 1{
                    cell.statusLbl.text = "Status: Accepted"
//                    cell.viewReceiptBtn.isHidden = true

                    cell.statusLbl.textColor = UIColor.black
                    cell.dotsBtn.isHidden = true
                } else if orderByMeModelList?[indexPath.row].orderStatus == 2 && result == true{
                    cell.statusLbl.text = "Status: Picked Up"
//                    cell.viewReceiptBtn.isHidden = true

                    cell.statusLbl.textColor = UIColor.black
                    cell.dotsBtn.isHidden = true
                } else if orderByMeModelList?[indexPath.row].orderStatus == 2 && result == false {
                    cell.statusLbl.text = "Status: Return Due"
                    cell.statusLbl.textColor = UIColor.red
//                    cell.viewReceiptBtn.isHidden = true

                    cell.dotsBtn.isHidden = true
                } else if orderByMeModelList?[indexPath.row].orderStatus == 3{
                    cell.statusLbl.text = "Status: Returned"
//                    cell.viewReceiptBtn.isHidden = true

                    cell.statusLbl.textColor = UIColor.black
                    cell.dotsBtn.isHidden = true
                } else if orderByMeModelList?[indexPath.row].orderStatus == 4{
                    cell.statusLbl.text = "Status: Completed"
                    cell.statusLbl.textColor = UIColor.black
//                    cell.viewReceiptBtn.isHidden = false
                    cell.dotsBtn.isHidden = true
                }
            }
        } else {
            cell.imgProof.isHidden = true
            cell.viewReceiptBtn.isHidden = true
            cell.viewReceiptBtn.tag = indexPath.row
            cell.viewReceiptBtn.addTarget(self, action: #selector(viewReceiptButtonAction), for: .touchUpInside)
            //MARK: Edit or Cancel Order
            cell.dotsBtn.isHidden = true
            cell.editBtn.tag = indexPath.row
            cell.cancelOrderBtn.tag = indexPath.row
            cell.editBtn.addTarget(self, action: #selector(editOrder(sender:)), for: .touchUpInside)
            cell.cancelOrderBtn.addTarget(self, action: #selector(cancleOrder(sender:)), for: .touchUpInside)
            
            cell.cosTableImgVw.sd_setImage(with: URL.init(string: productImageUrl + (self.orderByOtherModelList?[indexPath.row].productID?.image?.first ?? "" )),placeholderImage : UIImage(named: "profileIcon"))
            cell.airClosetTitleLbl.text = orderByOtherModelList?[indexPath.row].productID?.name?.capitalizeFirstLetter() ?? ""
            cell.sizeLbl.text = "Size: \(orderByOtherModelList?[indexPath.row].productID?.sizeID?.name ?? "")"
           // cell.descritptionLbl.text = orderByOtherModelList?[indexPath.row].productID?.description ?? ""
            cell.startDate.text = "Start: \(orderByOtherModelList?[indexPath.row].startDate ?? "")"
            cell.finishLabel.text = "Finish: \(orderByOtherModelList?[indexPath.row].endDate ?? "")"
            var total = (orderByOtherModelList?[indexPath.row].productID?.price ?? 0) * (orderByOtherModelList?[indexPath.row].totalDays ?? 0)
            cell.pricePrNtLbl.text = "$\(total) (\("$\(orderByOtherModelList?[indexPath.row].productID?.price ?? 0) x \((orderByOtherModelList?[indexPath.row].totalDays ?? 0))"))"
//            cell.pricePrNtLbl.text = "$\(orderByOtherModelList?[indexPath.row].productID?.price ?? 0)/Night"
            if orderByOtherModelList?[indexPath.row].orderType == 1{
                if orderByOtherModelList?[indexPath.row].orderStatus == 0{
                    cell.statusLbl.text = "Status: Pending"
                    cell.statusLbl.textColor = UIColor.black
                } else if orderByOtherModelList?[indexPath.row].orderStatus == 1{
                    cell.statusLbl.text = "Status: Accepted"
                    cell.statusLbl.textColor = UIColor.black
                } else if orderByOtherModelList?[indexPath.row].orderStatus == 2{
                    cell.statusLbl.text = "Status: Delivered"
                    cell.statusLbl.textColor = UIColor.black
                } else if orderByOtherModelList?[indexPath.row].orderStatus == 3{
                    cell.statusLbl.text = "Status: Returned"
                    cell.statusLbl.textColor = UIColor.black
                } else if orderByOtherModelList?[indexPath.row].orderStatus == 4{
                    cell.statusLbl.text = "Status: Completed"
                    cell.statusLbl.textColor = UIColor.black
                }
                
            } else {
                if orderByOtherModelList?[indexPath.row].orderStatus == 0{
                    cell.statusLbl.text = "Status: Pending"
                    cell.statusLbl.textColor = UIColor.black
                } else if orderByOtherModelList?[indexPath.row].orderStatus == 1{
                    cell.statusLbl.text = "Status: Accepted"
                    cell.statusLbl.textColor = UIColor.black
                } else if orderByOtherModelList?[indexPath.row].orderStatus == 2{
                    cell.statusLbl.text = "Status: Picked Up"
                    cell.statusLbl.textColor = UIColor.black
                } else if orderByOtherModelList?[indexPath.row].orderStatus == 3{
                    cell.statusLbl.text = "Status: Returned"
                    cell.statusLbl.textColor = UIColor.black
                } else if orderByOtherModelList?[indexPath.row].orderStatus == 4{
                    cell.statusLbl.text = "Status: Completed"
                    cell.statusLbl.textColor = UIColor.black
                }
            }
           
        }
        
        cell.dotsBtn.tag = indexPath.row
        if editHidden{
            cell.editBtn.isHidden = true
            cell.editCancelVwHgt.constant = 0
        }else{
            cell.editBtn.isHidden = false
            cell.editCancelVwHgt.constant = 40
        }
        cell.editCallBack = { [weak self] in
            if self?.dropDownIndex == indexPath.row {
                self?.dropDownIndex = -1
            }else{
                self?.dropDownIndex = indexPath.row
            }
            self?.airClosetTableVw.reloadData()
        }
        
        if indexPath.row != dropDownIndex{
            cell.editCancelView.isHidden = true
        }else{
            cell.editCancelView.isHidden = false
        }
        return cell
    }
    
    func isCurrentDateGreaterThanEndDate(endDateString: String, dateFormat: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        
        if let endDate = dateFormatter.date(from: endDateString) {
            if endDate < Date() {
                return true
            } else {
                return false
            }
        } else {
            print("Failed to parse the endDate.")
            return false
        }
    }
    
    func isDateGreaterThanCurrentDate(dateString: String?) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"

        let currentDate = Date()

        if let dateString = dateString, let date = dateFormatter.date(from: dateString) {
            return date > currentDate
        } else {
            return false
        }
    }

    @objc func viewReceiptButtonAction(sender:UIButton){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewReceiptVC") as! ViewReceiptVC
        isTab = "ViewReceipt"
        vc.comeFrom = "order"
        if isFrm == "orders"{
            Singletone.shared.productId = orderByMeModelList?[sender.tag].id
        } else {
            Singletone.shared.productId = orderByOtherModelList?[sender.tag].id
        }
        self.navigationController?.pushViewController(vc, animated: false)
    }

    
    //MARK: Edit Cancel Function
    
    @objc func cancleOrder(sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EditCancelPopUpVC") as! EditCancelPopUpVC
        vc.removeEditCancelObj = self
        vc.bookingID = orderByMeModelList?[sender.tag].id ?? ""
        vc.callBack = { [self] (status) in
            if status == true {
                editHidden = false
                dropDownIndex = -1
                selectedType = 1
                self.vwModel.getClosetListingApi(type: 1)
                self.vwModel.onSuccess = { [weak self] in
                    self?.orderByMeModel = self?.vwModel.closetListingOrderByMeInfo
                    self?.orderByMeModelList = self?.vwModel.closetListingOrderByMeInfo?.body
                    self?.orderByMeModelList = self?.vwModel.closetListingOrderByMeInfo?.body?.filter({ $0.cancelStatus == 0 })
                    self?.orderTap()
                }
            } else {
                editHidden = false
                dropDownIndex = -1
            }
        }
        isTab = "CancelOrder"
        self.navigationController?.present(vc, animated: true)
    }
    
    @objc func editOrder(sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EditCancelPopUpVC") as! EditCancelPopUpVC
        vc.removeEditCancelObj = self
        vc.bookingID = vwModel.closetListingOrderByMeInfo?.body?[sender.tag].id ?? ""
        vc.callBack = { [self] (status) in
            if status == true {
                editHidden = false
                dropDownIndex = -1
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "EnterDetailsVC") as! EnterDetailsVC
                vc.productID = orderByMeModelList?[sender.tag].id ?? ""
                vc.productDataForEdit = orderByMeModelList?[sender.tag]
                isTab = "EditDetails"
                self.navigationController?.pushViewController(vc, animated: true)
            }  else {
                editHidden = false
                dropDownIndex = -1
            }
        }
        isTab = "Edit"
        self.navigationController?.present(vc, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        editHidden = false
        dropDownIndex = -1
        if isFrm == "orders"{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "BookingDetailsVC") as! BookingDetailsVC
            isTab = "AirClosetOrders"
            if orderByMeModelList?[indexPath.row].id ?? "" != "" {
                vc.getsingleOrderID = orderByMeModelList?[indexPath.row].id ?? ""
                Singletone.shared.productId = orderByMeModelList?[indexPath.row].id ?? ""
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            
            if orderByOtherModelList?[indexPath.row].orderStatus == 0{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "BookingDetailsVC") as! BookingDetailsVC
                vc.getsingleOrderID = orderByOtherModelList?[indexPath.row].id ?? ""
                Singletone.shared.productId = orderByOtherModelList?[indexPath.row].id ?? ""
                isTab = "MyClosetFourthIndex"
                callBackMyCloset = {
                    self.vwModel.getClosetListingApi(type: 2)
                    self.orderByOtherModel?.body = self.orderByOtherModelList?.filter({ $0.cancelStatus != 1 })
                }
                self.navigationController?.pushViewController(vc, animated: true)

            } else {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "BookingDetailsVC") as! BookingDetailsVC
                isTab = "ReceivedAfterAccept"
                vc.getsingleOrderID = orderByOtherModelList?[indexPath.row].id ?? ""
                callBackMyCloset = {
                    self.vwModel.getClosetListingApi(type: 2)
                    self.orderByOtherModel?.body = self.orderByOtherModelList?.filter({ $0.cancelStatus != 1 })
                }
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}

//MARK: ->Extension Protocols

extension AirClosetVC: EditCancelProtocol {
    func removeEditCancelPop(address: Int) {
        airClosetTableVw.reloadData()
    }
    
    func orderTap(){
        editHidden = false
        isFrm = "orders"
        favBack.isHidden = true
        ordrBackGround.isHidden = false
        ordersBtn.setTitleColor(.white, for: .normal)
        myFvrtBtn.setTitleColor(UIColor.init(named: "purpleColor"), for: .normal)
        myOrdersBtn.setTitleColor(UIColor.init(named: "purpleColor"), for: .normal)
        airClosetTableVw.isHidden = false
        myOrdersBgImgVw.isHidden = true
        airClosetTableVw.reloadData()
    }
    func myorderTap(){
        isFrm = "myOrder"
        editHidden = true
        favBack.isHidden = true
        ordrBackGround.isHidden = true
        myFvrtBtn.setTitleColor(UIColor.init(named: "purpleColor"), for: .normal)
        ordersBtn.setTitleColor(UIColor.init(named: "purpleColor"), for: .normal)
        myOrdersBtn.setTitleColor(.white, for: .normal)
        myOrdersBgImgVw.isHidden = false
        airClosetTableVw.isHidden = false
        airClosetTableVw.reloadData()
    }
    func myfavTap(){
        favBack.isHidden = false
        ordrBackGround.isHidden = true
        myFvrtBtn.setTitleColor(.white, for: .normal)
        ordersBtn.setTitleColor(UIColor.init(named: "purpleColor"), for: .normal)
        myOrdersBtn.setTitleColor(UIColor.init(named: "purpleColor"), for: .normal)
        myOrdersBgImgVw.isHidden = true
        airClosetTableVw.isHidden = true
        airClosetColVw.reloadData()
    }
}
