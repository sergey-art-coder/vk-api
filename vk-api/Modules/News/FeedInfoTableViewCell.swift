//
//  NewsCustomTableViewCell.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 05.09.2021.
//

import UIKit
import Alamofire

class FeedInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var feedUserGroupImageView: UIImageView!
    @IBOutlet weak var feedIUserGroupNameLabel: UILabel!
    @IBOutlet weak var feedPostDateLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func clearCell() {
        
        feedUserGroupImageView.image = nil
        feedIUserGroupNameLabel.text = nil
        feedPostDateLabel.text = nil
        
    }
    
    func configureFeedInfo(feedUserGroupImage: UIImage?, feedIUserGroupName: String, feedPostDate: Double) {
        
        feedUserGroupImageView.image = feedUserGroupImage
        feedIUserGroupNameLabel.text = feedIUserGroupName
        feedPostDateLabel.text = feedPostDate.getDateStringFromUTC()
    }
    
    //    func configureGroup(newsName: String, photoGroup: UIImage?, newsNameProfiles: String, photoProfiles: UIImage?) {
    //
    //        if newsName != "" && photoGroup != nil {
    //            newsNameLabel.text = newsName
    //            photoGroupImage.image = photoGroup
    //
    //        } else {
    //
    //            newsNameLabel.text = newsNameProfiles
    //            photoGroupImage.image = photoProfiles
    //        }
    //    }
    
    
    override func prepareForReuse() {
        clearCell()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clearCell()
    }
}

