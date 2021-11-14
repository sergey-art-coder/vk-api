//
//  Friends.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 20.08.2021.
//

import Foundation
import RealmSwift

// MARK: - FriendsResponse
class FriendsResponse: Codable {
    let response: FriendsModel
}

// MARK: - Response
class FriendsModel: Codable {
    let count: Int
    let items: [FriendModel]
}

// MARK: - Item
class FriendModel: Object, Codable {
    @objc dynamic var id: Int
    @objc dynamic var lastName, trackCode, firstName: String
    @objc dynamic var photo100: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case lastName = "last_name"
        case trackCode = "track_code"
        case firstName = "first_name"
        case photo100 = "photo_100"
    }
}
