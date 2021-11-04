//
//  FeedPhotoTableViewCell.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 03.11.2021.
//

import UIKit
import Alamofire

class FeedPhotoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var feedPhotoImageView: UIImageView!
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func clearCell() {
        
        feedPhotoImageView.image = nil
        
    }
    
    func configureFeedPhoto(feedPhotoImage: UIImage) {
        
        
        feedPhotoImageView.image = feedPhotoImage
        
    }
    
    
    override func prepareForReuse() {
        clearCell()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clearCell()
    }
    
}
