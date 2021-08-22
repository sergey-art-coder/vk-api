//
//  Friends.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 20.08.2021.
//

import Foundation

// MARK: - FriendsResponse
// получаем объект FriendsResponse и наследуемся от Codable
class FriendsResponse: Codable {
    let response: FriendsModel
}

// MARK: - Response
// в нутри FriendsResponse будет объект Friends
class FriendsModel: Codable {
    let count: Int
    let items: [FriendModel]
}

// MARK: - Item
class FriendModel: Codable {
    let id: Int
    let lastName, trackCode, firstName: String
    let photo100: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case lastName = "last_name"
        case trackCode = "track_code"
        case firstName = "first_name"
        case photo100 = "photo_100"
    }
}
