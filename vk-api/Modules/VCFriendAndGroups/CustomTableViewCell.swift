//
//  FriendsTableViewCell.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 06.09.2021.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    
    func clearCell() {
        nameLabel.text = nil
        avatarImage.image = nil
    }
    
    // функция prepareForReuse вызывается автоматически при переиспользовании ячейки
    override func prepareForReuse() {
        clearCell()
    }
    
    // вызывается один раз, это инициализация ячейки
    override func awakeFromNib() {
        super.awakeFromNib()
        
        clearCell()
    }
}

