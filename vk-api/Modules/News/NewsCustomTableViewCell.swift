//
//  NewsCustomTableViewCell.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 05.09.2021.
//

import UIKit
import Alamofire

class NewsCustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var newsTextLabel: UILabel!
    @IBOutlet weak var newsDateLabel: UILabel!
    @IBOutlet weak var photoImage: UIImageView!
    
    @IBOutlet weak var newsNameLabel: UILabel!
    @IBOutlet weak var photoGroupImage: UIImageView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func clearCell() {
        
        newsTextLabel.text = nil
        newsDateLabel.text = nil
        photoImage.image = nil
        newsNameLabel.text = nil
        photoGroupImage.image = nil
        
    }
    
    func configureNewsFeedModel(imageNews: UIImage?, newsText: String, postDate: Double) {
        
        photoImage.image = imageNews
        newsTextLabel.text = newsText
        
        newsDateLabel.text = postDate.getDateStringFromUTC()
    }
    
    func configureGroup(newsName: String, photoGroup: UIImage?, newsNameProfiles: String, photoProfiles: UIImage?) {
        
        if newsName != "" && photoGroup != nil {
            newsNameLabel.text = newsName
            photoGroupImage.image = photoGroup
            
        } else {
            
            newsNameLabel.text = newsNameProfiles
            photoGroupImage.image = photoProfiles
        }
    }
    
    
    override func prepareForReuse() {
        clearCell()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clearCell()
    }
}


