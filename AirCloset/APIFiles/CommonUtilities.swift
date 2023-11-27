//
//  CommonUtilities.swift
//  Schedula
//
//  Created by apple on 11/09/19.
//  Copyright © 2019 apple. All rights reserved.
//

import Foundation
import UIKit
import SwiftMessages

class CommonUtilities
{
    static let shared = CommonUtilities()
    
    func showAlert(message :String)
    {
        DispatchQueue.main.async
            {
                let alert = UIAlertController(title: appName, message: message, preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
                })
                
                alert.addAction(ok)
                DispatchQueue.main.async {
                    if let window = UIApplication.shared.keyWindow{
                        DispatchQueue.main.async {
                            window.rootViewController!.present(alert, animated: true)
                            
                        }
                    }
                }
        }
    }
    func showAlertCustomeBrn(message :String,OkMove:((UIAlertAction) -> Void)?,CancelMove:((UIAlertAction) -> Void)?)
    {
        
        let alert = UIAlertController(title: appName, message: message, preferredStyle: .alert)
        let firstAction = UIAlertAction(title: "No", style: .destructive, handler: CancelMove)
        
        let secondAction = UIAlertAction(title: "Ok", style: .default, handler: OkMove)
        
        alert.addAction(firstAction)
        alert.addAction(secondAction)
        
        DispatchQueue.main.async {
            if let window = UIApplication.shared.keyWindow{
                DispatchQueue.main.async {
                    window.rootViewController!.present(alert, animated: true)
                    
                }
            }
        }
    }
    
    func showAlert(title: String?, message: String?, actionTitles:[String?], actions:[((UIAlertAction) -> Void)?])
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, title) in actionTitles.enumerated()
        {
            if title == NSLocalizedString("Cancel", comment: appName)
            {
                let action = UIAlertAction(title: title, style: .cancel, handler: actions[index])
                alert.addAction(action)
            }
            else
            {
                let action = UIAlertAction(title: title, style: .default, handler: actions[index])
                alert.addAction(action)
            }
        }
        DispatchQueue.main.async {
            if let window = UIApplication.shared.keyWindow{
                DispatchQueue.main.async {
                    window.rootViewController!.present(alert, animated: true)
                    
                }
            }
        }
    }
    
    func showSwiftAlert( Title :String = "", message: String , isSuccess : Theme,  duration: TimeInterval = 2){
        SwiftMessages.hideAll()
        DispatchQueue.main.async {
            let warning = MessageView.viewFromNib(layout: .cardView)
            warning.configureTheme(isSuccess)
            warning.backgroundView.backgroundColor = (isSuccess == .success) ? #colorLiteral(red: 0.8196078431, green: 0.3098039216, blue: 0.7803921569, alpha: 1) : #colorLiteral(red: 0.8196078431, green: 0.3098039216, blue: 0.7803921569, alpha: 1)
            warning.configureContent(title: Title, body: message)
            warning.button?.isHidden = true
            var warningConfig = SwiftMessages.defaultConfig
            warningConfig.presentationContext = .window(windowLevel: UIWindow.Level.statusBar)
            warningConfig.duration = .seconds(seconds: duration)
            SwiftMessages.show(config: warningConfig, view: warning)
        }
    }
}
