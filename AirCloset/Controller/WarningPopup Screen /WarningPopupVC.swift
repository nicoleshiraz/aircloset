//
//  WarningPopupVC.swift
//  AirCloset
//
//  Created by cqlios3 on 13/03/24.
//

import UIKit

class WarningPopupVC: UIViewController {
    // MARK: - OUTLET
    @IBOutlet weak var lblWarningDescription: UILabel!
    
    //     MARK: - LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setText()
        
    }
    //MARK: FUNCTION
    func setText() {
        let text = "Orders made outside of the app will not be covered for loss, theft and damage protection. A $3 fee applies for all bookings to ensure protection for both parties."

        // Split text by period and add two line breaks after each period
        let formattedText = text.components(separatedBy: ".").joined(separator: ". \n\n") // Use "\n\n" for two line breaks

        // Create attributed string with formatted text
        let attributedString = NSMutableAttributedString(string: formattedText)

        // Set attributed text to label
        lblWarningDescription.attributedText = attributedString
    }
    //MARK: ACTION
    @IBAction func btnConfirm(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

