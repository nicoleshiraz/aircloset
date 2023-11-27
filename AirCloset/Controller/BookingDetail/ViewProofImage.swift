//
//  ViewProofImage.swift
//  AirCloset
//
//  Created by cqlios3 on 16/10/23.
//

import UIKit
import SDWebImage
import Foundation

class ViewProofImage : UIViewController {
    
    @IBOutlet weak var showImage: UIImageView!
    var proofImage = String()
    
    //------------------------------------------------------
    
    //MARK: Memory Management Method
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //------------------------------------------------------
    
    deinit { //same like dealloc in ObjectiveC
        
    }
    
    //------------------------------------------------------
    
    //MARK: Action
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    //------------------------------------------------------
    
    //MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showImage.sd_setImage(with: URL.init(string: proofImage),placeholderImage: UIImage(named: "iconPlaceHolder"))

    }
    
    //------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //------------------------------------------------------
}
