//
//  PhotosFriendCollectionViewCell.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 22.08.2021.
//

import UIKit
import SDWebImage

class PhotosFriendCollectionViewCell: UICollectionViewCell {
    
    var photosFriendImage: PhotosModel!
    
    
    func setup() {
        
    }
    
    
    func clearCell() {
        
    }
    
    
    override func prepareForReuse() {
        clearCell()
    }
    
    
    func configure() {
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        clearCell()
    }
    
}
