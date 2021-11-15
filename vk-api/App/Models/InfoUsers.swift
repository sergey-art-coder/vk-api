//
//  User.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 14.11.2021.
//

import Foundation

// MARK: - InfoUsersResponse
struct InfoUsersResponse: Codable {
    let response: [InfoUsersModel]
}

// MARK: - Response
struct InfoUsersModel: Codable {
    let canAccessClosed: Bool
    let city, country: City
    let id, hasPhoto: Int
    let lastName: String
    let photo200: String?
    let isClosed: Bool
    let firstName: String

    enum CodingKeys: String, CodingKey {
        case canAccessClosed = "can_access_closed"
        case city, country, id
        case hasPhoto = "has_photo"
        case lastName = "last_name"
        case photo200 = "photo_200"
        case isClosed = "is_closed"
        case firstName = "first_name"
    }
}

// MARK: - City
struct City: Codable {
    let id: Int
    let title: String
}

