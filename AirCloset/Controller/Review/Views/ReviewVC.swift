//
//  ReviewVC.swift
//  AirCloset
//
//  Created by cql105 on 18/04/23.
//

import UIKit

class ReviewVC: UIViewController {
    //MARK: ->  Outlets
    @IBOutlet weak var reviewTableVw: UITableView!
    @IBOutlet weak var myClosetImgVw: CustomImageView!
    @IBOutlet weak var myClosetBtn: UIButton!
    @IBOutlet weak var ordersImgVw: CustomImageView!
    @IBOutlet weak var ordersBtn: UIButton!
    @IBOutlet weak var stackViewHeight: NSLayoutConstraint!
    @IBOutlet weak var stackViewBottom: NSLayoutConstraint!
    @IBOutlet weak var stackViewTop: NSLayoutConstraint!
    
    var reviewVM = ReviewVM()
    var productID = String()
    var isTab = String()
    
    //MARK: -> View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        ordersImgVw.isHidden = true
        reviewTableVw.delegate = self
        reviewTableVw.dataSource = self
        if isTab == "MyClosetZeroIndex" || isTab == "" {
            stackViewBottom.constant = 20
            stackViewHeight.constant = 50
            myClosetBtn.isHidden = false
            ordersBtn.isHidden = false
            getData(rateParam: ["type": "1"])
        }else{
            stackViewBottom.constant = 0
            stackViewHeight.constant = 0
            myClosetBtn.isHidden = true
            ordersBtn.isHidden = true
            getSingleProductReview(rateParam: ["productId": productID])
            
        }
    }
    
    //Mark:--> Actions
    @IBAction func tapBackBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapMyClosetBtn(_ sender: UIButton) {
        myClosetImgVw.isHidden = false
        ordersImgVw.isHidden = true
        getData(rateParam: ["type": "1"])
        myClosetBtn.setTitleColor(.white, for: .normal)
        ordersBtn.setTitleColor(UIColor.init(named: "purpleColor"), for: .normal)
        reviewTableVw.reloadData()
    }
    
    @IBAction func tapOrdersBtn(_ sender: UIButton) {
        myClosetImgVw.isHidden = true
        ordersImgVw.isHidden = false
        getData(rateParam: ["type": "2"])
        ordersBtn.setTitleColor(.white, for: .normal)
        myClosetBtn.setTitleColor(UIColor.init(named: "purpleColor"), for: .normal)
        reviewTableVw.reloadData()
    }
}

//Mark:--> DelegatesDatasources
extension ReviewVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isTab == "MyClosetZeroIndex"{
            reviewTableVw.setEmptyData(msg: "No data found.", rowCount: reviewVM.reviewData?.count ?? 0)
            return reviewVM.reviewData?.count ?? 0
        } else {
            reviewTableVw.setEmptyData(msg: "No data found.", rowCount: reviewVM.reviewSingleData?.count ?? 0)
            return reviewVM.reviewSingleData?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = reviewTableVw.dequeueReusableCell(withIdentifier: "ReviewTVCell", for: indexPath) as! ReviewTVCell
        
        if isTab == "MyClosetZeroIndex"{
            if reviewVM.reviewData?.count ?? 0 > 0 {
                cell.setData(reviewData: (reviewVM.reviewData?[indexPath.row])!)
            }
        } else {
            if reviewVM.reviewSingleData?.count ?? 0 > 0 {
                cell.setDataNew(reviewData: (reviewVM.reviewSingleData?[indexPath.row])!)
            }
        }
        cell.ratingView.isUserInteractionEnabled = false
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


extension ReviewVC {
    
    private func getData(rateParam: [String:Any]) {
        reviewVM.getRatingData(params: rateParam) { [weak self] in
            self?.reviewTableVw.reloadData()
        }
    }
    
    private func getSingleProductReview(rateParam: [String:Any]) {
        reviewVM.getSingleProductReview(params: rateParam) { [weak self] in
            self?.reviewTableVw.reloadData()
        }
    }
}
