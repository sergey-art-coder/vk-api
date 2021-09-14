//
//  News.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 05.09.2021.
//

import Foundation
import RealmSwift
import DynamicJSON


//   let newsResponse = try? newJSONDecoder().decode(NewsResponse.self, from: jsonData)
//
// MARK: - NewsResponse
class NewsResponse: Codable {
    let response: News
}

// MARK: - Response
class News: Codable {
    let items: [New]
    let groups: [Group]
    let profiles: [Profile]
    let nextFrom: String

    enum CodingKeys: String, CodingKey {
        case items, groups, profiles
        case nextFrom = "next_from"
    }
}

// MARK: - Group
class Group: Codable {
    let isMember, id: Int
    let photo100: String
    let isAdvertiser, isAdmin: Int
    let photo50, photo200: String
    let type, screenName, name: String
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

// MARK: - Item
class New: Codable {
    let comments: PurpleComments?
    let canSetCategory: Bool?
    let likes: PurpleLikes?
    let reposts: Reposts?
    let type: PostTypeEnum
    let postType: PostTypeEnum?
    let date, sourceID: Int
    let text: Text?
    let canDoubtCategory: Bool?
    let copyHistory: [CopyHistory]?
    let postID: Int
    let postSource: PostSource?
    let attachments: [ItemAttachment]?
    let photos: Photos?

    enum CodingKeys: String, CodingKey {
        case comments
        case canSetCategory = "can_set_category"
        case likes, reposts, type
        case postType = "post_type"
        case date
        case sourceID = "source_id"
        case text
        case canDoubtCategory = "can_doubt_category"
        case copyHistory = "copy_history"
        case postID = "post_id"
        case postSource = "post_source"
        case attachments, photos
    }
}

// MARK: - ItemAttachment
class ItemAttachment: Codable {
    let type: String
    let photo: Photo?
    let video: Video?
}

// MARK: - Photo
class Photo: Codable {
    let id: Int
    let photo2560: String?
    let photo807: String
    let photo1280: String?
    let width: Int
    let accessKey: String
    let photo604, photo130: String
    let date, ownerID: Int
    let text: Text
    let height: Int
    let hasTags: Bool
    let albumID: Int
    let photo75: String
    let long, lat: Double?
    let userID, postID: Int?
    let likes: PhotoLikes?
    let canComment: Int?
    let reposts: Reposts?
    let comments: PhotoComments?
    let canRepost: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case photo2560 = "photo_2560"
        case photo807 = "photo_807"
        case photo1280 = "photo_1280"
        case width
        case accessKey = "access_key"
        case photo604 = "photo_604"
        case photo130 = "photo_130"
        case date
        case ownerID = "owner_id"
        case text, height
        case hasTags = "has_tags"
        case albumID = "album_id"
        case photo75 = "photo_75"
        case long, lat
        case userID = "user_id"
        case postID = "post_id"
        case likes
        case canComment = "can_comment"
        case reposts, comments
        case canRepost = "can_repost"
    }
}

// MARK: - PhotoComments
class PhotoComments: Codable {
    let count: Int
}

// MARK: - PhotoLikes
class PhotoLikes: Codable {
    let userLikes, count: Int

    enum CodingKeys: String, CodingKey {
        case userLikes = "user_likes"
        case count
    }
}

// MARK: - Reposts
class Reposts: Codable {
    let count, userReposted: Int

    enum CodingKeys: String, CodingKey {
        case count
        case userReposted = "user_reposted"
    }
}

enum Text: String, Codable {
    case empty = ""
    case посетилОкеанариум = "Посетил океанариум"
}

// MARK: - Video
class Video: Codable {
    let firstFrame800: String
    let ownerID: Int
    let title: String
    let duration: Int
    let photo320, photo1280, firstFrame1280: String
    let views, canLike, canComment: Int
    let firstFrame130: String
    let date: Int
    let firstFrame160: String
    let id, height: Int
    let trackCode: String
    let width, canAddToFaves: Int
    let accessKey: String
    let comments: Int
    let photo800, photo130: String
    let canSubscribe: Int
    let firstFrame320: String
    let canRepost: Int
    let videoDescription: String

    enum CodingKeys: String, CodingKey {
        case firstFrame800 = "first_frame_800"
        case ownerID = "owner_id"
        case title, duration
        case photo320 = "photo_320"
        case photo1280 = "photo_1280"
        case firstFrame1280 = "first_frame_1280"
        case views
        case canLike = "can_like"
        case canComment = "can_comment"
        case firstFrame130 = "first_frame_130"
        case date
        case firstFrame160 = "first_frame_160"
        case id, height
        case trackCode = "track_code"
        case width
        case canAddToFaves = "can_add_to_faves"
        case accessKey = "access_key"
        case comments
        case photo800 = "photo_800"
        case photo130 = "photo_130"
        case canSubscribe = "can_subscribe"
        case firstFrame320 = "first_frame_320"
        case canRepost = "can_repost"
        case videoDescription = "description"
    }
}

// MARK: - PurpleComments
class PurpleComments: Codable {
    let count, canPost: Int
    let groupsCanPost: Bool

    enum CodingKeys: String, CodingKey {
        case count
        case canPost = "can_post"
        case groupsCanPost = "groups_can_post"
    }
}

// MARK: - CopyHistory
class CopyHistory: Codable {
    let postSource: PostSource
    let postType: PostTypeEnum
    let id, fromID, date: Int
    let text: String
    let attachments: [CopyHistoryAttachment]
    let ownerID: Int

    enum CodingKeys: String, CodingKey {
        case postSource = "post_source"
        case postType = "post_type"
        case id
        case fromID = "from_id"
        case date, text, attachments
        case ownerID = "owner_id"
    }
}

// MARK: - CopyHistoryAttachment
class CopyHistoryAttachment: Codable {
    let type: String
    let video: Video?
    let photo: Photo?
    let doc: Doc?
}

// MARK: - Doc
class Doc: Codable {
    let accessKey: String
    let photo130: String
    let id: Int
    let ext, title: String
    let size, date: Int
    let photo100: String
    let type, ownerID: Int
    let url: String

    enum CodingKeys: String, CodingKey {
        case accessKey = "access_key"
        case photo130 = "photo_130"
        case id, ext, title, size, date
        case photo100 = "photo_100"
        case type
        case ownerID = "owner_id"
        case url
    }
}

// MARK: - PostSource
class PostSource: Codable {
    let type: PostSourceType
    let platform: String?
}

enum PostSourceType: String, Codable {
    case api = "api"
    case vk = "vk"
}

enum PostTypeEnum: String, Codable {
    case photo = "photo"
    case post = "post"
}

// MARK: - PurpleLikes
class PurpleLikes: Codable {
    let canLike, canPublish, count, userLikes: Int

    enum CodingKeys: String, CodingKey {
        case canLike = "can_like"
        case canPublish = "can_publish"
        case count
        case userLikes = "user_likes"
    }
}

// MARK: - Photos
class Photos: Codable {
    let count: Int
    let items: [Photo]
}

// MARK: - Profile
class Profile: Codable {
    let online, id: Int
    let photo100: String
    let lastName: String
    let photo50: String
    let onlineInfo: OnlineInfo
    let sex: Int
    let screenName: String?
    let firstName: String
    let deactivated: String?

    enum CodingKeys: String, CodingKey {
        case online, id
        case photo100 = "photo_100"
        case lastName = "last_name"
        case photo50 = "photo_50"
        case onlineInfo = "online_info"
        case sex
        case screenName = "screen_name"
        case firstName = "first_name"
        case deactivated
    }
}

// MARK: - OnlineInfo
class OnlineInfo: Codable {
    let visible, isMobile, isOnline: Bool
    let lastSeen, appID: Int?

    enum CodingKeys: String, CodingKey {
        case visible
        case isMobile = "is_mobile"
        case isOnline = "is_online"
        case lastSeen = "last_seen"
        case appID = "app_id"
    }
}
