//
//  TabBarVC.swift
//  AirCloset
//
//  Created by cql105 on 31/03/23.
//

import UIKit
import SwiftyJSON

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
        self.connect()
        self.getCount()
        SocketIOManager.sharedInstance.delegate = self
        addRedDotAtTabBarItemIndex(index: 1)
    }
    
    func addRedDotAtTabBarItemIndex(index: Int) {
        guard let tabBarItems = tabBarController?.tabBar.items, index < tabBarItems.count else {
            return
        }

        // Remove any existing red dot with the specified tag
        if let existingRedDot = tabBarController?.tabBar.viewWithTag(1234) {
            existingRedDot.removeFromSuperview()
        }

        let redDotRadius: CGFloat = 5
        let redDotDiameter = redDotRadius * 2
        let topMargin: CGFloat = 5

        let tabBarItemCount = CGFloat(tabBarItems.count)
        let screenSize = UIScreen.main.bounds
        let halfItemWidth = (screenSize.width) / (tabBarItemCount * 2)

        guard index < tabBarItems.count,
            let selectedImage = tabBarItems[index].selectedImage else {
                return
        }

        let imageHalfWidth: CGFloat = selectedImage.size.width / 2
        let xOffset = halfItemWidth * CGFloat(index * 2 + 1)

        // Create a UIImageView for the badge icon
        let redDotImageView = UIImageView(image: selectedImage)
        redDotImageView.frame = CGRect(x: xOffset + imageHalfWidth - redDotRadius, y: topMargin, width: redDotDiameter, height: redDotDiameter)

        // Customize the badge icon view
        redDotImageView.tag = 1234
        redDotImageView.tintColor = UIColor.red // Customize the color if needed
        redDotImageView.contentMode = .scaleAspectFit // Adjust the content mode as needed

        tabBarController?.tabBar.addSubview(redDotImageView)
    }
    
    //MARK: - Report User Emitter

    private func getCount(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.socketConnected(notification:)), name: Notification.Name("socketConnected"), object: nil)
        SocketIOManager.sharedInstance.countEmitter()
    }
    @objc func socketConnected(notification: Notification) {
        SocketIOManager.sharedInstance.countEmitter()
    }
    func connect() {
        SocketIOManager.sharedInstance.connectUser()
    }
}


extension TabBarVC : SocketDelegate {
    func listenedData(data: JSON, response: String) {
        do{
            let chatData = try JSONDecoder().decode(CountModel.self, from: data.arrayValue.first?.rawData() ?? Data())
            print(chatData,"sdfsdfsdf")
            if chatData.count >= 0 {
                if chatData.count > 99 {
                    self.tabBar.items![1].badgeValue = "99+"
                    self.tabBar.items![1].badgeColor = UIColor(red: 221/255, green: 57/255, blue: 135/255, alpha: 1)
                } else if chatData.count > 0{
                    self.tabBar.items![1].badgeValue = "\(chatData.count)"
                    self.tabBar.items![1].badgeColor = UIColor(red: 221/255, green: 57/255, blue: 135/255, alpha: 1)
                } else {
                    self.tabBar.items![1].badgeColor = .clear
                }
            } else {
                self.tabBar.items![1].badgeColor = .clear
            }
        }  catch let error {
            print("Error \(error.localizedDescription)")
        }
    }
}
