//
//  ViewProfileImgVC.swift
//  AirCloset
//
//  Created by cql200 on 23/06/23.
//

import UIKit

class ViewProfileImgVC: UIViewController {

    @IBOutlet weak var profileImgVw: UIImageView!
    
    var profileImg : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImgVw.image = profileImg
        
    }

    @IBAction func backBtnTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

}
