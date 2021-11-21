//
//  PhotosFriendCollectionViewCell.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 22.08.2021.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImage: UIImageView!
    
    func clearCell() {
        
        photoImage.image = nil
    }
    
    override func prepareForReuse() {
        clearCell()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        clearCell()
    }
}
