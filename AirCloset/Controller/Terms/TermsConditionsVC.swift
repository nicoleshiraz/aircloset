//
//  TermsConditionsVC.swift
//  AirCloset
//
//  Created by cql105 on 27/04/23.
//

import UIKit

class TermsConditionsVC: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var termsTextVw: UITextView!
    @IBOutlet weak var saveBtnView: CustomView!
    
    var type = String()
    var termAndCondTxt : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        termsTextVw.delegate = self
        
        if type == "post"{
            saveBtnView.isHidden = false
            termsTextVw.isEditable = true
            self.termsTextVw.text = Singletone.shared.clothsTermsAndCon
        } else if type == "Profile" {
            saveBtnView.isHidden = true
            termsTextVw.isEditable = false
            self.termsTextVw.text = Singletone.shared.clothsTermsAndCon
        } else {
            termsTextVw.text = termAndCondTxt ?? ""
            saveBtnView.isHidden = true
            termsTextVw.isEditable = false
        }
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
    }
    
    @IBAction func tapBackBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapSaveBtn(_ sender: UIButton) {
        Singletone.shared.clothsTermsAndCon = termsTextVw.text ?? ""
        self.navigationController?.popViewController(animated: false)
    }
}
