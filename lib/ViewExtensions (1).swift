//
//  ViewExtensions.swift
//  Hedef Bilsem
//
//  Created by Ahmet Ekti on 20.08.2020.
//  Copyright © 2020 freelancer.istanbul.hedefbilsem. All rights reserved.
//

import UIKit

extension UIView {
    
    //MARK: - Getters
    func frameX() -> CGFloat {
        return frame.origin.x
    }
    
    func frameY() -> CGFloat {
        return frame.origin.y
    }
    
    func frameWidth() -> CGFloat {
        return frame.size.width
    }
    
    func frameHeight() -> CGFloat {
        return frame.size.height
    }
    
    //MARK: - Setters
    func setFrameX(x: CGFloat) {
        frame = CGRect(x: x, y: frame.origin.y, width: frame.size.width, height: frame.size.height)
    }
    
    func setFrameY(y: CGFloat) {
        frame = CGRect(x: frame.origin.x, y: y, width: frame.size.width, height: frame.size.height)
    }
    
    func setFrameWidth(width: CGFloat) {
        frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: width, height: frame.size.height)
    }
    
    func setFrameHeight(height: CGFloat) {
        frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: height)
    }
    
    func cornerRadius(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}

// MARK: V0.0.7 EKLENDİ GÖLGELENDİR
extension CALayer {
  func applySketchShadow(
    color: UIColor = Color._96A3AC,
    alpha: Float = 0.5,
    x: CGFloat = 0,
    y: CGFloat = 2,
    blur: CGFloat = 4,
    spread: CGFloat = 0)
  {
    masksToBounds = false
    shadowColor = color.cgColor
    shadowOpacity = alpha
    shadowOffset = CGSize(width: x, height: y)
    shadowRadius = blur / 2.0
    if spread == 0 {
      shadowPath = nil
    } else {
      let dx = -spread
      let rect = bounds.insetBy(dx: dx, dy: dx)
      shadowPath = UIBezierPath(rect: rect).cgPath
    }
      cornerRadius = 8
  }
}


extension UIView {

    func set_shadow(cornerRadius : CGFloat = 8.0){

        var shadowLayer: CAShapeLayer!

        shadowLayer = CAShapeLayer()
        shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        shadowLayer.fillColor = UIColor.white.cgColor
        shadowLayer.shadowColor = UIColor.darkGray.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: 8.0, height: 8.0)
        shadowLayer.shadowOpacity = 1
        shadowLayer.shadowRadius = 2

        self.layer.mask = shadowLayer
        //layer.insertSublayer(shadowLayer, below: nil) // also works
        
    }
}


extension UIView {

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
