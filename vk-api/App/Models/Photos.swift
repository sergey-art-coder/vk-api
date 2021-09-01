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
    @objc dynamic var hastags: String?
    @objc dynamic var fotosId: String?
    @objc dynamic var ownerid: String?
    @objc dynamic var photo1280: String?
    @objc dynamic var photo130: String?
    @objc dynamic var photo2560: String?
    @objc dynamic var photo604: String?
    @objc dynamic var photo75: String?
    @objc dynamic var hoto807: String?
    @objc dynamic var postid: String?
    
    convenience required init(data: JSON) {
        self.init()
        
        self.albumid = data.album_id.string
        self.hastags = data.has_tags.string
        self.fotosId = data.id.string
        self.ownerid = data.owner_id.string
        self.photo1280 = data.photo_1280.string
        self.photo130 = data.photo_130.string
        self.photo2560 = data.photo_2560.string
        self.photo604 = data.photo_604.string
        self.photo75 = data.photo_75.string
        self.hoto807 = data.hoto_807.string
        self.postid = data.post_id.string
    }
}
