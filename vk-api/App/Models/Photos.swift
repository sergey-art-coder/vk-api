//
//  Photos.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 20.08.2021.
//

import Foundation
import RealmSwift
import DynamicJSON

class PhotoModel: Object {
    @objc dynamic var albumid: String?
    @objc dynamic var fotosId: String?
    @objc dynamic var fotosDate: String?
    @objc dynamic var fotosText: String?
    @objc dynamic var fotosSizes: String?
    @objc dynamic var fotosWidth: String?
    @objc dynamic var fotosHeight: String?
    @objc dynamic var fotosUrl: String?
    @objc dynamic var fotosType: String?
    
    convenience required init(data: JSON) {
        self.init()
        
        self.albumid = data.album_id.string
        self.fotosId = data.id.string
        self.fotosDate = data.date.string
        self.fotosText = data.text.string
        let photoUrl = data["sizes"].last.last
        self.fotosSizes = photoUrl.string
        self.fotosWidth = data.width.string
        self.fotosHeight = data.height.string
        self.fotosUrl = data.url.string
        self.fotosType = data.type.string
        
//        print("==============")
//        print(photoUrl as Any)
//        print("==============")
//        print(fotosSizes as Any)
    }
}
