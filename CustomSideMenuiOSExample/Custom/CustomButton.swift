//
//  CustomButton.swift
//  HomeOnline
//
//  Created by Rishabh Sood on 25/07/19.
//  Copyright © 2019 Amit Pandey. All rights reserved.
//

import UIKit

@IBDesignable class CustomButton: UIButton {

    @IBInspectable var imageTintColor: UIImage? {
        didSet {
            let navBtnImage = imageTintColor!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            setImage(navBtnImage, for: .normal)
        }
    }
    
    @IBInspectable var rotateAngle: CGFloat = 0 {
           didSet {
               let radians = CGFloat(CGFloat(Double.pi) * CGFloat(rotateAngle) / CGFloat(180.0))
               self.transform = CGAffineTransform(rotationAngle: radians)
           }
       }
    
    @IBInspectable var numberOfLines: Int{
        get {
            return self.titleLabel!.numberOfLines
        }
        set {
            self.titleLabel!.numberOfLines = Int(newValue)
            self.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        }
    }

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    @IBInspectable var shadow: UIColor? {
        didSet {
            layer.shadowColor = shadow?.cgColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.setBackgroundImage(#imageLiteral(resourceName: "share"), for: .normal)
    }
    
    func setCornerWithRadius(color:CGColor,radius:CGFloat){
        self.layer.cornerRadius = radius
        self.layer.borderWidth = 1.0
        self.layer.borderColor = color
        self.layer.masksToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}


extension UIButton {
    //https://www.swiftdevcenter.com/how-to-create-gradient-color-using-cagradientlayer/
    enum Direction: Int {
        case topToBottom = 0
        case bottomToTop
        case leftToRight
        case rightToLeft
    }
    
    func applyGradient(colors: [Any]?, locations: [NSNumber]? = [0.0, 1.0], direction: Direction = .topToBottom) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = colors
        gradientLayer.locations = locations
        
        switch direction {
        case .topToBottom:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
            
        case .bottomToTop:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
            
        case .leftToRight:
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
            
        case .rightToLeft:
            gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
        }
        self.layer.addSublayer(gradientLayer)
    }
}
