//
//  Photos.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 20.08.2021.
//

//   let photosResponse = try? newJSONDecoder().decode(PhotosResponse.self, from: jsonData)

import Foundation

// MARK: - PhotosResponse
class PhotosResponse: Codable {
    let response: PhotosModel
}

// MARK: - Response
class PhotosModel: Codable {
    let count: Int
    let items: [PhotoModel]
}

// MARK: - Item
class PhotoModel: Codable {
    let id: Int
    let photo2560, photo807, photo1280: String
    let width: Int
    let likes: Likes
    let photo604: String
    let reposts: Reposts
    let photo130: String
    let date, ownerID, postID, height: Int
    let text: String
    let hasTags: Bool
    let albumID: Int
    let photo75: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case photo2560 = "photo_2560"
        case photo807 = "photo_807"
        case photo1280 = "photo_1280"
        case width, likes
        case photo604 = "photo_604"
        case reposts
        case photo130 = "photo_130"
        case date
        case ownerID = "owner_id"
        case postID = "post_id"
        case height, text
        case hasTags = "has_tags"
        case albumID = "album_id"
        case photo75 = "photo_75"
    }
}

// MARK: - Likes
class Likes: Codable {
    let userLikes, count: Int
    
    enum CodingKeys: String, CodingKey {
        case userLikes = "user_likes"
        case count
    }
}

// MARK: - Reposts
class Reposts: Codable {
    let count: Int
}
