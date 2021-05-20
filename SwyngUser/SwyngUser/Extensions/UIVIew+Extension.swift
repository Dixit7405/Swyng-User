//
//  UIVIew+Extension.swift
//  VideoMaker
//
//  Created by Dixit Rathod on 23/08/20.
//  Copyright © 2020 Dixit Rathod. All rights reserved.
//

import Foundation
import UIKit

//MARK: - UIVIEW EXTENSION
extension UIView{
    func takeScreenshot() -> UIImage {

        // Begin context
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)

        // Draw view in that context
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)

        // And finally, get image
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        if let img = image
        {
            return img
        }
        return UIImage()
    }
    
    @IBInspectable var roundedView:Bool{
        get{
            return false
        }
        set{
            if newValue{
                self.layer.cornerRadius = self.bounds.size.height/2
                self.layer.masksToBounds = true
            }
        }
    }
    
    @IBInspectable var cornerRadius:CGFloat{
        get{
            return self.layer.cornerRadius
        }
        set{
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = true
        }
    }
    
    @IBInspectable var borderColor:UIColor{
        get{
            return UIColor(cgColor: self.layer.borderColor ?? UIColor.clear.cgColor)
        }
        set{
            self.layer.borderColor = newValue.cgColor
        }
    }
    
    func addGradientColor(location:[NSNumber], startPoint:CGPoint, endPoint:CGPoint, colors:[CGColor]){
        self.layer.sublayers?.forEach({
            if $0.name == "Gradient"{
                $0.removeFromSuperlayer()
            }
        })
        
        let gradient: CAGradientLayer = CAGradientLayer()

        gradient.colors = colors
        gradient.locations = location
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        gradient.name = "Gradient"
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.frame.size.width, height: self.frame.size.height)

        self.layer.insertSublayer(gradient, at: 0)
    }
    
    @IBInspectable var borderWidth:CGFloat{
        get{return self.layer.borderWidth}
        set{self.layer.borderWidth = newValue}
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func dropShadow(color: UIColor, opacity: Float = 1.0, offSet: CGSize = CGSize(width: 0.0, height: 5.0), radius: CGFloat = 3.0, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        updateShadowPath()
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func updateShadowPath(){
        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
    }
}

//MARK: - UIBUTTON
extension UIButton{
    func setSelected(selected:Bool){
        self.backgroundColor = selected ? UIColor.AppColor.themeColor : UIColor.white
        self.setTitleColor(selected ? UIColor.white : UIColor.AppColor.appBlack ?? .clear, for: .normal)
    }
}
