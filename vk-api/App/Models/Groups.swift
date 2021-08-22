//
//  Groups.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 20.08.2021.
//

//   let groupsResponse = try? newJSONDecoder().decode(GroupsResponse.self, from: jsonData)

import Foundation
import RealmSwift

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

//   let searchGroupsResponse = try? newJSONDecoder().decode(SearchGroupsResponse.self, from: jsonData)

// MARK: - SearchGroupsResponse
class SearchGroupsResponse: Codable {
    let response: SearchGroupsModel
}

// MARK: - Response
class SearchGroupsModel: Codable {
    let count: Int
    let items: [SearchGroupModel]
}

// MARK: - Item
class SearchGroupModel: Object, Codable {
    @objc dynamic var isMember, id: Int
    @objc dynamic var photo100: String
    @objc dynamic var isAdvertiser, isAdmin: Int
    @objc dynamic var photo50, photo200: String
    //   @objc dynamic var type: TypeEnumSearch
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
        //   case type
        case screenName = "screen_name"
        case name
        case isClosed = "is_closed"
    }
}

enum TypeEnumSearch: String, Codable {
    case event = "event"
    case group = "group"
    case page = "page"
}
