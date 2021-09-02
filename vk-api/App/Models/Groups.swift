//
//  Groups.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 20.08.2021.
//

//   let groupsResponse = try? newJSONDecoder().decode(GroupsResponse.self, from: jsonData)

import Foundation
import RealmSwift
import DynamicJSON

// MARK: - GroupsResponse
class GroupsResponse: Codable {
    let response: GroupsModel
}

// MARK: - Response
class GroupsModel: Codable {
    let count: Int
    let items: [GroupModel]
}

// MARK: - Item
class GroupModel: Object, Codable {
    @objc dynamic var isMember, id: Int
    @objc dynamic var photo100: String
    @objc dynamic var isAdvertiser, isAdmin: Int
    @objc dynamic var photo50, photo200: String
    //   @objc dynamic var type: TypeEnum
    @objc dynamic var screenName, name: String
    @objc dynamic var isClosed: Int
    
    enum CodingKeys: String, CodingKey {
        case isMember = "is_member"
        case id
        case photo100 = "photo_100"
        case isAdvertiser = "is_advertiser"
        case isAdmin = "is_admin"
        case photo50 = "photo_50"
        case photo200 = "photo_200"
        // case type
        case screenName = "screen_name"
        case name
        case isClosed = "is_closed"
    }
}

enum TypeEnum: String, Codable {
    case group = "group"
    case page = "page"
}

// =========================================getSearchGroups================================================================================


class SearchGroupModel: Object {
    @objc dynamic var searchId: String?
    @objc dynamic var isClosed: String?
    @objc dynamic var isAdvertiser: String?
    @objc dynamic var searchType: String?
    @objc dynamic var isMember: String?
    @objc dynamic var photo50: String?
    @objc dynamic var photo200: String?
    @objc dynamic var searchName: String?
    @objc dynamic var screenName: String?
    
    convenience required init(data: JSON) {
        self.init()
        self.searchId = data.id.string
        self.isClosed = data.is_closed.string
        self.isAdvertiser = data.is_advertiser.string
        self.searchType = data.type.string
        self.isMember = data.is_member.string
        self.photo50 = data.photo_50.string
        self.photo200 = data.photo_200.string
        self.searchName = data.name.string
        self.screenName = data.screen_name.string
    }
}
