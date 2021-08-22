//
//  SearchGroups.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 20.08.2021.
//

//   let searchGroupsResponse = try? newJSONDecoder().decode(SearchGroupsResponse.self, from: jsonData)

import Foundation

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
class SearchGroupModel: Codable {
    let isMember, id: Int
    let photo100: String
    let isAdvertiser, isAdmin: Int
    let photo50, photo200: String
    let type: TypeEnumSearch
    let screenName, name: String
    let isClosed: Int
    
    enum CodingKeys: String, CodingKey {
        case isMember = "is_member"
        case id
        case photo100 = "photo_100"
        case isAdvertiser = "is_advertiser"
        case isAdmin = "is_admin"
        case photo50 = "photo_50"
        case photo200 = "photo_200"
        case type
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
