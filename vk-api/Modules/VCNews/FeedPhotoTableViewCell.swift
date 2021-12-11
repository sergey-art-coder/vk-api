//
//  FeedPhotoTableViewCell.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 03.11.2021.
//

import UIKit

class FeedPhotoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var feedPhotoImageView: UIImageView!
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func clearCell() {
        
        feedPhotoImageView.image = nil
    }
    
    func configureFeedPhoto(url: String?) {
        
        guard let url = url else { return }
        feedPhotoImageView.asyncLoadImageUsingCache(withUrl: url, withImageViewer: true)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        clearCell()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clearCell()
    }
}
