//
//  ReportPopUpVC.swift
//  AirCloset
//
//  Created by cql105 on 03/04/23.
//

import UIKit

//MARK: -> Protocol

protocol ReportProtocol{
    func removeReportPop(address : Int)
}

class ReportPopUpVC: UIViewController {
    
    //MARK: -> Outlets & Variables
    
    @IBOutlet weak var reportTextVw: UITextView!
    @IBOutlet weak var lblDescrption: UILabel!
    
    var reportObj : ReportProtocol?
    var callBack: ((Bool, String)->())?
    var name = String()
    
    //MARK: -> View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblDescrption.text = "Why do you want to report \(name)?"
        reportTextVw.layer.cornerRadius = 10
        reportTextVw.layer.borderColor = UIColor.lightGray.cgColor
        reportTextVw.layer.borderWidth = 1
    }
    
    //MARK: -> Actions
    
    @IBAction func tapSubmitBtn(_ sender: UIButton) {
        
        if reportTextVw.text == "" {
            CommonUtilities.shared.showSwiftAlert(message: "Please add report message.", isSuccess: .error)
        } else {
            self.dismiss(animated: true, completion: {
                self.callBack?(true, self.reportTextVw.text ?? "")
                self.reportObj?.removeReportPop(address: 1)
            })
        }
    }
    
    @IBAction func tapCancelBtn(_ sender: UIButton) {
        callBack?(false, reportTextVw.text ?? "")
        self.dismiss(animated: true, completion: nil)
    }
}
