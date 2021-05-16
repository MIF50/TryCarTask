//
//  UIView+Ext.swift
//  TryCarTask
//
//  Created by Mohamed Ibrahim on 5/14/21.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView ...) {
        views.forEach { addSubview($0) }
    }
}

