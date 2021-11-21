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
    
    func configureFeedText(text: String?, expanded: Bool, readMoreHandler: @escaping () -> ()) {
        
        guard let text = text else { return }
        
        feedTextLabel.customize { label in
            
            if text.byWords.count > maxWordsCount && !expanded {
                
                label.text = String(describing: text.firstLine!)
                label.text! += "\n\n" + readMore
            } else {
                label.text = text
            }
            let vkHashTag = ActiveType.custom(pattern: #"#\S+"#)
            let readMoreType = ActiveType.custom(pattern: readMore)
            
            label.urlMaximumLength = 22
            label.enabledTypes = [.url, vkHashTag, readMoreType]
            
            label.customColor[vkHashTag] = activeHashTagColor
            label.customSelectedColor[vkHashTag] = activeHashTagColorSelected
            
            label.customColor[readMoreType] = activeURLColor
            label.customSelectedColor[readMoreType] = activeURLColorSelected
            
            label.URLColor = activeURLColor
            label.URLSelectedColor = activeURLColorSelected
            
            label.handleURLTap { url in
                UIApplication.shared.open(url)
            }
            
            label.handleCustomTap(for: readMoreType) { _ in
                label.text = text
                readMoreHandler()
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
