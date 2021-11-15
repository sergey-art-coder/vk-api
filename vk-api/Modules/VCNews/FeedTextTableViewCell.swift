//
//  FeedTextTableViewCell.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 03.11.2021.
//

import UIKit

class FeedTextTableViewCell: UITableViewCell {
    
    @IBOutlet weak var feedTextLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func clearCell() {
        
        feedTextLabel.text = nil
    }
    
    func configureFeedText(feedText: String) {
        
        feedTextLabel.text = feedText
    }
    
    override func prepareForReuse() {
        clearCell()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clearCell()
    }
}
