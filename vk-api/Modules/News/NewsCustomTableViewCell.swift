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
    @IBOutlet weak var newsCommentsLabel: UILabel!
    @IBOutlet weak var photoImage: UIImageView!
    
    func setup() {
        
    }
    
    
    func clearCell() {
        
    }
    
    
    override func prepareForReuse() {
        clearCell()
    }
    
    
    func configure() {
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        clearCell()
    }
}


