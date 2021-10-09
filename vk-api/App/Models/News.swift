//
//  News.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 04.09.2021.
//

//   let newsResponse = try? newJSONDecoder().decode(NewsResponse.self, from: jsonData)

import Foundation

// MARK: - NewsResponse
struct NewsResponse: Codable {
    let response: NewsModel
}

// MARK: - Response
struct NewsModel: Codable {
    let items: [NewsFeedModel]
    let groups: [Group]
    let profiles: [Profile]
    let nextFrom: String
    
    enum CodingKeys: String, CodingKey {
        case items, groups, profiles
        case nextFrom = "next_from"
    }
}

// MARK: - Group
struct Group: Codable {
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

// MARK: - ResponseItem
struct NewsFeedModel: Codable {
    let photos: Photos
    let postID, sourceID: Int
    let type: String
    let date: Int
    
    enum CodingKeys: String, CodingKey {
        case photos
        case postID = "post_id"
        case sourceID = "source_id"
        case type, date
    }
}

// MARK: - Photos
struct Photos: Codable {
    let count: Int
    let items: [PhotosNewsItem]
}

// MARK: - PhotosItem
struct PhotosNewsItem: Codable {
    let id: Int
    let comments: Comments
    let likes: Likes
    let accessKey: String
    let userID: Int
    let reposts: Reposts
    let date, ownerID: Int
    let postID: Int?
    let text: String
    let canRepost: Int
    let sizes: [SizeNews]
    let hasTags: Bool
    let albumID, canComment: Int
    
    enum CodingKeys: String, CodingKey {
        case id, comments, likes
        case accessKey = "access_key"
        case userID = "user_id"
        case reposts, date
        case ownerID = "owner_id"
        case postID = "post_id"
        case text
        case canRepost = "can_repost"
        case sizes
        case hasTags = "has_tags"
        case albumID = "album_id"
        case canComment = "can_comment"
    }
}

// MARK: - Comments
struct Comments: Codable {
    let count: Int
}

// MARK: - Likes
struct Likes: Codable {
    let userLikes, count: Int
    
    enum CodingKeys: String, CodingKey {
        case userLikes = "user_likes"
        case count
    }
}

// MARK: - Reposts
struct Reposts: Codable {
    let count, userReposted: Int
    
    enum CodingKeys: String, CodingKey {
        case count
        case userReposted = "user_reposted"
    }
}

// MARK: - Size
struct SizeNews: Codable {
    let width, height: Int
    let url: String
    let type: TypeEnumNews
}

enum TypeEnumNews: String, Codable {
    case m = "m"
    case o = "o"
    case p = "p"
    case q = "q"
    case r = "r"
    case s = "s"
    case w = "w"
    case x = "x"
    case y = "y"
    case z = "z"
}

// MARK: - Profile
struct Profile: Codable {
    let canAccessClosed: Bool
    let screenName: String
    let online, id: Int
    let photo100: String
    let lastName: String
    let photo50: String
    let onlineInfo: OnlineInfo
    let sex: Int
    let isClosed: Bool
    let firstName: String
    
    enum CodingKeys: String, CodingKey {
        case canAccessClosed = "can_access_closed"
        case screenName = "screen_name"
        case online, id
        case photo100 = "photo_100"
        case lastName = "last_name"
        case photo50 = "photo_50"
        case onlineInfo = "online_info"
        case sex
        case isClosed = "is_closed"
        case firstName = "first_name"
    }
}

// MARK: - OnlineInfo
struct OnlineInfo: Codable {
    let visible, isMobile, isOnline: Bool
    
    enum CodingKeys: String, CodingKey {
        case visible
        case isMobile = "is_mobile"
        case isOnline = "is_online"
    }
}
