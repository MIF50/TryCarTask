//
//  CardView.swift
//  TryCarTask
//
//  Created by Mohamed Ibrahim on 5/15/21.
//

import UIKit

// MARK:- CUSTOM CARD VIEW
@IBDesignable class CardView: UIView {
    
    @IBInspectable var cRadius: CGFloat = 4 {
        didSet {
            setLayout()
        }
    }
    
    @IBInspectable var shadowOffsetWidth: CGFloat = 0.5 {
        didSet {
            setLayout()
        }
    }
    
    @IBInspectable var shadowOffsetHeight: CGFloat = 0.5 {
        didSet {
            setLayout()
        }
    }
    
    @IBInspectable var sColor: UIColor? = UIColor.darkGray {
        didSet {
            setLayout()
        }
    }
    
    @IBInspectable var sOpacity: Float = 0.5 {
        didSet {
            setLayout()
        }
    }
    
    @IBInspectable var sRadius: CGFloat = 0.75 {
        didSet {
            setLayout()
        }
    }
    
    @IBInspectable var iCircle: Bool = false {
        didSet {
            setLayout()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setLayout()
    }
    
    private func setLayout() {
        layer.cornerRadius = iCircle ? self.bounds.height * 0.5 : cRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: iCircle ? self.bounds.height * 0.5 : cRadius)
        layer.masksToBounds = false
        layer.shadowColor = sColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
        layer.shadowOpacity = sOpacity
        layer.shadowRadius = sRadius
        layer.shadowPath = shadowPath.cgPath
    }
}
