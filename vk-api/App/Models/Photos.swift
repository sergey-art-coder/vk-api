//
//  Photos.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 20.08.2021.
//

import Foundation

//   let photosResponse = try? newJSONDecoder().decode(PhotosResponse.self, from: jsonData)

import Foundation

// MARK: - PhotosResponse
struct PhotosResponse: Codable {
    let response: PhotosModel
}

// MARK: - Response
struct PhotosModel: Codable {
    let count: Int
    let items: [PhotoModel]
}

// MARK: - Item
struct PhotoModel: Codable {
    let albumID, id, date: Int
    let text: String
    let sizes: [Size]
    let hasTags: Bool
    let ownerID: Int
    let postID: Int?

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case id, date, text, sizes
        case hasTags = "has_tags"
        case ownerID = "owner_id"
        case postID = "post_id"
    }
}

// MARK: - Size
struct Size: Codable {
    let width, height: Int
    let url: String
    let type: String
}

