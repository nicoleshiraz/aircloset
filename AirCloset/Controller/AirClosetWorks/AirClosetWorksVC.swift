//
//  AirClosetWorksVC.swift
//  AirCloset
//
//  Created by cql105 on 13/04/23.
//

import UIKit

class AirClosetWorksVC: UIViewController {
    //Mark:--> Outlets & Variables
    @IBOutlet weak var titleLabel: UILabel!
    var isComeFrom = 0
    @IBOutlet weak var textVw: UITextView!
    var vwModel = AuthViewModel()

    //Mark:--> View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if isComeFrom == 0 {
            titleLabel.text = "How Aircloset works?"
            getCmsData(typeID: 3)
        } else if isComeFrom == 1 {
            titleLabel.text = "Contact Support"
            getCmsData(typeID: 4)
        } else if isComeFrom == 2 {
            titleLabel.text = "About Us"
            getCmsData(typeID: 2)
        }else if isComeFrom == 3 {
            titleLabel.text = "Terms and Conditions"
            getCmsData(typeID: 0)
        }else if isComeFrom == 4 {
            titleLabel.text = "Privacy Policy"
            getCmsData(typeID: 1)
        }
    }

    func getCmsData(typeID : Int){
        vwModel.cmsApi(type: "\(typeID)")
        vwModel.onSuccess = { [weak self]  in
            self?.textVw.attributedText = self?.vwModel.cmsModel?.body?.content?.htmlToAttributedString
        }
    }

    //Mark:--> Actions
    @IBAction func tapBackBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension String{
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
}
