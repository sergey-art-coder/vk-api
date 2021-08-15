//
//  RoundedImageView.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 21.05.2021.
//

import UIKit

// что бы изменения класса изменялись в storyboard
@IBDesignable class RoundedImageViev: UIImageView {
    let testView = UIView()
    // @IBInspectable отвечает за радиус краев
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            
            // masksToBounds - обрез картинки по ее размерам. Если cornerRadius > 0 то обрезаем картинку по краям, а если cornerRadius = 0 то не обрезаем картинку по краям
            layer.masksToBounds = cornerRadius > 0
            layer.cornerRadius = cornerRadius
            
        }
    }
}
