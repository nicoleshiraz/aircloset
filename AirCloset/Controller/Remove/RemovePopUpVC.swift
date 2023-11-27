//
//  RemovePopUpVC.swift
//  AirCloset
//
//  Created by cqlnitin on 15/04/23.
//

import UIKit
//Mark:--> Protocol
protocol RemoveProtocol{
    func removePop(address : Int)
}

var callback: (()->())?

class RemovePopUpVC: UIViewController {
    //Mark:--> Variables
    var removeObj : RemoveProtocol?
    var callBack: (()->())?
    @IBOutlet weak var removeLbl: UILabel!
    var removeVM = MyClosetViewModel()
    var productID = String()
    
    //Mark:--> View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isTab == "Remove"{
            removeLbl.text = "Are you sure want to remove this closet?"
        }else if isTab == "Cancel"{
            removeLbl.text = "Are you sure want to cancel order?"
        }
    }
    
    //Mark:--> Actions
    @IBAction func tapYesBtn(_ sender: UIButton) {
        
        switch isTab {
        case "Remove":
            callBackMyCloset?()
            callBack?()
            removeProduct(paramss: ["_id": productID])
        default:
            break
        }
        
//        removeProduct(paramss: ["_id": productID])
//        self.dismiss(animated: true, completion: {
//            self.removeObj?.removePop(address: 1)
//        })
    }
    
    @IBAction func tapNoBtn(_ sender: UIButton) {
        callBack?()
        self.dismiss(animated: true, completion: nil)
    }
}

extension RemovePopUpVC {
    
    private func removeProduct(paramss: [String:Any]) {
        removeVM.deleteProduct(params: paramss) { [weak self] in
            self?.dismiss(animated: true, completion: {
                self?.removeObj?.removePop(address: 1)
            })
        }
    }
}
