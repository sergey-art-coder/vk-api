//
//  ViewWithShadow.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 22.05.2021.
//

import UIKit

// делаем тень

@IBDesignable class ViewWithShadow: UIView {
   
    @IBInspectable var shadowColor: UIColor = .black {
        didSet {
            layer.shadowColor = shadowColor.cgColor
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0.5 {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 8 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
   
    //отступ
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0, height: 0) {
        didSet {
            layer.shadowOffset = shadowOffset
        }
    }
    
}
