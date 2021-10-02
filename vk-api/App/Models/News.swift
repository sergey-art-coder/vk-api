//
//  News.swift
//  1|SergeyLyashenko
//
//  Created by Сергей Ляшенко on 05.09.2021.
//

import Foundation
import RealmSwift

//   let newsResponse = try? newJSONDecoder().decode(NewsResponse.self, from: jsonData)

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

// MARK: - Item
struct NewsFeedModel: Codable {
    let donut: Donut
    let comments: Comments
    let canSetCategory, isFavorite: Bool
    let shortTextRate: Double
    let likes: Likes
    let reposts: Reposts
    let type, postType: PostTypeEnum
    let date, sourceID: Int
    let text: String
    let canDoubtCategory: Bool
    let copyHistory: [CopyHistory]?
    let postID: Int
    let postSource: PostSource
    let views: Views
    let attachments: [Attachment]?

    enum CodingKeys: String, CodingKey {
        case donut, comments
        case canSetCategory = "can_set_category"
        case isFavorite = "is_favorite"
        case shortTextRate = "short_text_rate"
        case likes, reposts, type
        case postType = "post_type"
        case date
        case sourceID = "source_id"
        case text
        case canDoubtCategory = "can_doubt_category"
        case copyHistory = "copy_history"
        case postID = "post_id"
        case postSource = "post_source"
        case views, attachments
    }
}

// MARK: - Attachment
struct Attachment: Codable {
    let type: AttachmentType
    let photo: NewsPhoto
}

// MARK: - Photo
struct NewsPhoto: Codable {
    let albumID: Int
    let postID: Int?
    let id, date: Int
    let text: String
    let sizes: [NewsSize]
    let hasTags: Bool
    let ownerID: Int
    let accessKey: String
    let userID: Int?

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case postID = "post_id"
        case id, date, text, sizes
        case hasTags = "has_tags"
        case ownerID = "owner_id"
        case accessKey = "access_key"
        case userID = "user_id"
    }
}

// MARK: - Size
struct NewsSize: Codable {
    let width, height: Int
    let url: String
    let type: SizeType
}

enum SizeType: String, Codable {
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

enum AttachmentType: String, Codable {
    case photo = "photo"
}

// MARK: - Comments
struct Comments: Codable {
    let count, canPost: Int
    let groupsCanPost: Bool

    enum CodingKeys: String, CodingKey {
        case count
        case canPost = "can_post"
        case groupsCanPost = "groups_can_post"
    }
}

// MARK: - CopyHistory
struct CopyHistory: Codable {
    let postSource: PostSource
    let postType: PostTypeEnum
    let id, fromID, date: Int
    let text: String
    let attachments: [Attachment]
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

// MARK: - PostSource
struct PostSource: Codable {
    let type: PostSourceType
    let platform: Platform?
}

enum Platform: String, Codable {
    case android = "android"
    case iphone = "iphone"
}

enum PostSourceType: String, Codable {
    case api = "api"
    case vk = "vk"
}

enum PostTypeEnum: String, Codable {
    case post = "post"
}

// MARK: - Donut
struct Donut: Codable {
    let isDonut: Bool

    enum CodingKeys: String, CodingKey {
        case isDonut = "is_donut"
    }
}

// MARK: - Likes
struct Likes: Codable {
    let canLike, canPublish, count, userLikes: Int

    enum CodingKeys: String, CodingKey {
        case canLike = "can_like"
        case canPublish = "can_publish"
        case count
        case userLikes = "user_likes"
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

enum Text: String, Codable {
    case empty = ""

}

// MARK: - Views
struct Views: Codable {
    let count: Int
}

// MARK: - Profile
struct Profile: Codable {
    let canAccessClosed: Bool?
    let screenName: String?
    let online, id: Int
    let photo100: String
    let lastName: String
    let photo50: String
    let onlineInfo: OnlineInfo
    let sex: Int
    let isClosed: Bool?
    let firstName: String
    let deactivated: String?
    let onlineMobile, onlineApp: Int?

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
        case deactivated
        case onlineMobile = "online_mobile"
        case onlineApp = "online_app"
    }
}

// MARK: - OnlineInfo
struct OnlineInfo: Codable {
    let visible, isMobile, isOnline: Bool
    let appID, lastSeen: Int?

    enum CodingKeys: String, CodingKey {
        case visible
        case isMobile = "is_mobile"
        case isOnline = "is_online"
        case appID = "app_id"
        case lastSeen = "last_seen"
    }
}








//class NewsModel: Object {
//    @objc dynamic var newsType: String?
//    @objc dynamic var newsPost_type: String?
//    @objc dynamic var newsDate: String?
//    @objc dynamic var sourceId: String?
//    @objc dynamic var newsText: String?
//    @objc dynamic var canDoubtCategory: String?
//    @objc dynamic var postId: String?
//    @objc dynamic var postSource: String?
//    @objc dynamic var newsViews: String?
//    @objc dynamic var newsDonut: String?
//    @objc dynamic var newsComments: String?
//    @objc dynamic var newsLikes: String?
//    @objc dynamic var newsReposts: String?
//    @objc dynamic var newsImage: String?
//
//    convenience required init(data: JSON) {
//        self.init()
//
//        self.newsType = data.type.string
//        self.newsPost_type = data.post_type.string
//        self.newsDate = data.date.string
//        self.sourceId = data.source_id.string
//        self.newsText = data.text.string
//        self.canDoubtCategory = data.can_doubt_category.string
//        self.postId = data.post_id.string
//        self.postSource = data.post_source.string
//        self.newsViews = data.views.string
//        self.newsDonut = data.donut.string
//        self.newsComments = data.comments.string
//        self.newsLikes = data.likes.string
//        self.newsReposts = data.reposts.string
//        self.newsImage = data.image.string
//    }
//}
//
