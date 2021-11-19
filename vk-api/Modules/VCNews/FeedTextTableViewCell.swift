//
//  FeedTextTableViewCell.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 03.11.2021.
//

import UIKit
import ActiveLabel

class FeedTextTableViewCell: UITableViewCell {
    
    @IBOutlet weak var feedTextLabel: ActiveLabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func clearCell() {
        
        feedTextLabel.text = nil
    }
    
    func configureFeedText(text: String?) {
        
        guard let text = text else { return }
        
        feedTextLabel.customize { label in
            
            label.text = text
            
            let vkHashTag = ActiveType.custom(pattern: #"#\S+"#)
            
            label.urlMaximumLength = 22
            label.enabledTypes = [.url, vkHashTag]
            
            label.customColor[vkHashTag] = activeVkHashTagColor
            label.customSelectedColor[vkHashTag] = activeVkHashTagColorSelected
            
            label.URLColor = activeURLColor
            label.URLSelectedColor = activeURLColorSelected
            
            label.handleURLTap { url in
                UIApplication.shared.open(url)
            }
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
