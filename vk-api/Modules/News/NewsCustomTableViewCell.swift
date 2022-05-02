//
//  NewsCustomTableViewCell.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 05.09.2021.
//

import UIKit

class NewsCustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var newsTextLabel: UILabel!
    @IBOutlet weak var newsDateLabel: UILabel!
    @IBOutlet weak var newsNameLabel: UILabel!
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var photoGroupImage: UIImageView!
    
    
    func clearCell() {
        
        newsTextLabel.text = nil
        newsDateLabel.text = nil
        newsNameLabel.text = nil
        photoImage.image = nil
        photoGroupImage.image = nil
        
    }
    
    override func prepareForReuse() {
        clearCell()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clearCell()
    }
}


