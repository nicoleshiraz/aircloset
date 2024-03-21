//
//  CustomTextField.swift
//  Sqimey
//
//  Created by apple on 27/06/19.
//  Copyright © 2019 apple. All rights reserved.
//


import Foundation
import UIKit
import QuartzCore

private var maxLengths = [UITextField: Int]()

@IBDesignable

open class CustomTextField : UITextField {
    
    typealias  AccessoryIconClickEventBlock = (_ sender:CustomButton)->Void
    var clickEventBlock:AccessoryIconClickEventBlock!
    @IBInspectable public var padding: CGSize = CGSize(width: 5, height: 5)
    @IBInspectable public var floatingLabelBottomMargin: CGFloat = 2.0
    @IBInspectable public var floatingPlaceholderEnabled: Bool = false
    @IBInspectable public var floatingLabelFont: UIFont =  UIFont.systemFont(ofSize: 14)
    
    @IBInspectable var maxLength: Int {
        
        get {
            
            guard let length = maxLengths[self]
                else {
                    return Int.max
            }
            return length
        }
        set {
            maxLengths[self] = newValue
            addTarget(
                self,
                action: #selector(limitLength),
                for: UIControl.Event.editingChanged
            )
        }
    }
    @objc func limitLength(textField: UITextField) {
        guard let prospectiveText = textField.text,
            prospectiveText.count > maxLength
            else {
                return
        }
        
        let selection = selectedTextRange
        let maxCharIndex = prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)
        text = prospectiveText.substring(to: maxCharIndex)
        selectedTextRange = selection
    }
    var paddingButton: CustomButton?
    
    
    @IBInspectable public var leftSelected: UIImage?{
        didSet {
            
            leftBtn.setImage(leftSelected, for: .selected)
            
        }
    }
    @IBInspectable public var leftDisabled: UIImage?{
        didSet {
            
            leftBtn.setImage(leftDisabled, for: .disabled)
            
        }
    }
    @IBInspectable public var leftHighlighted: UIImage?{
        didSet {
            
            leftBtn.setImage(leftHighlighted, for: .highlighted)
            
        }
    }
    
    
    @IBInspectable public var leftIcon: UIImage? {
        didSet {
            if leftIcon == nil {
                self.leftView = nil
                self.leftViewMode = .never
            }else{
                leftBtn.setImage(leftIcon, for: .normal)
                self.left()
            }
        }
    }
    
    @IBInspectable public var rightSelected: UIImage?{
        didSet {
            rightBtn.setImage(rightSelected, for: .selected)
            
        }
    }
    @IBInspectable public var rightDisabled: UIImage?{
        didSet {
            
            rightBtn.setImage(rightDisabled, for: .disabled)
            
        }
    }
    @IBInspectable public var rightHighlighted: UIImage?{
        didSet {
            
            rightBtn.setImage(rightHighlighted, for: .highlighted)
            
        }
    }
    
    @IBInspectable public var rightIcon: UIImage? {
        didSet {
            if rightIcon == nil {
                self.rightView = nil
                self.rightViewMode = .never
            }else{
                rightBtn.setImage(rightIcon, for: .normal)
                self.right()
            }
            
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
    
    @IBInspectable public var cornerRadius: CGFloat = 2.5 {
        didSet {
            layer.cornerRadius = cornerRadius
            
        }
    }
    @IBInspectable public var boarderColor: UIColor = UIColor.clear
        {
        didSet{
            layer.borderColor = boarderColor.cgColor
            
        }
    }
    
    @IBInspectable public var borderWidth: CGFloat =  0 {
        didSet {
            layer.borderWidth = borderWidth
            
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
    @IBInspectable public var placeholderColor : UIColor = UIColor.gray
        {
        didSet
        {
            
            self.textFieldPlaceholderColor(color: placeholderColor)
        }
    }
    @IBInspectable public var clearButtonColor:UIColor = UIColor.white{
        didSet{
            
            self.setEditClearBtnColor()
        }
        
    }
    public func setEditClearBtnColor(){
        if self.clearButtonMode != .never  {
            
            if let clearButton = self.value(forKeyPath: "_clearButton") as? UIButton {
                
                //let normalImage = clearButton.image(for: .normal)?.withRenderingMode(.alwaysTemplate)
                // let highlightedImage = clearButton.image(for: .highlighted)?.withRenderingMode(.alwaysTemplate)
                if let img = UIImage(named:"clearButton") {
                    clearButton.setImage(img.withRenderingMode(.alwaysTemplate), for: .normal)
                    // clearButton.setImage(highlightedImage, for: .highlighted)
                    clearButton.tintColor = clearButtonColor
                }
                
                
                
            }
            self.setNeedsLayout()
        }
        
    }
    func textFieldPlaceholderColor(color:UIColor)
    {
        if (self.placeholder != nil) {
            
            let attibutedStr:NSAttributedString=NSAttributedString(string: self.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: color]);
            self.attributedPlaceholder=attibutedStr
        }
        
    }
    
    
    // floating label
    
    @IBInspectable public var floatingTextColor: UIColor = UIColor.lightGray {
        didSet {
            floatingLabel.textColor = floatingTextColor
        }
    }
    
    @IBInspectable public var bottomBorderEnabled: Bool = false {
        didSet {
            bottomBorderLayer?.removeFromSuperlayer()
            bottomBorderLayer = nil
            if bottomBorderEnabled {
                bottomBorderLayer = CALayer()
                bottomBorderLayer?.frame = CGRect(x: 0, y: layer.bounds.height - 1, width: bounds.width, height: 1)
                //bottomBorderLayer?.backgroundColor = CustomColor.Grey.cgColor
                layer.addSublayer(bottomBorderLayer!)
                
            }
        }
    }
    
    
    
    @IBInspectable public var bottomBorderWidth: CGFloat = 1.0
    @IBInspectable public var bottomBorderColor: UIColor = UIColor.lightGray
    @IBInspectable public var bottomBorderHighlightWidth: CGFloat = 1.75
    
    override open var placeholder: String? {
        didSet {
            updateFloatingLabelText()
        }
    }
    override open var bounds: CGRect {
        didSet {
            
        }
    }
    
    fileprivate var floatingLabel: UILabel!
    private var bottomBorderLayer: CALayer?
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupLayer()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayer()
    }
    
    private func setupLayer() {
        cornerRadius = 2.5
        layer.borderWidth = 1.0
        borderStyle = .none
        
        
        // floating label
        floatingLabel = UILabel()
        floatingLabel.font = floatingLabelFont
        floatingLabel.alpha = 0.0
        floatingLabel.textAlignment = textAlignment
        self.updateFloatingLabelText()
        
        addSubview(floatingLabel)
    }
    
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        if floatingPlaceholderEnabled {
            if !text!.isEmpty {
                floatingLabel.textColor = isFirstResponder ? tintColor : floatingTextColor
                if floatingLabel.alpha == 0 {
                    showFloatingLabel()
                }
            } else {
                hideFloatingLabel()
            }
        }
        if bottomBorderEnabled {
            bottomBorderLayer?.backgroundColor = isFirstResponder ? tintColor.cgColor : bottomBorderColor.cgColor
            let borderWidth = isFirstResponder ? bottomBorderHighlightWidth : bottomBorderWidth
            bottomBorderLayer?.frame = CGRect(x: 0, y: layer.bounds.height - borderWidth, width: layer.bounds.width, height: borderWidth)
        }
        setEditClearBtnColor()
        
    }
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        
        
        let rect = super.textRect(forBounds: bounds)
        
        var newRect = CGRect(x: rect.origin.x + padding.width, y: rect.origin.y,
                             width: rect.size.width - 2*padding.width, height: rect.size.height)
        
        if !floatingPlaceholderEnabled {
            return newRect
        }
        
        if !text!.isEmpty {
            
            
            var dTop = ceil(floatingLabel.font.lineHeight + floatingLabelBottomMargin)
            dTop = min(dTop, maxTopInset())
            //   let dTop = floatingLabel.font.lineHeight + floatingLabelBottomMargin
            newRect = newRect.inset(by:UIEdgeInsets(top: dTop, left: 0.0, bottom: 0.0, right: 0.0))
        }
        return newRect
    }
    fileprivate func maxTopInset()->CGFloat {
        if let fnt = font {
            return max(0, floor(bounds.size.height - fnt.lineHeight - 4.0))
        }
        return 0
    }
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
    
    
    // MARK - private methods
    private func setFloatingLabelForTextAligment() {
        let textRect = self.textRect(forBounds: bounds)
        var originX = textRect.origin.x
        
        
        switch textAlignment {
        case .center:
            
            originX = textRect.origin.x + (textRect.size.width * 0.5) - floatingLabel.frame.size.width
        case .right:
            
            //originX += textRect.size.width - floatingLabel.bounds.width
            originX = textRect.origin.x + textRect.size.width - floatingLabel.bounds.width
        default:
            originX += 30
            break
        }
        
        floatingLabel.frame = CGRect(x: originX, y: padding.height,
                                     width: floatingLabel.frame.size.width, height: floatingLabel.frame.size.height)
    }
    
    private func showFloatingLabel() {
        let curFrame = floatingLabel.frame
        floatingLabel.frame = CGRect(x: curFrame.origin.x, y: bounds.height/2, width: curFrame.width, height: curFrame.height)
        UIView.animate(withDuration: 0.45, delay: 0.0, options: .curveEaseOut,
                       animations: {
                        self.floatingLabel.alpha = 1.0
                        self.floatingLabel.frame = curFrame
        }, completion: nil)
    }
    
    private func hideFloatingLabel() {
        floatingLabel.alpha = 0.0
    }
    
    private func updateFloatingLabelText() {
        floatingLabel.text = placeholder
        floatingLabel.sizeToFit()
        setFloatingLabelForTextAligment()
    }
    
    public typealias Action = (CustomTextField) -> Void
    
    fileprivate var actionEditingChanged: Action?
    
    public func didChangeAction(closure: @escaping Action) {
        if actionEditingChanged == nil {
            addTarget(self, action: #selector(CustomTextField.textFieldDidChange), for: .editingChanged)
        }
        actionEditingChanged = closure
    }
    
    @objc func textFieldDidChange(_ textField: CustomTextField) {
        actionEditingChanged?(self)
    }
    
    //MARK:- FLOATING LABEL
    
    @IBInspectable public var floatingLabelTextColor: UIColor = UIColor.lightGray {
        didSet {
            floatingLabel.textColor = floatingLabelTextColor
        }
    }
    //MARK: - PADDING VIEW
    
    internal lazy var leftBtn:CustomButton = {
        let button = CustomButton(type: .custom)
        return button
    }()
    internal lazy var rightBtn:CustomButton = {
        let button = CustomButton(type: .custom)
        
        return button
    }()
    //MARK:- leftView -
    func left(onCompletion :AccessoryIconClickEventBlock? = nil)
    {
        guard let icon = leftBtn.image(for: UIControl.State()) else {return}
        var iconWidth  = icon.size.width
        let iconHeight  = self.bounds.size.height
        if iconWidth > self.bounds.size.width {
            iconWidth = iconHeight
        }
        
        leftBtn.frame = CGRect(x: 0, y: 0, width:  iconWidth+padding.width, height: iconHeight)
        leftBtn.imageEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 0, right: 0)//tlbr
        if onCompletion != nil {
            clickEventBlock = onCompletion
            leftBtn.addTarget(self, action:#selector(leftBtnClick), for: .touchUpInside)
        }
        
        self.leftView = leftBtn
        self.leftViewMode = .always
        
    }
    @objc fileprivate func leftBtnClick(_ sender:CustomButton){
        let simage = sender.image(for: .selected)
        if  (simage != nil) {
            sender.isSelected =   sender.isSelected == false ? true : false
        }
        if (clickEventBlock != nil) {
            clickEventBlock(sender)
        }
    }
    
    //MARK:- rightView -
    func right(onCompletion :AccessoryIconClickEventBlock? = nil)
    {
        guard let icon = rightBtn.image(for: UIControl.State()) else { return}
        var iconWidth  = icon.size.width
        let iconHeight  = self.bounds.size.height
        if iconWidth > self.bounds.size.width {
            iconWidth = iconHeight+padding.width
        }
        rightBtn.frame = CGRect(x: 0, y: 0, width:  iconWidth, height: iconHeight )
        rightBtn.imageEdgeInsets = UIEdgeInsets(top: 2, left: 0, bottom: 0,right: 2)
        
        if onCompletion != nil {
            clickEventBlock = onCompletion
            rightBtn.addTarget(self, action:#selector(rightBtnClick), for: .touchUpInside)
        }
        self.rightView = rightBtn
        self.rightViewMode = .always
    }
    @objc func rightBtnClick(_ sender:CustomButton){
        let simage = sender.image(for: .selected)
        if  (simage != nil) {
            sender.isSelected =  sender.isSelected == false ? true : false
        }
        if (clickEventBlock != nil) {
            clickEventBlock(sender)
        }
    }
    
}
