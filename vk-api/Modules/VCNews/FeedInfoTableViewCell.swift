//
//  NewsCustomTableViewCell.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 05.09.2021.
//

import UIKit

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
    
    func configureFeedInfo(profiles: Profile? = nil, groups: Group? = nil, feedPostDate: Double) {
        
        if let group = groups {
            
            feedIUserGroupNameLabel.text = group.name
            feedUserGroupImageView.asyncLoadImageUsingCache(withUrl: group.photo100)
            
        } else if let profile = profiles {
            
            feedIUserGroupNameLabel.text = "\(profile.firstName) \(profile.lastName)"
            feedUserGroupImageView.asyncLoadImageUsingCache(withUrl: profile.photo100)
        }
        
        feedPostDateLabel.text = feedPostDate.getRelativeDateStringFromUTC()
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


