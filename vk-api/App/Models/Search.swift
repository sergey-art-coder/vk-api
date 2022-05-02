//
//  Search.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 04.09.2021.
//

import Foundation
import RealmSwift
import DynamicJSON

//   let searchGroupResponse = try? newJSONDecoder().decode(SearchGroupResponse.self, from: jsonData)

// MARK: - SearchGroupResponse
class SearchGroupResponse: Codable {
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
    //    @objc dynamic var type: TypeEnum
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
        //        case type
        case screenName = "screen_name"
        case name
        case isClosed = "is_closed"
    }
}

