//
//  Search.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 04.09.2021.
//

import Foundation
import RealmSwift
import DynamicJSON

class SearchGroupModel: Object {
    @objc dynamic var isMember: String?
    @objc dynamic var searchId: String?
    @objc dynamic var photo100: String?
    @objc dynamic var isAdvertiser: String?
    @objc dynamic var isAdmin: String?
    @objc dynamic var photo50: String?
    @objc dynamic var photo200: String?
    @objc dynamic var searchType: String?
    @objc dynamic var screenName: String?
    @objc dynamic var searchName: String?
    @objc dynamic var isClosed: String?
    
    convenience required init(data: JSON) {
        self.init()
        
        self.isMember = data.is_member.string
        self.searchId = data.id.string
        self.photo100 = data.photo_100.string
        self.isAdvertiser = data.is_advertiser.string
        self.isAdmin = data.is_admin.string
        self.photo50 = data.photo_50.string
        self.photo200 = data.photo_200.string
        self.searchType = data.type.string
        self.screenName = data.screen_name.string
        self.searchName = data.name.string
        self.isClosed = data.is_closed.string
    }
}
