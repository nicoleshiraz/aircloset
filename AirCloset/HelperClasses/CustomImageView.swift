//
//  CustomImageView.swift
//  Sqimey
//
//  Created by apple on 04/07/19.
//  Copyright © 2019 apple. All rights reserved.
//

import Foundation

import Foundation


import UIKit
@IBDesignable
public  class CustomImageView: UIImageView {
    
    @IBInspectable public var imageColor: UIColor = .clear {
        didSet {
            if imageColor != .clear {
                guard  let image = self.image else{return}
                let tmImage  = image.withRenderingMode(.alwaysTemplate)
                self.image = tmImage
                self.tintColor = imageColor
            }
        }
    }
    
    @IBInspectable public var cornerRadius: CGFloat = 2.5 {
        didSet {
            layer.cornerRadius = cornerRadius
            
        }
    }
    @IBInspectable public var shadowColor: UIColor = UIColor.black {
        didSet {
            
            layer.shadowColor = shadowColor.cgColor
        }
    }
    
    @IBInspectable public var shadowOpacity: Float = 0.5 {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }
    @IBInspectable public var shadowOffset: CGSize = CGSize(width: 0, height: 3) {
        didSet {
            layer.shadowOffset = shadowOffset
        }
    }
    @IBInspectable public var shadowRadius : CGFloat = 3
        {
        didSet
        {
            layer.shadowRadius = shadowRadius
        }
    }
    
    
    @IBInspectable public var borderColor: UIColor =  UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
            //mkLayer.setMaskLayerCornerRadius(cornerRadius)
        }
    }
    @IBInspectable public var borderWidth: CGFloat =  0 {
        didSet {
            layer.borderWidth = borderWidth
            //mkLayer.setMaskLayerCornerRadius(cornerRadius)
        }
    }
    @IBInspectable public var masksToBounds : Bool = false
        {
        didSet
        {
            layer.masksToBounds = masksToBounds
        }
    }
    @IBInspectable public var clipsToBound : Bool = false
        {
        didSet
        {
            self.clipsToBounds = clipsToBound
        }
    }
    
    
    
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    override public init(image: UIImage?) {
        super.init(image: image)
        
        
    }
    
    override public init(image: UIImage?, highlightedImage: UIImage?) {
        super.init(image: image, highlightedImage: highlightedImage)
        self.sizeToFit()
    }
    var isShouldUpdate:Bool = false
    private var imageSize = CGSize(width: 1920, height: 2038)
    func resizeImage()->CGSize{
        guard let image = self.image else { return .zero}
        if imageSize != image.size {
            imageSize = image.size
            isShouldUpdate = true
        }
        let aspect = imageSize.width / imageSize.height
        let newWidth = self.bounds.width
        let newHeight = self.bounds.width * aspect
        //        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        //        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        //        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        //        UIGraphicsEndImageContext()
        //        return newImage
        self.sizeThatFits(CGSize(width: newWidth, height: newHeight))
        self.sizeToFit()
        return CGSize(width: newWidth, height: newHeight)
    }
    
}
