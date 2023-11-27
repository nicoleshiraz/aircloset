//
//  EditCancelPopUpVC.swift
//  AirCloset
//
//  Created by cql105 on 25/04/23.
//

import UIKit
//Mark:--> Protocol
protocol EditCancelProtocol{
    func removeEditCancelPop(address : Int)
}

class EditCancelPopUpVC: UIViewController {
    
    //MARK: -> Outlets & Variables
    
    var removeEditCancelObj : EditCancelProtocol?
    @IBOutlet weak var editCancelImgVw: UIImageView!
    @IBOutlet weak var editCancelLbl: UILabel!
    var bookingID = String()
    var status = Int()
    var callBack: ((Bool)->())?
    var viewModel = AcceptRejectVwModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch isTab {
        case "Edit":
            editCancelLbl.text = "Are you sure want to edit this closet?"
            
        case "CancelOrder":
            editCancelLbl.text = "Are you sure want to cancel order?"
            editCancelImgVw.image = UIImage(named: "iconCancel")
        default:
            break
        }
    }
    
    @IBAction func tapYesBtn(_ sender: UIButton) {
        
        switch isTab {
        case "Edit":
            callBack?(true)
            editCancelLbl.text = "Are you sure want to edit this closet?"
            self.dismiss(animated: true, completion: nil)
        case "CancelOrder":
            editCancelLbl.text = "Are you sure want to cancel order?"
            editCancelImgVw.image = UIImage(named: "iconCancel")
            cancelBooking(cancelParams: ["_id": bookingID,"cancelStatus" : 1])
        default:
            break
        }
    }
    
    @IBAction func tapNoBtn(_ sender: UIButton) {
        callBack?(false)
        listUpdateCallBack?()
        isTab = "AirClosetOrders"
        self.dismiss(animated: true, completion: nil)
    }
}


extension EditCancelPopUpVC {
    
    private func cancelBooking(cancelParams: [String:Any]) {
        viewModel.cancelBooking(paramss: cancelParams) { [weak self] in
            self?.dismiss(animated: true)
            self?.callBack?(true)
        }
    }
}
