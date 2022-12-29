//
//  UiExtentions.swift
//  Drreams
//
//  Created by sunil kumar on 11/12/22.
//

import Foundation

import UIKit
import Foundation




extension UIView {

    
    func mainShadow(){
        let color2 = UIColor(rgb: 0xe0e0eb)

        layer.cornerRadius = 15.0;
        layer.shadowColor =  UIColor.white.cgColor; //color2.cgColor; //UIColor.lightGray.cgColor;
        layer.backgroundColor =  UIColor.white.cgColor; //UIColor.lightGray.cgColor;
        //ayer.borderWidth = 1
        layer.shadowOpacity = 0.50;
        layer.shadowRadius = 15.0;
        layer.shadowOffset = .zero;
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath;
        layer.shouldRasterize = true;
    }
    
    
    func innerShadow(){
        let color2 = UIColor(rgb: 0xe0e0eb)
//        layer.cornerRadius = 15.0;
        layer.shadowColor =  UIColor.lightGray.cgColor; //color2.cgColor;
        layer.backgroundColor =  UIColor.lightGray.cgColor; //UIColor.lightGray.cgColor;
        layer.shadowOpacity = 0.40;
        layer.shadowRadius = 15.0;
        layer.shadowOffset =  CGSize(width: -1, height: -1);
        //layer.shouldRasterize = true;
    }
    
    
    
      // OUTPUT 1
      func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1

        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
      }

      // OUTPUT 2
      func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius

        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
      }
    }
  
    

/*
@IBDesignable
extension UIView {
     // Shadow
     @IBInspectable var shadow: Bool {
          get {
               return layer.shadowOpacity > 0.0
          }
          set {
               if newValue == true {
                    self.addShadow()
               }
          }
     }

     fileprivate func addShadow(shadowColor: CGColor = UIColor.black.cgColor, shadowOffset: CGSize = CGSize(width: 3.0, height: 3.0), shadowOpacity: Float = 0.10, shadowRadius: CGFloat = 25.0) {
          let layer = self.layer
          layer.masksToBounds = false

          layer.shadowColor = shadowColor
          layer.shadowOffset = shadowOffset
          layer.shadowRadius = shadowRadius
          layer.shadowOpacity = shadowOpacity
          layer.shadowPath = UIBezierPath(roundedRect: layer.bounds, cornerRadius: layer.cornerRadius).cgPath

          let backgroundColor = self.backgroundColor?.cgColor
          self.backgroundColor = nil
          layer.backgroundColor =  backgroundColor
     }


     // Corner radius
     @IBInspectable var circle: Bool {
          get {
               return layer.cornerRadius == self.bounds.width*0.5
          }
          set {
               if newValue == true {
                    self.cornerRadius = self.bounds.width*0.5
               }
          }
     }

     @IBInspectable var cornerRadius: CGFloat {
          get {
               return self.layer.cornerRadius
          }

          set {
               self.layer.cornerRadius = newValue
          }
     }


     // Borders
     // Border width
     @IBInspectable
     public var borderWidth: CGFloat {
          set {
               layer.borderWidth = newValue
          }

          get {
               return layer.borderWidth
          }
     }

     // Border color
     @IBInspectable
     public var borderColor: UIColor? {
          set {
               layer.borderColor = newValue?.cgColor
          }

          get {
               if let borderColor = layer.borderColor {
                    return UIColor(cgColor: borderColor)
               }
               return nil
          }
     }
    
    
    
    
}

 */

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}
