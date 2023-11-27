//
//  TabBarVC.swift
//  AirCloset
//
//  Created by cql105 on 31/03/23.
//

import UIKit

class TabBarVC: UITabBarController, UITabBarControllerDelegate {
    
    //Mark :--> View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        tabBar.layer.shadowColor = UIColor.lightGray.cgColor
        tabBar.layer.shadowOpacity = 0.5
        tabBar.layer.shadowOffset = CGSize.zero
        tabBar.layer.shadowRadius = 5
        self.tabBar.layer.borderColor = UIColor.clear.cgColor
        self.tabBar.layer.borderWidth = 0
        self.tabBar.clipsToBounds = false
        self.tabBar.backgroundColor = UIColor.white
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
   //     isTab = "MyCloset"
    }
}
