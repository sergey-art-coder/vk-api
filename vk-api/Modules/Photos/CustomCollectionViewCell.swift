//
//  CustomCollectionViewCell.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 07.09.2021.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var photoImageView: UIImageView!

    // первоначальные настройки ячейки
    func setup() {
        
    }
    
    // очищаем
    func clearCell() {
        photoImageView.image = nil
    }
   
    // функция prepareForReuse вызывается автоматически при переиспользовании ячейки
    override func prepareForReuse() {
        clearCell()
    }
    
    // передаем параметры для настройки содержимого нашей ячейки
    func configure() {
        
    }
    
    // вызывается один раз, это инициализация ячейки
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        clearCell()
    }
}
    

