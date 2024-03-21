//
//  CustomView.swift
//  Sqimey
//
//  Created by apple on 27/06/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
@IBDesignable
class CustomView: UIView {
    
    @IBInspectable var borderWidth: CGFloat = 0.0{
        didSet{
            
            self.layer.borderWidth = borderWidth
        }
    }
  
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable public var isShadow: Bool = false
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
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }

}


@IBDesignable class ShadowView: UIView {
    
    @IBInspectable var borderWidth: CGFloat = 0.0{
        didSet{
            
            self.layer.borderWidth = borderWidth
        }
    }
    
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        
        didSet {
            
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable public var isShadow: Bool = false
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
 
    @IBInspectable var shadowBlur: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue / 2.0
        }
    }
    
    @IBInspectable var shadowSpread: CGFloat = 0 {
        didSet {
            if shadowSpread == 0 {
                layer.shadowPath = nil
            } else {
                let dx = -shadowSpread
                let rect = bounds.insetBy(dx: dx, dy: dx)
                layer.shadowPath = UIBezierPath(rect: rect).cgPath
            }
        }
    }
}

@IBDesignable
class RoundUIView: UIView {
    
    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 2.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    override func prepareForInterfaceBuilder() {
          super.prepareForInterfaceBuilder()
      }
      
      @IBInspectable public var isGradient : Bool = false{
          didSet{
              self.setNeedsDisplay()
          }
      }
      @IBInspectable public var isHorizontalGradient : Bool = true{
          didSet{
              self.setNeedsDisplay()
          }
      }
       @IBInspectable public var firstColor : UIColor = UIColor.orange{
             didSet{
                 self.setNeedsDisplay()
             }
         }
         @IBInspectable public var secondColor : UIColor  = UIColor.yellow{
             didSet{
                 self.setNeedsDisplay()
             }
         }
      lazy  var gradientLayer: CAGradientLayer = {
          return CAGradientLayer()
      }()
      
      override public init(frame: CGRect) {
          super.init(frame: frame)
          
      }
      required public init?(coder aDecoder: NSCoder) {
          super.init(coder: aDecoder)
          
      }
      func set(gradientColors firstColor:UIColor , secondColor:UIColor){
          self.firstColor = firstColor
          self.secondColor = secondColor
          self.setNeedsLayout()
      }
      override func layoutSubviews() {
             super.layoutSubviews()
             if isGradient == true
             {
                 gradientLayer.frame = self.bounds
                 gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
                 if isHorizontalGradient{
                     gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
                     gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
                 }
                 self.layer.insertSublayer(gradientLayer, at: 0)
                 //            self.layer.addSublayer(gradientLayer)
             }
             else{
                 gradientLayer.removeFromSuperlayer()
             }
             self.setNeedsDisplay()
         }
}
extension UIButton {
    
    func applyGradients(colours: [UIColor?]) -> CAGradientLayer {
        return self.applyGradient(colours: colours, locations: nil)
    }

    func applyGradient(colours: [UIColor?], locations: [NSNumber]?) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0!.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
        return gradient
    }
}
