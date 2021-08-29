//
//  Photos.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 20.08.2021.
//

//   let photosResponse = try? newJSONDecoder().decode(PhotosResponse.self, from: jsonData)

import Foundation
import RealmSwift

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
class PhotoModel: Object, Codable {
    @objc dynamic var id: Int
    @objc dynamic var photo2560, photo807, photo1280: String
    @objc dynamic var width: Int
    @objc dynamic var photo604, photo130: String
    @objc dynamic var date, ownerID, postID, height: Int
    @objc dynamic var text: String
    @objc dynamic var hasTags: Bool
    @objc dynamic var albumID: Int
    @objc dynamic var photo75: String

    enum CodingKeys: String, CodingKey {
        case id
        case photo2560 = "photo_2560"
        case photo807 = "photo_807"
        case photo1280 = "photo_1280"
        case width
        case photo604 = "photo_604"
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
