//
//  CustomCollectionViewCell.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 07.09.2021.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    func clearCell() {
        photoImageView.image = nil
    }
    
    // функция prepareForReuse вызывается автоматически при переиспользовании ячейки
    override func prepareForReuse() {
        clearCell()
    }
    
    // вызывается один раз, это инициализация ячейки
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        clearCell()
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        
        return photoImageView
    }
}


